Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708FEC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:10:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AF02083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kebeHOsf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1mZCwm3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SwWchiYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AF02083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fBQfsxGldgGJyzRXL4cNNmnrVwFeDJprSZUH0wZ7HLI=; b=kebeHOsfSYAjOQ
	1LV32Aoq04peB59DisTWNdIjOwFlNr5Xyz2tBHQMyPXgptBFIRUgy7C5QNMhHROoEw0UiEXiC9OQF
	aygi6zWc6vZnHn4ibEaDwdJO8+spt2m//ZYWf07elEK+tQcotIkr2pFYhKZvhMqI2sCgfGChWwxSP
	aWJFYNpGpoJxn/2cm3pFThhenFzAvOql+L6FX/P95S5NCgVR5kbSznavDfJHrXoFVA/9dOBks0d2W
	ZV0tJmw05fWNrzBtVp7+fGDx3P6k2KCsi+PPMfCUwR/YmB1b4vA8bqdiU0drsHYwEGB3MBidD+MQP
	Pe87Qo7sY9tCb3SxQrgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr5BG-000638-Bi; Tue, 05 Feb 2019 18:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr5BD-00062x-Rw; Tue, 05 Feb 2019 18:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v4Od9gnCxi3jip042FHAM7tJUXHXYe07DTLwP8ZuCzQ=; b=A1mZCwm3FfiRc8PT+sI4zHPApt
 jp+FpRyv3rUOvSE5xpk4w/bxbD7GjIyBAV2+HQNA/EFXh30AOUw3lBJrQFIkGqidv0wX3bPiB2OQ0
 YLMdDY8e+rw+DG1bfDOSR43xnv5CfT1xerqvkCUcm9UUewh787iTj0RaHbtjFqJ5hhg/mIxNR80Zf
 QPQ13BTyxPFOx94t5kgosDkzKvNnQVAPg9mUdk78V687UeSoAahSjP8sSIpYRe7QgsRBx91yL/U/x
 DPtFonZSnMKnzu4jkqkfdmPjC+4neYuph6YXELyPBj0Ui/U6jbqrOGAomi566Nvbm8LrR8n2w6YjD
 iGlhseLw==;
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4ba-0005M1-4t; Tue, 05 Feb 2019 17:33:56 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="26340151"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 05 Feb 2019 10:33:42 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4Od9gnCxi3jip042FHAM7tJUXHXYe07DTLwP8ZuCzQ=;
 b=SwWchiYCwclmbctT7lOP4cMpQE6CAw82ckaeUG/XHELP5plUWG71Jz5E9BEfEG8l6p7y3fSW63GyzhhiUFV9GlzKqwxrlT7s3EgKUc2G9PjXi/+XkVorogVYG5vCguUGDL16W1vU1a8EpbVaYw7oKMqYXo70h7SaJ/Q3Y7RErJ4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1539.namprd11.prod.outlook.com (10.172.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:38 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:38 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v6 13/13] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v6 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUvXjtLv08A027eU25+F42pnge9g==
Date: Tue, 5 Feb 2019 17:33:38 +0000
Message-ID: <20190205173254.16388-14-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1539;
 6:vG0lVldju4QaQIJVcKqoP7uRjyrrJ0Xu0qm6Hx3nlTPgXr10NN04D16qaTsr4QRnF11jU7baZUe9r2XLdk0eGEQ1CimlAAbm0PCBvkwNSvJZW78lVVjRDYP2iGI5xa0/pSxGhHff+U51FiV98AXxphhvz+0Y8LD3M2dax36PNnUH9VgtfihbYC45sUd2bXaFS5PveasguhMX3pLkJ1i4wi4YnNKtNxLq1wNx8tjvmSqRqxUQ4fVApEMIxuj9SGJpwyInYUpoREwnsUTgvi++ckLkVfggYQjiZ25Z/v82f9VAr5X+fo80zkhaa+TN34qgp3+hQ7amZX4uASM+EmUYonk7opPPDd7dOMtr0LoS7cDOazMSU1FQOjhlLIdtdHwE7F5CFXWTIwufHHUSfEtuVpHlA+Slau1P9TsHj16MdJKKqHSq1th7rtZI9hckjp0cFiTDWcgtkv4cFkbaV9Hefg==;
 5:YMKn9vWFmXLJvwAuALZ69qLHqD65siS5uZ/oGzkFTUIIsxk3kEZLt5UmBXPOc1GOcmn3eag20MYW3Gug4oAHJ1wLdh9dxJb4jMynmCQsiDGvI/QOJ/exOBY0jBKmZ0QKdx7FXIlZPd1fGfh+l8/AoDudrST1rrcyLIGC2sGVRX8vVEWP5z+V4u//XML/iX/tDfkQUFgpbwrFDUJ6Snn1qw==;
 7:STSx4VhM2uS4rsbWAKqg7LijuMZxJM7cykpZ4IKc2K2b+IDfV4/NxMJs0mBC5U1OXdKaRv9gxWcEsXDQHZMx77T7XYo25aQ3B3pCbqrxQueFY2f5SidJS5wrRMe4SdO7AjXXON3ATZKZ/NCIzKDDZw==
