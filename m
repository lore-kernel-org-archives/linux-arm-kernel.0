Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA14C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:23:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B952176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5lSwSgx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZFzxJ5tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B952176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kUpxP6h07Qp5zb7jpGCtraVzLF/Fgj4QF6VQezRxCGI=; b=U5lSwSgxVEqegN
	yPbLnv0J/6bzp2aNqb5TBI4q579CfvD8aaDQfkHBCF7prru2vrTbZa9XfnDBGe7OTTICzqRYLomsP
	QrOwneO3OlfqKTc4WoFYgcGlkJY4WVsnUMHEbmmgpQ6bOrDvJykNzzXJrHov0LYw10X7SHQ5L93Gp
	MJLAZCtmW1IFFyAeTSrWtU605XQ70ep0fF6QN+UEUwjS5PcjZsUaCcfxEHHHHeOKOBVZULCg3JVE+
	NC3To1j36gUNws9iXDAXifTr7jNZIEot7h/7F+e++ccyRHY3GJobUVKC+ngC7FnBLxCJtRJDBddN7
	wNexrClZka0TeMXy9Iqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZtcG-0006b9-6g; Thu, 20 Dec 2018 08:23:36 +0000
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZtc3-0006S4-3J; Thu, 20 Dec 2018 08:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRecI3i5V6wdgCPsKtiE5eM91yeuyOXDoNNZxE3r+L0=;
 b=ZFzxJ5tF8AO83o8vJobU3ImcVrwaL/UJDAZdTx+ad+YZ8qFWgNejwdDhMoqoXNaLtn4H+xfnMT87c5w6Pm5LpYpzb8N4d9YfCI29hdzZ1fySGj5+p9pMSvw0YQolVQv3h7AI/7pOPhGbuw/ECE10va0D6eO3KUn8qox2CxoxpN4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4733.eurprd04.prod.outlook.com (20.177.48.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Thu, 20 Dec 2018 08:23:07 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 08:23:07 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Vignesh R <vigneshr@ti.com>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "boris.brezillon@bootlin.com"
 <boris.brezillon@bootlin.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v6 0/7] spi: add support for octal mode
Thread-Index: AQHUl4M9zHZOcdwiAEaqBDYBME9P7qWGAesAgAEY9HCAABHcAIAAHK3g
Date: Thu, 20 Dec 2018 08:23:07 +0000
Message-ID: <VI1PR04MB5726FABF724D8EE0144E2C8499BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
 <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <d513cf77-b308-a089-71cf-4598bfd2f085@ti.com>
In-Reply-To: <d513cf77-b308-a089-71cf-4598bfd2f085@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4733;
 6:M5DY3QKQqRSleI87bKikztFC5mP3qpOisB0pSj7DOd93FL1eo9QlqC6zvLM7qNru+CbUMgAPM2POPASVDNqhHLA5/An/RSUwOYuPCebxtiYgE9In97D5es0hzlGqioSPXlv2JMvqlWT47sa0/svEXg04ed6xIl2J2r6Az6W0Rp2lAtvsrSIcPQGXKeMjlzLYD/2RenGzt4EEwLwRHvKt8vMD+GD9E7mtOAAfzpuzqSe6GDUtRJZcwPK1E22z1dorilpx3OowM4Yt4wKrCg2BdMewoby/76Ve4mpVTRLCbd5dt5O19jxNHfmIGsppeU4aY01N3FDM5vA7a9e3P+z4nLA33fBMo+n9ntdlZD+2ao0qXsi5paLup0dFj1eLgnuCgtuWIBbGWC7AjHolAC6nBl7xPkHeTNJhpTh90UU0z96lE5TNa3f2wJHk5FBmWEd9Vkn7giwb94hjNx4wdhKU9Q==;
 5:9x9dPddoT62FCr2ljU2bsmJWbUa1ORzYdUtK+Ri2pLVQyASNCFVpFxvPOqh1NKxau8ExmbwSgodvBUDdKvw1yAEgvDWcDe40uMeq5pVymoSmGaAgTyHKi1l4p7vDwiQQy+4BI1A8CDmq4MMtz+LEy4ypm+/p4Av8xP7jIAem8nA=;
 7:EKy3KFEvv9pR5eV/up4YiT/dqq8PIrDEq1SeCpNBlZS2EkZkG0ynIyGPepjHlwwx8g2HrmG1qGf8MsfsfsM21bcDUOTqVoxv/kFIbGH3+sGSU5QT9skYEPSkAZhWZzgBo07x2eQ3jOX6ckco7A7uuQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0bdb6e08-88a2-4906-b5e6-08d666545ef8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4733; 
