Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D3FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:40:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5525C20865
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="II/sswln";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ms1vq/Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5525C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/y1jZlXv4uEbE9/zXFYomhvl3tWSV6yr4oBuDfr2UhM=; b=II/sswlnA8hC9p
	XXxx9Pkfy5vnfhGZa2fPWY19oUnInAUhKV9Npvjh+rWikluNshba/297jeDkjKQIycmd9yKMsO7r7
	mc/bIsgn+KUeTFCnId9g+BzTy5xH5UfBHs7BdL9OFF4ao3+MoKOyV3fo2v58BoBySVHjmrMlPuPOT
	MgeIL8eBFuo3Eof00AezdFbl2TloChlZI3SFlvKrdddAmL8Phng9rYohtw+XuOn+X9+LhiEHuli+E
	sWFyhJU08nKDZQyjFqkJZHL98UhrsBGPHb6x81iGQmiqoEyQ+MagNA5CuWmh1qu0JsxZkx4SuijwG
	+W4LQ91MB4j++RyR9ZTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWH6a-0007Kp-U6; Mon, 10 Dec 2018 08:39:56 +0000
Received: from mail-eopbgr130075.outbound.protection.outlook.com
 ([40.107.13.75] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWH6I-00078z-Dj; Mon, 10 Dec 2018 08:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsLVtTxUpVSl5rRZKCHlqODROhV+UKxNSwZj+pFn00M=;
 b=Ms1vq/RnSgC+yk8fqnYjkIPHrFXDigLXLx9yQI7cJvP3jFbklMOKk3MURA3EQvdt4hOgXObbDDNSMqpMB2brRrLnjAd8dEo0T/e2LZSXnrFQ4VcBM7JlK1a9IZoxQvJ/suhQUR1tkyWaLpcBDsCVdYIEPKYqwntvUme9yGy6868=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5824.eurprd04.prod.outlook.com (20.178.204.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 08:39:20 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:39:20 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: RE: [PATCH v5 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v5 0/7] spi: add support for octal mode
Thread-Index: AQHUiuOjeSgB/5zRPUqi536teiWNPKVsvNiAgANQIQCAAA5HAIABBArQgAApmQCAAABNcIAA5e8AgAU4I4CAAEXYAIAAAELw
Date: Mon, 10 Dec 2018 08:39:20 +0000
Message-ID: <VI1PR04MB572609DBC52F7496A656915E99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
 <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206202956.GG3084@sirena.org.uk>
 <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210092208.0971c3be@bbrezillon>
In-Reply-To: <20181210092208.0971c3be@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5824;
 6:bv0j2lF0ofGLcS8qRy5Fxq1rsshZS4fMA+1CGdh7QNDlgwpho6AzRnUfjOUAh8el3lBUiXKVPMYT2Dn806nsgqWYCunInegrrdrhzfshvFqXfF+p0jmqgtJlhh0jMIm8sn8aHm06suyZfA2KsjJ0R+ARjVoSGQ3NMbcmVN57bwCyf8QSuI9IepzqMQVWHA7O/o8BhvRITy2XY6JGq0NLAKQ/XYAnzQAqULJo0ZoklmpO2nYkMlYeRPkEb+JbJekjrDPjmjCRfzG7qjrboniBbP6c0feGbf1d7A0GZh6qXvDuyWYVy7V4aNGim74hNf0vaRvq/PtLoDmw2l8PrqZMTEldFMeFg7SNQjdZvxQSDgMcJwmgzHFnAg/w0wqX5AlnJYq4maB1lPpCAnJ632g95HnAj0bvdA29UD7J9j2G0VMlNcdyVD46/N+QygOG6XoQcqppll5wD6HtQROtykPe7Q==;
 5:t3orbg8NxcIVwbbIWopRdeB1NxfNetaDs5OVgkx99I3JGBRPqne52iesqnQnoR9IJL2IQLeGSbMzUhGUsdkzenEEnm1nyfta0JYosZbdf4s4uWoX/IEoGmMKpJ0kdGxqMSlo9tIbIY1aymdWOBKOOSXjlvEExKnFXYRhlmJB2+Q=;
 7:Jcgupdc/sRyPV5Yx3fajTzYvDOzzSDxrHcY0xyZizXN40A669YLYFvqGhYhDtluNi7PA+XuQKa6Pwvw34C4Og03s2+x7bA6uyzU+dZ1mS1qeGgWYjwDppeHZtej9nlcVR658bHqWA+MkoTpdDKNDjQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0b2b4df8-ecb2-4057-38bd-08d65e7afaa0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5824; 
x-ms-traffictypediagnostic: VI1PR04MB5824:
x-microsoft-antispam-prvs: <VI1PR04MB582417E930EA6C44F1E6DA6599A50@VI1PR04MB5824.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5824; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5824; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(13464003)(189003)(199004)(71200400001)(71190400001)(53936002)(99286004)(7416002)(2906002)(6506007)(53546011)(6116002)(6436002)(55236004)(3846002)(97736004)(7696005)(55016002)(14454004)(6306002)(76176011)(9686003)(68736007)(316002)(78486014)(478600001)(86362001)(93886005)(6246003)(39060400002)(54906003)(4326008)(966005)(66066001)(7736002)(33656002)(305945005)(8676002)(81166006)(74316002)(5660300001)(8936002)(81156014)(229853002)(446003)(11346002)(26005)(106356001)(256004)(102836004)(105586002)(486006)(6916009)(476003)(25786009)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5824;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KUKoNFhLaTovnE+ogNOysOrmvcAiWuTcoov/b+JJuuRC75CCIHngZln6gNukeTf4BA/TNFXV/OCWwQ1mKTheJ4pbTPT/ynXMz7RIvpsCX+UEtIn65rt4qcCQWvA7SFLDs/eogLNWKmNPMvnAz29STGjtepbSlmU1NIX/Mv/DjLt3SVLj7ZfEDyRpSQcotGMsC4DrRoqWYqgth5PWQJaEOqg0/U7kt3eZFM050SlTj4P+Zwx9rvrlYRFRWdzJ+2yPZs/t8pvELGWqzFoXDgHirZbk+miZG0Qw0svdmv+51EFdPgTedCQNlVuz19R1r12i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2b4df8-ecb2-4057-38bd-08d65e7afaa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:39:20.1958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_003940_859180_B9F93B2B 
X-CRM114-Status: GOOD (  16.54  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Vignesh R <vigneshr@ti.com>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 Mark Brown <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

Sorry for confusion.

My intention was just to point to the correct patch number only. Earlier you have asked Mark to pick the patch [1] but that patch number was not correct.

[1] https://lkml.org/lkml/2018/12/5/758

--
Regards
Yogesh Gaur

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 1:52 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>; Vignesh R <vigneshr@ti.com>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
> 
> Hi Yogesh,
> 
> On Mon, 10 Dec 2018 04:13:28 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi Mark,
> >
> > Patch has been resend [1], this patch is depends on the series of patch[2] and
> this series has been applied by Boris already.
> 
> You're still not asking the right person. Every patches touching things in
> drivers/mtd/ should be taken by me (or another MTD maintainer), and patches
> touching things in drivers/spi/ should be taken by Mark. So, the patch you're
> pointing to should be applied by me. Plus, I told you I would apply it after 4.21-
> rc1 because I don't want to deal with the mtd -> spi dependency.
> 
> Please be patient.
> 
> Regards,
> 
> Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