x-ms-office365-filtering-correlation-id: 81ee7cbb-f835-44ad-974b-08d68b90103a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1539; 
x-ms-traffictypediagnostic: BN6PR11MB1539:
x-microsoft-antispam-prvs: <BN6PR11MB1539D70EC6ACEC9873CCD057F06E0@BN6PR11MB1539.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(386003)(6506007)(7736002)(4326008)(71200400001)(71190400001)(99286004)(72206003)(2906002)(110136005)(14454004)(316002)(305945005)(76176011)(8936002)(8676002)(52116002)(7416002)(3846002)(478600001)(6116002)(54906003)(2501003)(50226002)(1076003)(36756003)(106356001)(53936002)(105586002)(30864003)(25786009)(81156014)(6486002)(68736007)(81166006)(256004)(86362001)(102836004)(26005)(486006)(6512007)(11346002)(14444005)(66066001)(476003)(97736004)(107886003)(6436002)(186003)(2616005)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1539;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UUm5iApy4yz/Vf8S45O9AXol2Xq9wdFBeexd2dJatlP8yOYv08tzb652fGkxeC73XRh3h0nyjsiYx+KSPqGdGNeY0gccFDplQIVK/DGUb0UPZrZoVP/Or+wtgXo6ucFsEzNsZGdUC+Eobx7+trr2YnXBejGZ0sNS53mIDUgTUu/SlFb86g3oDZt55kuyxTZ238auJtAAEvyecYM3zyip27DwbJrtUcbNey9jFUYTP9grf1jJA2fxjDboPJIqTgaj6c3jhMXFlapojQ6/heSqLV4K1Kcg7f+fEXnSDcSxeeD2Rtr2mFQMYD1maZmowZ4pX5x+4WBP+dLhcbp8RiwvaxtXxm5IgX8ZhBzfrkTrrPNtXKL8hj9FFKMtu2MO6cWQXVfnY9nVn6KBZFm4iCAvqsI1P508s4pCZc/klxEn7cg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ee7cbb-f835-44ad-974b-08d68b90103a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:36.1651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1539
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_123354_627669_536FD3F7 
X-CRM114-Status: GOOD (  27.01  )
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
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory. It uses
different transfer type bits in IFR register. It has dedicated registers
to specify a read or a write instruction: Read Instruction Code Register
(RICR) and Write Instruction Code Register (WICR). ICR/RICR/WICR have
identical fields.

Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v6: add a caps instance to the sama5d2 entry instead of allowing caps
    to be NULL
v5:
- use WICR for sam9x60
- remove ops hooks and introduce caps->has_ricr
- get rid of the cfg struct
- group IO accesses together in atmel_qspi_set_cfg()
v4:
- drop local variables that kept aq->regs and &pdev->dev, the compiler
  should be smart enough to store them in a register
- add comment saying QSPI_IFR_APBTFRTYP_READ is defined in sam9x60
- s/sama5d2_qspi_modes/atmel_qspi_modes, modes are the same both
  controllers
- fix kernel doc header
- move comment in function body
v3:
- reorganize the code and change ops functions pointers to avoid code
  duplication. From the IP perspective, the transfer type bits are
  different, and what registers are written: ricr/wicr instead of icr.