x-ms-traffictypediagnostic: VI1PR04MB4733:
x-microsoft-antispam-prvs: <VI1PR04MB4733196BE75E52E18C81AA9099BF0@VI1PR04MB4733.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4733; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4733; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(199004)(189003)(13464003)(53754006)(53936002)(6306002)(55016002)(9686003)(3846002)(6116002)(229853002)(2501003)(93886005)(99286004)(97736004)(66066001)(6506007)(86362001)(53546011)(26005)(55236004)(102836004)(575784001)(11346002)(2201001)(476003)(256004)(7696005)(5660300001)(6436002)(110136005)(76176011)(186003)(446003)(7416002)(14444005)(33656002)(305945005)(8676002)(25786009)(81156014)(81166006)(8936002)(4326008)(71200400001)(71190400001)(7736002)(39060400002)(78486014)(106356001)(105586002)(45080400002)(478600001)(316002)(54906003)(486006)(6246003)(74316002)(68736007)(14454004)(2906002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4733;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vem66fRDvx6U+C39cNl7VibOzYpwtFPL9qNJ2Tdu3H1V3xZs82K4PzCVMq9Yoc43TST6rUMwKK3mHAAL8Z0DjQLg7xVorIkysf5cQJkOCEpA2wdY+8YxE98TsLPVIzdwWn7LXwZobLYWEp+fNJdNY0C2+JLGCxYtCNmF1Zdt7q4Bx0flE57PD/vuGimUxUZxbwApeA9FnmUer5cjSamwIRqcEBUiexS4XQwFj6jzADaVX9Nj4jMJeTAgcpLsd22gAjBOamJgygIHYPcKMAbfbB0auvEAe/9PSbso8dXH96sll93S3OXkRQDe6R/C7U8K
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb6e08-88a2-4906-b5e6-08d666545ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 08:23:07.5210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4733
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_002323_282735_2C602887 
X-CRM114-Status: GOOD (  24.15  )
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

Hi All,

> -----Original Message-----
> From: Vignesh R [mailto:vigneshr@ti.com]
> Sent: Thursday, December 20, 2018 12:03 PM
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
> On 20/12/18 11:02 AM, Yogesh Narayan Gaur wrote:
> [...]
> >>> Yogesh Gaur (7):
> >>>   spi: add support for octal mode I/O data transfer
> >>>   spi: spi-mem: add support for octal mode I/O data transfer
> >>
> >>
> >> These two patches are already merged and is now part of linux-next[1].
> >> Its preferred to send patches based on top of latest linux-next so as
> >> to avoid resending patches that have already been picked up by the
> maintainer.
> >>
> >> [1]
> >> commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
> >> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> >> Date:   Mon Dec 3 08:39:06 2018 +0000
> >>
> >>     spi: add support for octal mode I/O data transfer
> >>
> >> commit b12a084c8729ef423089bb9a5a143eed39cd94e7
> >> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> >> Date:   Mon Dec 3 08:39:12 2018 +0000
> >>
> >>     spi: spi-mem: add support for octal mode I/O data transfer
> >>
> >>
> > I have checked on repo "git://git.infradead.org/linux-mtd.git" on branch "spi-
> nor/next" and in that kernel version is 4.20.-rc5.
> > In this repo above 2 patches are not present and hence has send the patches
> by moving to top of this repo.
> >
> 
> Those patches are applied to spi tree:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fspi.git%2Flog%
> 2F%3Fh%3Dfor-
> next&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7Cc24a66e695
> 7f4940e83708d66644f5bf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636808843700180940&amp;sdata=4IPwuRmJKv4qISAjD0W07OIA%2BWQpT
> 3E97T%2BSbSOrSN8%3D&amp;reserved=0
> 
> > Can you please let me know the repo of linux-next and branch to use.
> >
> 
> The linux-next tree is the holding area for patches aimed at the next kernel
> merge window. This tree includes spi-nor/next as part of mtd/next as well as
> many other subsystem specific -next trees:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> next.git&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7Cc24a66e
> 6957f4940e83708d66644f5bf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C636808843700180940&amp;sdata=VGMHZCjAgZfnSJeUHhkpgI0ygt9pvP
> y9KJs5Pzn64D0%3D&amp;reserved=0 branch: master
> 
> 
Above repo "kernel/git/broonie/spi.git" and branch (for-next) are missing below 2 patches[1], which have been applied by Boris and present in repo "git://git.infradead.org/linux-mtd.git" on branch "spi-nor/next".

commit a98086e00420ad92cfa961bcbb457fbe52ec28c9
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Fri Oct 12 02:23:13 2018 +0000

    mtd: spi-nor: add entry for mt35xu512aba flash

    Add entry for mt35xu512aba Micron NOR flash.
    This flash is having uniform sector erase size of 128KB, have
    support of FSR(flag status register), flash size is 64MB and
    supports 4-byte commands.

    Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
    Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
    Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

commit 0005aad094538e1c290b1cdb5b940e4a16f405b0
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Fri Oct 12 02:23:08 2018 +0000

    mtd: spi-nor: add macros related to MICRON flash

    Some MICRON related macros in spi-nor domain were ST.
    Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.

    Added entry of MFR Id for Micron flashes, 0x002C.

    Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
    Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
    Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>


Octal mode support patch series has dependency over these patches.
Should I send these two patches again or specifies them as dependency patches in the cover letter.

--
Regards
Yogesh Gaur

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384&state=*

> Regards
> Vignesh
> 
> > --
> > Regards
> > Yogesh Gaur
> >
> >> Regards
> >> Vignesh
> >>
> >>>   mtd: spi-nor: add opcodes for octal Read/Write commands
> >>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> >>>   mtd: m25p80: add support of octal mode I/O transfer
> >>>   spi: nxp-fspi: add octal mode flag bit for octal support
> >>>   arm64: dts: lx2160a: update fspi node
> >>>
> >>> Changes for v6:
> >>> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
> >>> - Rebase on top of v4.20-rc5.
> >>> Changes for v5:
> >>> - Modified string 'octo' as 'octal' in all patches.
> >>> Changes for v4:
> >>> - Rebase on top of v4.20-rc2.
> >>> - Modify octo entries enum value in spi.h.
> >>> Changes for v3:
> >>> - Add octo mode support in spi_setup().
> >>> - Rename all patches with 'octal' string modified as 'octo'.
> >>> Changes for v2:
> >>> - Incorporated review comments of Boris and Vignesh.
> >>>
> >>> Yogesh Gaur (7):
> >>>   spi: add support for octal mode I/O data transfer
> >>>   spi: spi-mem: add support for octal mode I/O data transfer
> >>>   mtd: spi-nor: add opcodes for octal Read/Write commands
> >>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> >>>   mtd: m25p80: add support of octal mode I/O transfer
> >>>   spi: nxp-fspi: add octal mode flag bit for octal support
> >>>   arm64: dts: lx2160a: update fspi node
> >>>
> >>>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
> >>>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
> >>>  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
> >>>  drivers/spi/spi-mem.c                             |  9 ++++++++-
> >>>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
> >>>  drivers/spi/spi.c                                 | 12 ++++++++++--
> >>>  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
> >>>  include/linux/spi/spi.h                           |  4 +++-
> >>>  8 files changed, 63 insertions(+), 14 deletions(-)
> >>>
> >>
> >> --
> >> Regards
> >> Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
