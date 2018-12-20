Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1387AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:32:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5E920866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZPyidayz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="utpREXuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5E920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVHfT+3JGJshzppfaa+2pGPD/FY9pgsq3x6OTC52J2Q=; b=ZPyidayzmfBDr7
	j/ZL1LBoQ3fT/3GhoCuO6wjlu9ab/kyA2wOD5pPfYFU+xxF4oecYdRbamsf8ryrHIcjcj2s6Q5ulf
	kLyqr0nl25x34UuhddA9A/w/w8FSeqwiMScb4ly8YwgC0NxIMQCBr719kLEaif7w1qLTPdGnOOYKc
	nOo3fgqub2NfzdYQ3uF9TgNyCctPjtk7QbTUoY4EHZUyDQnRVjJKRG5ZbCH2W9m3XCdv559lZYx3B
	UnnZnrg91Iq5hIh9BcqE3IrQ9Pvr0LdgCUpnIS/DTTmgYqmyBZIHDCVptWAgnb+oa3vw0WojGpGBN
	xAJcWftKCODBNOlUDVGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZqwj-0005AK-DS; Thu, 20 Dec 2018 05:32:33 +0000
Received: from mail-eopbgr130074.outbound.protection.outlook.com
 ([40.107.13.74] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZqwW-00050e-HN; Thu, 20 Dec 2018 05:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GNt4jwkOpu3O3rvMsF25xjHG/L7wF2JubpXOT3/vGk=;
 b=utpREXuTjxsA3QPgm+Nrr3MepnYW4OUPY2Gtr2eZOau1rnABPoHCLYa+0qlMdpbu19CWNAkYQU6Y/TI/REIju71Ol4Vq1OnvrPPXyBn41KPZCqJ/wTT8ye7HApr4tP34J1B6rbB2A6YahHHhxG5f1+kXG5Gw4adUJzhK+CPBceM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5488.eurprd04.prod.outlook.com (20.178.122.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 05:32:03 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 05:32:03 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Vignesh R <vigneshr@ti.com>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "boris.brezillon@bootlin.com"
 <boris.brezillon@bootlin.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v6 0/7] spi: add support for octal mode
Thread-Index: AQHUl4M9zHZOcdwiAEaqBDYBME9P7qWGAesAgAEY9HA=
Date: Thu, 20 Dec 2018 05:32:03 +0000
Message-ID: <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
In-Reply-To: <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5488;
 6:2wsJIqgoPNyvmBg/w78yKK37fyce/J8jreSC2QRSRJUcVPSW64ZvOgot9KtSGq7GpZ7cRM54NFlIqLbYlbbmLiqYbH2BjNDm/fT0UgRIylpWsO2/yB7Od0geuiWnTHVCSUeAhjZ7ECxab+q3Uz9hk11EuwL5AXIWsqNeyKiQ7CX7EEBVPWT4Dk50O4hJvcnZXSYIOIVJi2jnK0P4y+saBS+HZ3Ogc46TU2pVLMu5yX2jjOiz7oR5zQMA3Yeq0yVYtmIRKohXSZ6LWxodEg41FYoYYA8UfYl1gv0hS4zeXub6ePshAM1Ea0S0ZJAzN1CYcua1coeU9U1jWcXfUYthNSou0wjr3AWMp/AOiNUSCoJCV4GdEms8vKTrwEF9a0ZyN5ft/H/NHviCgnZwmRaRL9FiInD6falv9M28mZqGAhwmfINTt/qtiA3aXrmDS0Bju55dx810kBfPVozVpWFWzg==;
 5:AQuBbhBv+koU6vV2lN/L8DyltVM2SvTFnvz1kITxzEn2OHjEneSulEbK+kzxaWKCK3ykOT26u2BVAwH5dk/wf6oZmFLBRTiHsV2ucc2ROPuGDQk93NyfTddAgT4HUbK3RDaFHQliZQBFFZPxsXKXrNDtj6jc0gfEmQMsJ/ejPLs=;
 7:m7pD7cMoAQ4n4PyIgbmP2XbiQwpB3q7sSfZ35lvOefZddJQSpcSUdy+t5M+3ISFnAVMgqG/G9BmAXUxf7Akb8LLHQr3AJ0zlgd4zHjKgua2Cy1147Pj1fwn8EUxeOnLVGr1HmdL2cOU/AOCTnjP7jA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e11dbf35-397a-4748-8879-08d6663c7903
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5488; 
x-ms-traffictypediagnostic: VI1PR04MB5488:
x-microsoft-antispam-prvs: <VI1PR04MB5488216CD402A5C2891A7D8C99BF0@VI1PR04MB5488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5488; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5488; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(13464003)(199004)(189003)(71190400001)(54906003)(110136005)(8676002)(78486014)(486006)(8936002)(305945005)(4326008)(68736007)(66066001)(39060400002)(5660300001)(476003)(55236004)(45080400002)(6116002)(97736004)(3846002)(81156014)(74316002)(7736002)(478600001)(2201001)(71200400001)(6436002)(2906002)(11346002)(446003)(966005)(316002)(86362001)(256004)(105586002)(106356001)(25786009)(2501003)(14444005)(229853002)(14454004)(55016002)(7416002)(9686003)(6306002)(99286004)(7696005)(53936002)(26005)(33656002)(53546011)(6506007)(6246003)(186003)(81166006)(76176011)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5488;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XcTdwD2mK5AoSbVfM4gnqkMCnTrRrcUMQXLMTDJMdDJH5Adh4Dyccj4rP1TnqzDM416eexhaH7vx8qjFZzsOQUiu+6xaEu65/RUCMIWoxzCTT2ns2l2/C0ujQdC24P9/Quw4eLi9eLKOSQre4FeV8c+cR2shfPNt2UjNUEpwnpFAYDwRVG6Z8Taq+FQYCzvZJYvf5xVHwFVGRlNI/tmfEUqj+i0RRBF17KPJBFYgShvcQuWNH8KVLJelI5OAmtZKkyhgv3SGtMQ/mi5SqqKx2rtcSGqHt/lJ5wzyB0Vq2IPXnifhZRfazXSmdtjPcRxB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11dbf35-397a-4748-8879-08d6663c7903
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 05:32:03.2443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5488
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_213220_583875_2D382255 
X-CRM114-Status: GOOD (  22.41  )
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
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vignesh,

> -----Original Message-----
> From: Vignesh R [mailto:vigneshr@ti.com]
> Sent: Wednesday, December 19, 2018 6:14 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; broonie@kernel.org;
> marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: tudor.ambarus@microchip.com; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
> 
> Hi,
> 
> On 19/12/18 3:41 PM, Yogesh Narayan Gaur wrote:
> > Add support for octal mode IO data transfer.
> > Micron flash, mt35xu512aba, supports octal mode data transfer and NXP
> > FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> >
> > Patch series
> > * Add support for octal mode flags and parsing of same in spi driver.
> > * Add parsing logic for spi-mem framework and m25p80.c device file.
> > * Add opcodes for octal I/O commands in spi-nor framework, Read and Write
> proto for (1-1-8/1-8-8) mode.
> >   Opcodes are added as per octal data IO commands required for
> mt35xu512aba [1] flash.
> > * Add mode bit required for octal mode in nxp-fspi driver [2].
> > * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> >
> > Tested on LX2160ARDB target with nxp-fspi driver, below are Read
> > performance number of 1-1-1 and 1-1-8 read protocol.
> >
> >  root@lxxx:~# cat /proc/mtd
> >  dev:    size   erasesize  name
> >  mtd0: 04000000 00001000 "spi0.0"
> >  mtd1: 04000000 00001000 "spi0.1"
> >  root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
> > Copied 16777216 bytes from address 0x00000000 in flash to 0read
> >
> >  real    0m2.792s
> >  user    0m0.000s
> >  sys     0m2.790s
> >  root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
> > Copied 16777216 bytes from address 0x00000000 in flash to 0read
> >
> >  real    0m0.441s
> >  user    0m0.000s
> >  sys     0m0.440s
> >  root@ls1012ardb:~#
> >
> >
> >  Flash device MTD0 configured in 1-1-1 protocol.
> >  Flash device MTD1 configured in 1-1-8 protocol.
> >
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D70384%26s
> >
> tate%3D*&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7Cac5c9
> ca4ad0
> >
> 84f10762208d665af9130%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636
> >
> 808202064181032&amp;sdata=LCjo%2B%2FhIpEYygsLHMFzb65ZtXjsDdhEAVV4
> %2BjQ
> > iyUtI%3D&amp;reserved=0 [2]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D76402&amp
> > ;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7Cac5c9ca4ad084f107
> 62208d
> >
> 665af9130%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636808202
> 064181
> >
> 032&amp;sdata=A9hAX4oTyJPzc4J3y3PqwNagWEqvpGolf8RE9RyYV28%3D&am
> p;reser
> > ved=0
> >
> > Yogesh Gaur (7):
> >   spi: add support for octal mode I/O data transfer
> >   spi: spi-mem: add support for octal mode I/O data transfer
> 
> 
> These two patches are already merged and is now part of linux-next[1].
> Its preferred to send patches based on top of latest linux-next so as to avoid
> resending patches that have already been picked up by the maintainer.
> 
> [1]
> commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Date:   Mon Dec 3 08:39:06 2018 +0000
> 
>     spi: add support for octal mode I/O data transfer
> 
> commit b12a084c8729ef423089bb9a5a143eed39cd94e7
> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Date:   Mon Dec 3 08:39:12 2018 +0000
> 
>     spi: spi-mem: add support for octal mode I/O data transfer
> 
> 
I have checked on repo "git://git.infradead.org/linux-mtd.git" on branch "spi-nor/next" and in that kernel version is 4.20.-rc5.
In this repo above 2 patches are not present and hence has send the patches by moving to top of this repo.

Can you please let me know the repo of linux-next and branch to use.

--
Regards
Yogesh Gaur

> Regards
> Vignesh
> 
> >   mtd: spi-nor: add opcodes for octal Read/Write commands
> >   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> >   mtd: m25p80: add support of octal mode I/O transfer
> >   spi: nxp-fspi: add octal mode flag bit for octal support
> >   arm64: dts: lx2160a: update fspi node
> >
> > Changes for v6:
> > - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
> > - Rebase on top of v4.20-rc5.
> > Changes for v5:
> > - Modified string 'octo' as 'octal' in all patches.
> > Changes for v4:
> > - Rebase on top of v4.20-rc2.
> > - Modify octo entries enum value in spi.h.
> > Changes for v3:
> > - Add octo mode support in spi_setup().
> > - Rename all patches with 'octal' string modified as 'octo'.
> > Changes for v2:
> > - Incorporated review comments of Boris and Vignesh.
> >
> > Yogesh Gaur (7):
> >   spi: add support for octal mode I/O data transfer
> >   spi: spi-mem: add support for octal mode I/O data transfer
> >   mtd: spi-nor: add opcodes for octal Read/Write commands
> >   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> >   mtd: m25p80: add support of octal mode I/O transfer
> >   spi: nxp-fspi: add octal mode flag bit for octal support
> >   arm64: dts: lx2160a: update fspi node
> >
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
> >  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
> >  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
> >  drivers/spi/spi-mem.c                             |  9 ++++++++-
> >  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
> >  drivers/spi/spi.c                                 | 12 ++++++++++--
> >  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
> >  include/linux/spi/spi.h                           |  4 +++-
> >  8 files changed, 63 insertions(+), 14 deletions(-)
> >
> 
> --
> Regards
> Vignesh
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
