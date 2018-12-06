Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591C4C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:49:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2E0214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gdhrqzpa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cu9K9iiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2E0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hSS2PII9GA1ibVcmfCVVTKKkrwGGYUo0eyrMZ8egXV0=; b=GdhrqzpabyXB2i
	oonjE/4sNooNmVk/VpUKMcuF3F0CEfs5jIwT1To8VuhwT0aXa3oQA5wGOmIIK6ss3ax38jhhSd+eG
	sXwMbZOgSCD2J1pmzpGjTuf1dTYC/xm3LOe28WNtEEdgmTzCrN5p+sMsO+Ejq9ltXrZ6F1XrtnUX2
	DjPM6fQsBxNCUMucE058cuzst6gRy2+IxZbgMWbufydijPQJez0bCH4XYpGHLMrtmUi/o+tjfu4/R
	fEtYnQ/aMDpjQcn3VsEWfU8ZD+iz0P+BWbuWI9Ie+6CTLhPPeRi/OfPT0PQbzsz/5Ise2cvvI/Csm
	ypIePD6owiGbYyJMfZzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUnTf-0007uJ-Pq; Thu, 06 Dec 2018 06:49:39 +0000
Received: from mail-eopbgr150049.outbound.protection.outlook.com
 ([40.107.15.49] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUnTP-0007jd-Gu; Thu, 06 Dec 2018 06:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzUL7zzJW68A1Z9QZNHsLymbIeh9oKmTfdbzzqILems=;
 b=cu9K9iiY+8uFcGMq6aJc+JJtDlHpF1zUb6kMYmNw0g56/T4hiV+klteemkb383jn+2Pk3nmxzI58BbGtxCESjgnkPg4H8gHvLBR3gFZBU7Fgep7kCI3ogVypt+fiHF+ioYDWw0MnewRQXybFDtdyqgqyxAGtTk+h7iPrnjOF0pg=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4541.eurprd04.prod.outlook.com (20.177.55.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 06:49:09 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.019; Thu, 6 Dec 2018
 06:49:09 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: RE: [PATCH v5 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v5 0/7] spi: add support for octal mode
Thread-Index: AQHUiuOjeSgB/5zRPUqi536teiWNPKVsvNiAgANQIQCAAA5HAIABBArQgAApmQCAAABNcA==
Date: Thu, 6 Dec 2018 06:49:08 +0000
Message-ID: <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
In-Reply-To: <20181206074554.0ec0aecb@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4541;
 6:If+Q76VDdYxRBWDadkKOqg4AXV9v7s/v1SzWIpI+1mue2eCAtTR4sW6zrkrbkS2h4VAXIVAcNvq/5bqSQ8lLNWgmXNff3lxDAlw+tsWKHXkkb8rkD4KGtWT/TjjwVEj3lcR9jZ7FTvVopFPC9Y849kOreEVR6VUpTWdsw3Ppt135oyk0mStJOpkxtFsn3poiZsEHm/+tscAGqctCyHQ7tZvdNSMzcNgTWLg8BNDH9V3WzJhaTxM8inbS/TuZfxgiawQvvlkdhgL6DBvl+pKlFno7/BlalkSo/wPWxdLZdUHHagyD76AW4uw5mEdFBaNjpg/CSK1mqBt7OR4cspSXANGjfjW5bCfdMwzmd6izHZa5oJLGlAZrwYFr7J6D+WqURrx8GutmHsFUS+Cb59uTT64TANJDUp40g4+lNDPc7DXChFkQ6BjfUzD6xEqH6KmQF4MMuhrMJ2uf0Hgl35qVxg==;
 5:h2572FiiFbPcFRyojd4WalujJLnb4kpACopAZ0GTz3Dw8XWzNWOQ6CycSzb+wil+7PLx0auzi3DTxFKmZ6KPHV21gV7qeB7gPb2C5gNeYV170gt//M5iw8pOyXQS30a0er1SrorNmBWZkCdDjP+NAAUxLKQLTfdWxea8R0pfVto=;
 7:r1MeIqYA9d44sMh4QI4+IFm35BNnhv2S7kwv1lVU3oXN9Bwq6QSY5rlz/G+bkGPCbvMHA1ksMq7n/DzFVajE1De3L6RkVFkB4cYKU5LBLvdvfXOvYV4JQuhIIQwWxdMicc/LIFdUrLxNuZVaja3DMg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9576e906-e4a8-4647-7a3e-08d65b46ec55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4541; 
x-ms-traffictypediagnostic: VI1PR04MB4541:
x-microsoft-antispam-prvs: <VI1PR04MB45415808FBE094AB70976C1F99A90@VI1PR04MB4541.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4541; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4541; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(13464003)(189003)(199004)(316002)(7416002)(5660300001)(74316002)(7736002)(229853002)(3846002)(54906003)(186003)(53936002)(305945005)(97736004)(478600001)(53546011)(6506007)(33656002)(4326008)(446003)(39060400002)(14454004)(102836004)(26005)(6116002)(476003)(6916009)(6246003)(11346002)(55016002)(9686003)(81166006)(81156014)(966005)(6306002)(6436002)(486006)(93886005)(8676002)(2906002)(8936002)(106356001)(76176011)(68736007)(25786009)(105586002)(71200400001)(99286004)(86362001)(71190400001)(256004)(66066001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4541;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uZzLtTsyTajRdjL/ghs4EQ2+zVNJrCPvoG6QEDtyCPO0gVhIkLAgiFRX5LrFr5pbKCWUkaB6HvWKZY/KokU+8MIVwz6UVr6wkTJJx57BmltZ2f+9ufjhDhEtg+Wg+ZgvyafMtjGxy+5G+D/uwAkaBnSvK3AW9Qv8xRoxpJhvy54V8ApcoIMR4cLTQZWI8TKqn29CeD2ENv9tKU0fFgnSjw96A19JTXKTUPGt0GojGUFMGrZhLm/gtlhbuiwC/XiPlMiKw2+TOG8ohOn/2HLiDarRiBNOkZlwTrrwjCui4qA37D3xWVLZ/U/PyiZEozBfjGa1tFtdsazpMqjC1dEKFyC73D8JJwGQt7yYp3yCB3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9576e906-e4a8-4647-7a3e-08d65b46ec55
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 06:49:08.9346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4541
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_224923_583794_87B53AC6 
X-CRM114-Status: GOOD (  19.41  )
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
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, December 6, 2018 12:16 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Vignesh R <vigneshr@ti.com>; broonie@kernel.org; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
> 
> On Thu, 6 Dec 2018 04:20:26 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Wednesday, December 5, 2018 6:16 PM
> > > To: Vignesh R <vigneshr@ti.com>; broonie@kernel.org
> > > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> > > mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > linux-spi@vger.kernel.org; devicetree@vger.kernel.org;
> > > robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
> > >
> > > On Wed, 5 Dec 2018 17:25:12 +0530
> > > Vignesh R <vigneshr@ti.com> wrote:
> > >
> > > > >>   mtd: spi-nor: add opcodes for octal Read/Write commands
> > > > >>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> > > >
> > > > Could you consider merging these two patches alone for v4.21?
> > > > These can be applied independent of other patches in the series
> > > > and would allow supporting OSPI flash at SPI NOR level with Cadence QSPI
> driver.
> > >
> > > Yep, I'll queue them to spi-nor/next.
> > >
> > > > >>   spi: nxp-fspi: add octal mode flag bit for octal support
> > >
> > > Mark, I think you can pick this one too.
> >
> > This patch is dependent on the series [1] which is yet to be applied by you,
> please apply.
> 
> By me? I can't apply SPI patches.

Sorry for ignorance. Did patches needs to be applied by Mark Brown, should I resend the patch series again?
Also can you please review the series [1] and add your Reviewed-by tag.

--
Regards
Yogesh Gaur

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=76402

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
