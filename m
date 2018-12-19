Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA528C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DBA21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mf3gzg5I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZkrAIeux";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kL+oDWfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DBA21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvGY7UIHotqaEM1ZJGb32RnuuphXaRYkfwZ163xc0sw=; b=Mf3gzg5I7Fo/5V
	7eN/q3z7JYt3B0rCtg7mthfW6M1WYwQ+L9ShG2Ma8BvxFiLt/hZXL6W+Hp+RtUPhKLoDU6rh9DnUI
	wnh+abU6ezZywyA81oCCgejx91gQr0BoH97xSh+JWW+f9RvftIrGAliI/PBHtA2jvcNLTLCUwDZ35
	Y9kv9g+I2TfntltRoHYXeez2bZxlfT0TTKOQ0RUH8eutYkbez1rHmeyRuoaFZmwBGZtv3TZ87PqBG
	aJJPeYUDDhaXI705AzMfuHvg65xW4YgC8LPwkjYy1JgHA+JRg2L6N05DiAc7qtUNW8siv7AyL+jBl
	qETSWfBvXpnJwiRrc1Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZ9Y-0003zc-4d; Wed, 19 Dec 2018 10:32:36 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZ96-0003ZT-UH; Wed, 19 Dec 2018 10:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aRZ/+vQjPmNTJTscqXAb/7kIsypq/wZk628PQlnNObc=; b=ZkrAIeuxLt6+CMkj9dVBVbKaEf
 PCR9h55D+lI7vSqkl47BeAxcPMOfEG/GyDBbeRwjqOo5JLbD8CaeAWEnrgF0YRC2eYhVf1OXNcz7q
 MR9FChxRt3mtc85YA6e05cFoydkLCX7hWCwtnsETMpT9KHKWno2RgUZr4lNr59weElEZ+tu7NR5Mz
 mw5unYh0YwNg5RWTxZoPqGakyLLwjOPENYWQH+ryoFaExakci8c6GJ26cBOEqwG5kbw9cS4Wo2jmQ
 B+dMM6v6ZJ8OH2W7z3ReHQNPJtAJZqOieFHNtYx4hpkZwRtgUatcklZ+jV1itrAsbsAevYJmxSNR7
 uc7r7T4w==;
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYsn-0006fI-2q; Wed, 19 Dec 2018 10:15:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRZ/+vQjPmNTJTscqXAb/7kIsypq/wZk628PQlnNObc=;
 b=kL+oDWfiLgpCDEtT0zp0EhwxA3dCgqijjbW4nbl4kY6oMMmQ0bSMJzITSNFdFiAq1WJ0l8WYBYuttNPuvSLKEb8+qLTDANyNH7wxBRCvSN6nVWqUQc4nvMDC1X5pQHZ5BTbtaiNkvct9C+KpPtiG9McW06Xc3dsZL1v4F8Tl9gI=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5854.eurprd04.prod.outlook.com (20.178.204.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 10:15:00 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:15:00 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuOuxIvwGhR/Ik2nR/UOeUIxtaV31PEAgAEp0pCAAD0wAIAMrARQ
Date: Wed, 19 Dec 2018 10:15:00 +0000
Message-ID: <VI1PR04MB5726FBFD2CBEB7A3F0454A5999BE0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
 <VI1PR04MB57264CBB25E2984DF221ED2E99A60@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <141c6d79-ae7a-60aa-865a-f6b6997f8da9@microchip.com>
In-Reply-To: <141c6d79-ae7a-60aa-865a-f6b6997f8da9@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5854;
 6:DO68cWpQL3sX3odPZ3/x47xaHLeCahQlRlmOZKGhgynzliiCMokJZB9GmoYsGeiY1GAG1iTKWG3LLrQv93BCg0amKBar58qAUhVgqSL4JQKsOWrFBGyOm0AIThrL2CYAae/M2U1Kw8VsVApPYuMxWv9Y6wRjfAj66dnI/RsFgRrwM7ILt1IH6q5DJ8NH6NWMuGE55VguAkwf0DihTQ72q7IIgRfU7bqPJHx9NmMbLqODaUZJd0cE5AJYSNUU7l+eOl6S5lsaWaQm75WDIinLBjHdU+Ncnx6bNS8zaleV8ZrDWFmvPV5/dPFdVVdvsTc1gAGhI7jxVTN35Dq6NUU9NQRqCFzGZycPzZ/MRbcDZ9la3zLBZj+McZ4HuBiSnPrj7jVbLkgMwyXYugbYgHGJuttJP6gFaVNqqAwo4rlE53LGhOiRGGd7Gwy5t5mT9hrcson/EZmYDX1xk9xxukYqqw==;
 5:mTVGw6ofEFdFlNkZo/ZkTTYqWHNWTteZ3hNyPQ6nFFqef39Wk5L05yO/WyoP7cXXNSYn3EkcyARFd8oN6O82fxhrAbA7OBSlcvp6U27HS6ncy4J5QKZe5b79n3BA34iQWYmkFx5fBQMt+ha2sbc5dSZOgN4eyHOqlFxzWAry9Dk=;
 7:el9znNj7WELoqFehlncLUYQ8IdLSzuyrVnwZOW/0LZZE+AeE3PcrjgPBSGpLQ4FoYycNx47sDtYEtQBn/UgOdxSLEcDFdteVtLc5mgl1QaCr907OdgwJIOvb5pwy85glG+LaWIoF8b4QkocrGnhwpA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b157a7e7-fdb0-4437-2bae-08d6659ad5ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5854; 
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB5854D026481FCB01EE29CB2599BE0@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5854; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5854; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(13464003)(33656002)(68736007)(256004)(11346002)(446003)(486006)(5660300001)(7736002)(54906003)(110136005)(86362001)(2906002)(229853002)(2201001)(99286004)(6116002)(3846002)(76176011)(102836004)(97736004)(7696005)(186003)(26005)(53546011)(6506007)(39060400002)(305945005)(105586002)(71190400001)(106356001)(81166006)(8936002)(4326008)(55016002)(6306002)(6246003)(9686003)(53936002)(74316002)(8676002)(81156014)(478600001)(66066001)(93886005)(476003)(14454004)(2501003)(316002)(966005)(6436002)(7416002)(25786009)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5854;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ALkl7FWvAoFjFORQj58f90acVNcXBCZ8v2gPToAeCohQJrPpmD5OzO2Fid1ksNtCd2tI/6/r7owSoCtg9BXaD3dOA5SyWHw9YzkQ7Ty1pAl8DdTssUvRkNcoU47Pq3BcfjgdW4WTwPUGJStGvqlcCc/WTsf5bywXIYhVccvG6iIJL/eC5U4SMhNGnq0hNik286/AsAwdmEKNbuRHAw06+uTeSaTYlxGYhb7MVs7FNBcDIEE+pxq3hkwQihGYxs1YOtUimlzVqArYP9m/u6ktjzUBREfegryy5MjWz743MwdbCu3pbKlHF+X10FSdEKPF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b157a7e7-fdb0-4437-2bae-08d6659ad5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:15:00.6960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_051517_149058_37C04487 
X-CRM114-Status: GOOD (  18.00  )
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
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tudor,

> -----Original Message-----
> From: Tudor.Ambarus@microchip.com [mailto:Tudor.Ambarus@microchip.com]
> Sent: Tuesday, December 11, 2018 1:40 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; broonie@kernel.org;
> marek.vasut@gmail.com; vigneshr@ti.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
> commands
> 
> Hi,
> 
> On 12/11/2018 06:55 AM, Yogesh Narayan Gaur wrote:
> > Thus would going to modify the condition check as below, so that SFDP
> parsing would also be performed when SPI_NOR_OCTAL_READ is set. Correct?
> >
> >         if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> >              SPI_NOR_OCTAL_READ)) && !(info->flags &
> > SPI_NOR_SKIP_SFDP)) {
> 
> Yes, this is what I was suggesting. On a second thought, we haven't added yet
> support for parsing sfdp to get the octal mode info, so the parsing will be done
> gratuitously. Let's drop this change and add it when adding support for parsing
> octal mode info from sfdp. I'll prepare a patch for this.
> 
> Please rebase on top of spi-nor/next, s/octo/octal in spi-nor.h and correct your
> S-o-b tag and you'll have my R-b tag.
> 
Next version, v6, sent for review[1].
Sorry for late reply, was on leave.

--
Regards
Yogesh Gaur

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=82815

> Thanks Yogesh,
> ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