- treat just regular spi transfers. Mem transfers will be added together
  with dirmap support.
v2:
- rework clock handling
- reorder setting of register values in set_cfg() calls -> move functions
  that can fail in the upper part of the function body.

 drivers/spi/atmel-quadspi.c | 163 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 128 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 336501d962e5..fffc21cd5f79 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi-mem.h>
 
@@ -35,7 +36,9 @@
 
 #define QSPI_IAR     0x0030  /* Instruction Address Register */
 #define QSPI_ICR     0x0034  /* Instruction Code Register */
+#define QSPI_WICR    0x0034  /* Write Instruction Code Register */
 #define QSPI_IFR     0x0038  /* Instruction Frame Register */
+#define QSPI_RICR    0x003C  /* Read Instruction Code Register */
 
 #define QSPI_SMR     0x0040  /* Scrambling Mode Register */
 #define QSPI_SKR     0x0044  /* Scrambling Key Register */
@@ -88,7 +91,7 @@
 #define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
 #define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK)
 
-/* Bitfields in QSPI_ICR (Instruction Code Register) */
+/* Bitfields in QSPI_ICR (Read/Write Instruction Code Register) */
 #define QSPI_ICR_INST_MASK              GENMASK(7, 0)
 #define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MASK)
 #define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
@@ -118,6 +121,7 @@
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
+#define QSPI_IFR_APBTFRTYP_READ		BIT(24)	/* Defined in SAM9X60 */
 
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
@@ -133,12 +137,18 @@
 #define QSPI_WPSR_WPVSRC_MASK           GENMASK(15, 8)
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
 
+struct atmel_qspi_caps {
+	bool has_qspick;
+	bool has_ricr;
+};
 
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
 	struct clk		*pclk;
+	struct clk		*qspick;
 	struct platform_device	*pdev;
+	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	u32			mr;
 	struct completion	cmd_completion;
@@ -151,7 +161,7 @@ struct atmel_qspi_mode {
 	u32 config;
 };
 
-static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
+static const struct atmel_qspi_mode atmel_qspi_modes[] = {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -180,8 +190,8 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 {
 	u32 i;
 
-	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
-		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
+	for (i = 0; i < ARRAY_SIZE(atmel_qspi_modes); i++)
+		if (atmel_qspi_is_compatible(op, &atmel_qspi_modes[i]))
 			return i;
 
 	return -ENOTSUPP;
@@ -201,36 +211,37 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 	return true;
 }
 
-static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
+			      const struct spi_mem_op *op, u32 *offset)
 {
-	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
-	int mode;
+	u32 iar, icr, ifr;
 	u32 dummy_cycles = 0;
-	u32 iar, icr, ifr, sr;
-	int err = 0;
+	int mode;
 
 	iar = 0;
 	icr = QSPI_ICR_INST(op->cmd.opcode);
 	ifr = QSPI_IFR_INSTEN;
 
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
-		aq->mr = QSPI_MR_SMM;
-	}
-
 	mode = atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
-
-	ifr |= sama5d2_qspi_modes[mode].config;
+	ifr |= atmel_qspi_modes[mode].config;
 
 	if (op->dummy.buswidth && op->dummy.nbytes)
 		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
 
+	/*
+	 * The controller allows 24 and 32-bit addressing while NAND-flash
+	 * requires 16-bit long. Handling 8-bit long addresses is done using
+	 * the option field. For the 16-bit addresses, the workaround depends
+	 * of the number of requested dummy bits. If there are 8 or more dummy
+	 * cycles, the address is shifted and sent with the first dummy byte.
+	 * Otherwise opcode is disabled and the first byte of the address
+	 * contains the command opcode (works only if the opcode and address
+	 * use the same buswidth). The limitation is when the 16-bit address is
+	 * used without enough dummy cycles and the opcode is using a different
+	 * buswidth than the address.
+	 */
 	if (op->addr.buswidth) {
 		switch (op->addr.nbytes) {
 		case 0:
@@ -264,6 +275,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		}
 	}
 
+	/* offset of the data access in the QSPI memory space */
+	*offset = iar;
+
 	/* Set number of dummy cycles */
 	if (dummy_cycles)
 		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
