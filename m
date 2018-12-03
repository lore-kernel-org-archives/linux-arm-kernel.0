Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62502081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCIxMVVn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tFeXSkls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62502081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JlxIeDfe/aGVn6mjj/E7KQt2yaqeP/V3qCh9AiiNcpE=; b=uCIxMVVnnUpG0c
	zmZjz4ljX9za4SUu8s6T2sh7g8fnFjrIy1P/3ZFMhJJF+mKLkZ+jQLXDeWwczPPfR0PyWfXnxH3YE
	uDg3SENzIAupXlJ5lxqle6u1DUfcyJn2bdIbAcaseBzJu49azWHpsk2MyDr6zIyzHFyerv0G5B5fY
	UsVtrN7RLP6X6vMWLDyUy6/rpHeB/hoOr/RM49g+OgQHRMMA6Ym6O6n+f+/ZVOuFsyvlb5UFbnj5C
	L1lNSrf88A5f+HhWgFeUUuJtVA0eQ6RpAVYRz+Fg/J3snwOS4gIkKkwzHyV2CxZkTPMtFjiLABOzC
	85hHoOQVDs6W7ayJ19bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjlJ-0004Zq-Qj; Mon, 03 Dec 2018 08:39:29 +0000
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjl5-0004NR-HF; Mon, 03 Dec 2018 08:39:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiscYK5w4iJwkmdrOmVBJF9XsGNqb92YVEsusnmSOv4=;
 b=tFeXSklsTHWHMqsohcoZDmOTe5TtNBDuiN2CeH+BoZnTplrvRz1A/28jq0XoKuXTdwbJz/kJ5+jX8+A6P6T3h7rRQit+gg4OVmiDlIweZUI24//MWMcB7gGmJxtCpmcFTsxd34GDWBGBtX0a3U461Aa8ulDdGwI96csSHFJYQvs=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4718.eurprd04.prod.outlook.com (20.177.48.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 08:39:00 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:00 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v5 0/7] spi: add support for octal mode
Thread-Index: AQHUiuOjeSgB/5zRPUqi536teiWNPA==
Date: Mon, 3 Dec 2018 08:39:00 +0000
Message-ID: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4718;
 6:gCilAnZ9PJcZ9g7HN5N+0WbphrR1hT3R84tkdzTdXFGc1hsaVWh9WfrAn6A+MLOawTO/SDPuyXX7Vz6BoGo8O3oL3EqRncuD6EeuAlG/A30ovkdcTZM0WhDrJp509fJQyhsk1fLl5SluqzAA4Vq6Xl2oc5zMrtQ4XOgurvsZ+g+WPyG6c6plSf1mVXFpO4GpgJmO49Dkz+KEOIs8SHcCBLtRScoP5LQ8HXTP3CBKm0BF3UJn0ypbyx3W1S7OyGEwQUqMya4ApKl2c/od61F9KgkDVHMqUsr6aHgp3ogbMJCjfvZ0TVwcNP/fcbNOgyTv8oh2yx/LuboRIItSAdUiyzuCmK3t2euqdMqSZ7COlo7VUQe8hiF2qVF9lLaDhAO4rQpBykaej2ZaIT/z1qdNeDweyZaJmp89fMciMt/R2ZCp4kUO5F/JEGeR/KiIQCW3kEmTaUoRgLHxO6bDhIkLLA==;
 5:X8OoObgnkqUosnA4POEPWy53gWNfFvmPaqZMnV1qAe04P+IwOVQIqe8s5YVDw62c2LRsYyLZonuX1s2AVdboxmqmNJNspONPI6yI0IZS8RvnzWfVNG//T1b2A1Fn41/ZuTEhWpJSeiDOilzHXBeNOVraxy0b0jwdCO44+mmjA0s=;
 7:DLr30goRMgozu54zEdpyUuem2VTzHbywMmjuRWw28B495KfKTiB/V0jZPYQ2ZS0Ahb/CatgWQv/dGgoFVuESBGvH34yfzjX9PgBJcc2mzAfNkM1omwP1GIrfstsBZxlJiunYDe/kEpIZacTj8+oR9A==
x-ms-office365-filtering-correlation-id: b61a3a52-c4db-4ab3-0b01-08d658fac583
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4718; 
x-ms-traffictypediagnostic: VI1PR04MB4718:
x-microsoft-antispam-prvs: <VI1PR04MB4718A8F81A6EC4640B21155699AE0@VI1PR04MB4718.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4718; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4718; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(7736002)(99286004)(6486002)(305945005)(6306002)(6512007)(6506007)(53936002)(66066001)(386003)(105586002)(106356001)(68736007)(256004)(71190400001)(71200400001)(5660300001)(110136005)(55236004)(14444005)(54906003)(7416002)(14454004)(86362001)(478600001)(6116002)(3846002)(966005)(25786009)(186003)(2201001)(2501003)(97736004)(2906002)(81156014)(81166006)(6436002)(8676002)(4326008)(486006)(78486014)(36756003)(102836004)(52116002)(26005)(39060400002)(2616005)(8936002)(316002)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4718;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8PWkg90hBL2XILyrvQ1IXgpz1XvUw/nxUS/6sSRxIiXpmDWebiGUO69peK4KpB04iyhE4Bzs0kJDWmtwLk5zhd3dYg5oUFy+YcNAfBX0ZJYHlFPKJncXJSJOfaOz0MWlVNiOlUiS2nw/vD/rE108UuAaLYnsR6f6GcGb4HIOKM+orZ0hPhNw6vUN7ksZPn0NNoCu8XlSnj0Yl/HtOTGn1vVDcKyzS2F1wCDr/LLl9duSYLXsAlrFSxcZjpDzu+qvePyAoGWjMfLVLmG4liAc7qVFo92+XF4ADfGIMQguknIUA2ZSUyZfKF195ir4eSulR6SXd5x/mkF7aii98dl26udl5oNDsaCI++Jd7wrjh/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61a3a52-c4db-4ab3-0b01-08d658fac583
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:00.4105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4718
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_003915_568876_B2FBEDC8 
X-CRM114-Status: GOOD (  11.13  )
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

 drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
 drivers/spi/spi-mem.c                             |  9 ++++++++-
 drivers/spi/spi-nxp-fspi.c                        |  4 ++--
 drivers/spi/spi.c                                 | 12 ++++++++++--
 include/linux/mtd/spi-nor.h                       |  8 ++++++++
 include/linux/spi/spi.h                           |  4 +++-
 8 files changed, 59 insertions(+), 10 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
