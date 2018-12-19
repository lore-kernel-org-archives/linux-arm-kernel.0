Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BFE21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SLUS5x6l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vUQkYyIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BFE21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sZWICFESjyhCvn3Dh2h4nsCw/CNsA4YMhmTIdIKV3O0=; b=SLUS5x6lX1AiKH
	qMo/mvbTQz9IstqIjfZxiStU2Y1YKf7hBS5tUpOl2EnoZXRn+cJwChM9qLZ29r8sNt4RrO87U+P/c
	Dx4yHsUud16lXWW+Ujgh8CQLfq+gqoqMk796RQXgIMUdfV08c3qKFI+Fsg2S3wa24jr6I2PWP9IgQ
	qDZn9yI2qPg3BOvGGY59HnJBCvuSRB8sKK1JSIb39wagQdygkxgIb+wllPT47/M+SW9xTj/Cp+2iN
	1PZZlDib4zAfjpj3rWGF4no4rQkqq3Tl0aHcMZJc+1Z+VGufuj3ZMdS9aXf5vvEYHtOCqyat0GBSv
	SsZJDSKJQeXF7k7ZMONA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYqI-0000w1-V0; Wed, 19 Dec 2018 10:12:42 +0000
Received: from mail-he1eur02on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::603]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYpc-0008PL-K2; Wed, 19 Dec 2018 10:12:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY4OEDeZ3S31rgp3ptXJV4NDqZmczI5HZkBg2kCyncE=;
 b=vUQkYyIrfCDf16p5NWu6GWUH/i/K9TflyEJ1BP9BImsd9n1KTIWbmDqRtr9vFfZpM6Dlr0gpCxQcqnSy62UAtj+N803NrpzRnGUOLdsw9+nS6fF5VXgjCo+nMJDQvcnBlQoaShHODyXs3uyfO3oUp50nfRvVIgQVYTVuQwTORVQ=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6141.eurprd04.prod.outlook.com (20.179.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 10:11:43 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:11:43 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v6 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v6 0/7] spi: add support for octal mode
Thread-Index: AQHUl4M9zHZOcdwiAEaqBDYBME9P7g==
Date: Wed, 19 Dec 2018 10:11:43 +0000
Message-ID: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6141;
 6:mmo3oY+kz0CvZcnmc0NegotRW3yPsH4b2RHetdLOsX7xbc0oflNufKCylqpnG+GBn1+YAgPqJzWaJJKu2hmmxVY7nCPWi/mKtfKP/vfdImtgXFDIgQyY4tHy1reQbWNG5isU5Fd5w8WATyfAYmjndnyi13Xr6zDl2GYDMfl2tISawkLqrGTEI/u0xvhR2PDipewAfFvxc8N/BQ3iPPbSoZVm7Wj6zvIBlQc1eOBEKG+D/flgQQR+PFPShrvy3UeMJKJv/AWf2rlNnn29KHraBr7Oz3mL4sQLZH19hKIloPUHagEPe5eu8t8jgR+1ajA5rlCZ78o/cqs34sm7tLYiAiXJYAipNFBV09kUvmziPHkqu5ZnDjLqY/xGP22cJfuDEFiVVvL2Fi7EAva31w2AY8a2In+vyAqf6n5p0NKcbGxuevgMw6BMdOHd3lgec5nj6Ok1wALWHESmw1IK9rO0ZA==;
 5:3nNReUo3r1Nop/FzHeTiiZNC0rwH/oY3DE8v5y/kR+S1Db3VhsFf8q98wTQ4kR47dZBnA4ynurP1wCRuujsqIZ9ze1qUM6D0lJpGIVutKyDnnHmgRNLj/P0hL6iUWwLU0YnXvEuDPMtNPe8rmJISFXgq+gBtfLPJMpuGm8ZosUg=;
 7:B2v8FeZ88Dlnj/C2SwmE9b/FyKoOUBHpdzhovOobFiWPDI2DWv/6U7pNx4QdbhasNzGvOmGTDw1F+Cu1ztwc0x5ejLl09+pJL7Klew++0nzT00KadXH2VKhr2DoevZErHUJUDm2XFyxc/29UCAm8jQ==