@@ -272,16 +286,51 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->data.nbytes)
 		ifr |= QSPI_IFR_DATAEN;
 
-	if (op->data.dir == SPI_MEM_DATA_OUT)
-		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+	/*
+	 * If the QSPI controller is set in regular SPI mode, set it in
+	 * Serial Memory Mode (SMM).
+	 */
+	if (aq->mr != QSPI_MR_SMM) {
+		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+		aq->mr = QSPI_MR_SMM;
+	}
 
 	/* Clear pending interrupts */
 	(void)readl_relaxed(aq->regs + QSPI_SR);
 
-	/* Set QSPI Instruction Frame registers */
-	writel_relaxed(iar, aq->regs + QSPI_IAR);
-	writel_relaxed(icr, aq->regs + QSPI_ICR);
-	writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	if (aq->caps->has_ricr) {
+		if (!op->addr.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+			ifr |= QSPI_IFR_APBTFRTYP_READ;
+
+		/* Set QSPI Instruction Frame registers */
+		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			writel_relaxed(icr, aq->regs + QSPI_RICR);
+		else
+			writel_relaxed(icr, aq->regs + QSPI_WICR);
+		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	} else {
+		if (op->data.dir == SPI_MEM_DATA_OUT)
+			ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+
+		/* Set QSPI Instruction Frame registers */
+		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		writel_relaxed(icr, aq->regs + QSPI_ICR);
+		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	}
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	u32 sr, offset;
+	int err;
+
+	err = atmel_qspi_set_cfg(aq, op, &offset);
+	if (err)
+		return err;
 
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -290,11 +339,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 		/* Send/Receive data */
 		if (op->data.dir == SPI_MEM_DATA_IN)
-			_memcpy_fromio(op->data.buf.in,
-				aq->mem + iar, op->data.nbytes);
+			_memcpy_fromio(op->data.buf.in, aq->mem + offset,
+				       op->data.nbytes);
 		else
-			_memcpy_toio(aq->mem + iar,
-				op->data.buf.out, op->data.nbytes);
+			_memcpy_toio(aq->mem + offset, op->data.buf.out,
+				     op->data.nbytes);
 
 		/* Release the chip-select */
 		writel_relaxed(QSPI_CR_LASTXFER, aq->regs + QSPI_CR);
@@ -450,28 +499,55 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
+	aq->caps = of_device_get_match_data(&pdev->dev);
+	if (!aq->caps) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (aq->caps->has_qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick = devm_clk_get(&pdev->dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(&pdev->dev, "missing system clock\n");
+			err = PTR_ERR(aq->qspick);
+			goto disable_pclk;
+		}
+
+		/* Enable the QSPI system clock */
+		err = clk_prepare_enable(aq->qspick);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to enable the QSPI system clock\n");
+			goto disable_pclk;
+		}
+	}
+
 	/* Request the IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing IRQ\n");
 		err = irq;
-		goto disable_pclk;
+		goto disable_qspick;
 	}
 	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
 
 	err = atmel_qspi_init(aq);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
 
 	err = spi_register_controller(ctrl);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
 
 	return 0;
 
+disable_qspick:
+	clk_disable_unprepare(aq->qspick);
 disable_pclk:
 	clk_disable_unprepare(aq->pclk);
 exit:
@@ -487,6 +563,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
@@ -495,6 +572,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
 
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 
 	return 0;
@@ -505,6 +583,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
 
 	clk_prepare_enable(aq->pclk);
+	clk_prepare_enable(aq->qspick);
 
 	return atmel_qspi_init(aq);
 }
@@ -512,8 +591,22 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
 
+static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {};
+
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
+	.has_qspick = true,
+	.has_ricr = true,
+};
+
 static const struct of_device_id atmel_qspi_dt_ids[] = {
-	{ .compatible = "atmel,sama5d2-qspi" },
+	{
+		.compatible = "atmel,sama5d2-qspi",
+		.data = &atmel_sama5d2_qspi_caps,
+	},
+	{
+		.compatible = "microchip,sam9x60-qspi",
+		.data = &atmel_sam9x60_qspi_caps,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