x-ms-office365-filtering-correlation-id: cadea22c-cf65-4548-c8e4-08d6659a600f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6141; 
x-ms-traffictypediagnostic: VI1PR04MB6141:
x-microsoft-antispam-prvs: <VI1PR04MB6141CD9A2E81547E58AE027A99BE0@VI1PR04MB6141.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6141; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6141; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(39060400002)(78486014)(386003)(6306002)(6512007)(6486002)(53936002)(3846002)(97736004)(2201001)(7736002)(6116002)(8676002)(55236004)(4326008)(2501003)(2906002)(66066001)(25786009)(14444005)(52116002)(256004)(486006)(6436002)(102836004)(7416002)(105586002)(106356001)(36756003)(81156014)(476003)(8936002)(186003)(86362001)(966005)(478600001)(26005)(54906003)(2616005)(71200400001)(71190400001)(110136005)(81166006)(68736007)(14454004)(5660300001)(305945005)(316002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6141;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 87xRwvvI/DPRcBQ3ZfVAw+UvAOrQHDtdCPxSZlvQ3yv4gLqBiyCq0+3of7a1IM6XBsy0YSgOgjEBKN2VIsxHyfBEPs27uKpgcItAzu6eONeIlSisyIngsXOn/wl2EaW7dh29QqHHtPgcjTEK+Ed4lKcd+TM4iZJjf17MSI3D75oH+UPPphenr3E4fVpwz+FNmRUYvZSviB7CzpB0mpEhhlD9OLgULwRrOFEqMa4uzh8npfr/Yt+fD4VfB89N4Zm0CbQwikOHo5Uzu9lXWmibsndE+waLy00T8BHHvG/OHRIyc9DYZhMQz1+sVgT03EZ5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadea22c-cf65-4548-c8e4-08d6659a600f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:11:43.4895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_021201_136151_7CBF02BD 
X-CRM114-Status: GOOD (  12.12  )
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
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

Add support for octal mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series
* Add support for octal mode flags and parsing of same in spi driver.
* Add parsing logic for spi-mem framework and m25p80.c device file.
* Add opcodes for octal I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
  Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
* Add mode bit required for octal mode in nxp-fspi driver [2].
* Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].

Tested on LX2160ARDB target with nxp-fspi driver, below are
Read performance number of 1-1-1 and 1-1-8 read protocol.

 root@lxxx:~# cat /proc/mtd
 dev:    size   erasesize  name
 mtd0: 04000000 00001000 "spi0.0"
 mtd1: 04000000 00001000 "spi0.1"
 root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m2.792s
 user    0m0.000s
 sys     0m2.790s
 root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m0.441s
 user    0m0.000s
 sys     0m0.440s
 root@ls1012ardb:~#


 Flash device MTD0 configured in 1-1-1 protocol.
 Flash device MTD1 configured in 1-1-8 protocol.

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384&state=*
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=76402

Yogesh Gaur (7):
  spi: add support for octal mode I/O data transfer
  spi: spi-mem: add support for octal mode I/O data transfer
  mtd: spi-nor: add opcodes for octal Read/Write commands
  mtd: spi-nor: add octal read flag for flash mt35xu512aba
  mtd: m25p80: add support of octal mode I/O transfer
  spi: nxp-fspi: add octal mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
- Rebase on top of v4.20-rc5.
Changes for v5:
- Modified string 'octo' as 'octal' in all patches.
Changes for v4:
- Rebase on top of v4.20-rc2.
- Modify octo entries enum value in spi.h.
Changes for v3:
- Add octo mode support in spi_setup().
- Rename all patches with 'octal' string modified as 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh.

Yogesh Gaur (7):
  spi: add support for octal mode I/O data transfer
  spi: spi-mem: add support for octal mode I/O data transfer
  mtd: spi-nor: add opcodes for octal Read/Write commands
  mtd: spi-nor: add octal read flag for flash mt35xu512aba
  mtd: m25p80: add support of octal mode I/O transfer
  spi: nxp-fspi: add octal mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
 drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
 drivers/spi/spi-mem.c                             |  9 ++++++++-
 drivers/spi/spi-nxp-fspi.c                        |  4 ++--
 drivers/spi/spi.c                                 | 12 ++++++++++--
 include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
 include/linux/spi/spi.h                           |  4 +++-
 8 files changed, 63 insertions(+), 14 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
