Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0245C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7E020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jJsiKD3l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QFS6K0Jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7E020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=054I+x6K/S/h5rug7riVCv6WjZNmFd9p+NxnWNsMcD8=; b=jJsiKD3lTzxvEg
	GhVJNBpERaIydSIDQ6WQte+EAKCyDExdIB9t/OPWyMBCsanu/5Zml/3+3rsC8lpz+MBqcoBu5om+N
	RqpATEcWxEUtXFg7zxg+tgPLj6Mi4iv07r1VlYpjBIj7wG/cZ+oUcvX9w65nFqxE9YJ6LAQL2UL2N
	93IIS9igzT69QNXqnSKph3K+wYYfaAXyNLNXg3VnOv7M7SbDzMJ4KcuGfnkEF0egAxKBiFJbB7jgc
	upQs6LXACeq3KrOaLloTQD/056F6ZpKuIXuTLcl9nui+QK1nGwWqjZrCEWNPyyYon0NmBLLtQ535b
	x4mNyo/2+FYMZMF/zMtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorZE-0004cw-K0; Wed, 30 Jan 2019 15:14:20 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorU6-00071d-4A; Wed, 30 Jan 2019 15:09:40 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="24020814"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 30 Jan 2019 08:08:50 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OaSCpo9vw4gbCsA7Dfhq0e7SofVC7nQqACgXlafFNA=;
 b=QFS6K0Jq3RHwxBxNmWjJeMv4eK0I0eEputSY86wD93YrlfzGpFTOpc8DjZfT20jKBvUTjbjiR3pLJGUDgGNk7aNSFgpkNwJAmxfpbjSpN3SOS5EhN5oKfJRXtIp0Y9V8iHkv/0T9duR8UDUAgzXTb6l65XNngsDOThWvVdQRBXY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1428.namprd11.prod.outlook.com (10.172.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 15:08:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:47 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Index: AQHUuK2zcy+YTju2sU2WL87l1ywXpQ==
Date: Wed, 30 Jan 2019 15:08:47 +0000
Message-ID: <20190130150818.24902-10-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1428;
 6:1LpO6nHFtMoGGoJUrOaT6dbmEGaccXpE2UhKKsMawL1/elV/obA614LPtVu4c0jeaXAWokH5w+nW8++Z7mLOcojlpijuiABSwFFR/Ih2aodtfLYi1yoje4G748m2ZXynGD1tkMoghlThplYmG83m/UQOdVVfF5TZP7Q283HChFpIYufvcL5K0NPq6/TDMHHS0cXLqTa4M8PjnjW70poaz0bCVLioKGCWwzr7RIg4f5uWQ+qZ7KUqGx6j8sN8vfF3/W40SoKOJPtYHp8AWLw/1TUtQ0s7burpvjwXZ6Ju5yGqzjkblntOjFh4dlcDAdyPplufihKqySjXeO7JW7GnIIjOP4LK30LQKdocQ0e6/E1u1DX2ONjGg6W2Du0ilCRmMs8WHGJ0NikJ9G9xgbbLqD5QyMEU4Vd96YFe2AqXvfv53QmPdfhPiNInLrguSVpSQQrAvE79QiW5QPeBa5nbBQ==;
 5:+SWkmFS8iwWKxc0JbFSaDGEkjIItN6Q9vNSv1fBws9twbLlM8jdrjUxU86/Q/DoYXCNjrttmmCzv2vYTHD9/8VqJg5LZArMKc92HspzKL67wnWMT/UtF/cpx1wBoxiFkbzvtWmdLdlOwGq0PhVYz5Cn0KiHK2BTdyVR38GglmV2+oJ+rrAZOdraai2EuqB2lB7ss4aEPbJOZddmxNPUwrA==;
 7:EnJp2xGnuJ8+jWs5q/aOvYwxGugIfND2kU2Gh8aLUYtkMeXAQo7rXEnoGqoMdtFc4mypzeXOOqH++1SwE4SZryeYQ5djLeRgWLHCs3AHqY1KYzCZjMlqC5dhP7DBef/2HmCisuBbLtRm9HJ7EEMpOg==
x-ms-office365-filtering-correlation-id: 27aecd75-affe-4e64-f9af-08d686c4d564
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1428; 
x-ms-traffictypediagnostic: BN6PR11MB1428:
x-microsoft-antispam-prvs: <BN6PR11MB1428CCF4350E760CF636D64FF0900@BN6PR11MB1428.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(6436002)(68736007)(97736004)(6636002)(52116002)(6116002)(186003)(8936002)(50226002)(2501003)(66066001)(26005)(486006)(107886003)(53946003)(3846002)(53936002)(4326008)(110136005)(86362001)(6486002)(71200400001)(81166006)(316002)(6506007)(102836004)(2616005)(11346002)(25786009)(476003)(71190400001)(54906003)(446003)(386003)(105586002)(8676002)(1076003)(305945005)(106356001)(2906002)(81156014)(478600001)(72206003)(7736002)(99286004)(76176011)(30864003)(6512007)(256004)(14454004)(14444005)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1428;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hbGuU+hUgxcL6IT1q2WHukh4nP94+HJZrbrLBKQAfj1/ZIF8xfEDKAYS5eIb+sf1dK6Fpb9fv9fJyEPyL44Lbv+QMmmiaKQvjP4xqUirf/XoWcj6CrixZuqBujcLhyNWbf5Uav7dujhXwuQ40+SBfG5akliAdPuH9x3iocN7yTt1jdVyafC/bZkdki9AC3tSBxENeMjosllboiO+XC9lTqMSCCzifAif9GKA98EPlIle0DXbXfD7kkG4iOBex4EFJcVB60BD7bEkpfVLhIgeaomsxdnu98TZK6EoM68oxuqs+e21Yl6rCoflox0fLWZ0TRUVa5neBb7QbHP10exQ7epIaN3YWxrx9yhMGLjFP9PGCw7p0UwmcySOHTOgkeNgbr5WM93k3RB+aau017s2nN10rudlulAZv74G5EkY9/E=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aecd75-affe-4e64-f9af-08d686c4d564
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:45.5157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1428
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070903_015466_DE73CCE7 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory. It uses
dedicated register for Read Instruction Code Register (RICR) and
Write Instruction Code Register (WICR). ICR/RICR/WICR have identical
fields.

Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 331 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 277 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 1d21db7851e9..bfdc8488f23b 100644
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
@@ -113,6 +116,8 @@
 #define QSPI_IFR_OPTL_4BIT              (2 << 8)
 #define QSPI_IFR_OPTL_8BIT              (3 << 8)
 #define QSPI_IFR_ADDRL                  BIT(10)
+#define QSPI_IFR_TFRTYP_TRSFR_MEM	BIT(12)
+#define QSPI_IFR_TFRTYP_TRSFR_REG	(0 << 12)
 #define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
 #define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
 #define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
@@ -121,6 +126,8 @@
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
+#define QSPI_IFR_APBTFRTYP_WRITE	(0 << 24)
+#define QSPI_IFR_APBTFRTYP_READ		BIT(24)
 
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
@@ -137,15 +144,37 @@
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
 
 
+/* Describes register values. */
+struct atmel_qspi_cfg {
+	u32 icr;
+	u32 iar;
+	u32 ifr;
+};
+
+struct atmel_qspi_caps;
+
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
 	struct clk		*clk;
+	struct clk		*qspick;
 	struct platform_device	*pdev;
+	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	struct completion	cmd_completion;
 };
 
+struct atmel_qspi_ops {
+	int (*clk_prepare_enable)(struct atmel_qspi *aq);
+	void (*clk_disable_unprepare)(struct atmel_qspi *aq);
+	int (*set_qspi_cfg)(struct atmel_qspi *aq, const struct spi_mem_op *op,
+			    struct atmel_qspi_cfg *cfg);
+};
+
+struct atmel_qspi_caps {
+	const struct atmel_qspi_ops *ops;
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -214,23 +243,36 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 	return true;
 }
 
-static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int atmel_qspi_set_mode(struct atmel_qspi_cfg *cfg,
+			       const struct spi_mem_op *op)
 {
-	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
-	int mode;
-	u32 dummy_cycles = 0;
-	u32 iar, icr, ifr, sr;
-	int err = 0;
-
-	iar = 0;
-	icr = QSPI_ICR_INST(op->cmd.opcode);
-	ifr = QSPI_IFR_INSTEN;
+	int mode = atmel_qspi_find_mode(op);
 
-	mode = atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
+	cfg->ifr = QSPI_IFR_INSTEN | sama5d2_qspi_modes[mode].config;
+	return 0;
+}
 
-	ifr |= sama5d2_qspi_modes[mode].config;
+/*
+ * atmel_qspi_set_address_mode() - set address mode.
+ * @cfg:	contains register values
+ * @op:		describes a SPI memory operation
+ *
+ * The controller allows 24 and 32-bit addressing while NAND-flash requires
+ * 16-bit long. Handling 8-bit long addresses is done using the option field.
+ * For the 16-bit addresses, the workaround depends of the number of requested
+ * dummy bits. If there are 8 or more dummy cycles, the address is shifted and
+ * sent with the first dummy byte. Otherwise opcode is disabled and the first
+ * byte of the address contains the command opcode (works only if the opcode and
+ * address use the same buswidth). The limitation is when the 16-bit address is
+ * used without enough dummy cycles and the opcode is using a different buswidth
+ * than the address.
+ */
+static int atmel_qspi_set_address_mode(struct atmel_qspi_cfg *cfg,
+				       const struct spi_mem_op *op)
+{
+	u32 dummy_cycles = 0;
 
 	if (op->dummy.buswidth && op->dummy.nbytes)
 		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
@@ -240,28 +282,28 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		case 0:
 			break;
 		case 1:
-			ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
-			icr |= QSPI_ICR_OPT(op->addr.val & 0xff);
+			cfg->ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			cfg->icr |= QSPI_ICR_OPT(op->addr.val & 0xff);
 			break;
 		case 2:
 			if (dummy_cycles < 8 / op->addr.buswidth) {
-				ifr &= ~QSPI_IFR_INSTEN;
-				ifr |= QSPI_IFR_ADDREN;
-				iar = (op->cmd.opcode << 16) |
-					(op->addr.val & 0xffff);
+				cfg->ifr &= ~QSPI_IFR_INSTEN;
+				cfg->ifr |= QSPI_IFR_ADDREN;
+				cfg->iar = (op->cmd.opcode << 16) |
+					   (op->addr.val & 0xffff);
 			} else {
-				ifr |= QSPI_IFR_ADDREN;
-				iar = (op->addr.val << 8) & 0xffffff;
+				cfg->ifr |= QSPI_IFR_ADDREN;
+				cfg->iar = (op->addr.val << 8) & 0xffffff;
 				dummy_cycles -= 8 / op->addr.buswidth;
 			}
 			break;
 		case 3:
-			ifr |= QSPI_IFR_ADDREN;
-			iar = op->addr.val & 0xffffff;
+			cfg->ifr |= QSPI_IFR_ADDREN;
+			cfg->iar = op->addr.val & 0xffffff;
 			break;
 		case 4:
-			ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
-			iar = op->addr.val & 0x7ffffff;
+			cfg->ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
+			cfg->iar = op->addr.val & 0x7ffffff;
 			break;
 		default:
 			return -ENOTSUPP;
@@ -270,24 +312,99 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	/* Set number of dummy cycles */
 	if (dummy_cycles)
-		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
+		cfg->ifr |= QSPI_IFR_NBDUM(dummy_cycles);
 
-	/* Set data enable */
-	if (op->data.nbytes)
-		ifr |= QSPI_IFR_DATAEN;
+	return 0;
+}
+
+static int atmel_sama5d2_qspi_set_cfg(struct atmel_qspi *aq,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret = atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
 
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
-		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
+		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
 	else
-		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
+		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |= QSPI_IFR_DATAEN;
+
+	ret = atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
+
+	/* Clear pending interrupts */
+	(void)atmel_qspi_readl(aq, QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
+	atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
+	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
+
+	return 0;
+}
+
+static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret = atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
+
+	if (!op->addr.nbytes) {
+		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
+		if (op->data.dir == SPI_MEM_DATA_OUT)
+			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
+		else
+			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
+	} else {
+		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;
+	}
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |= QSPI_IFR_DATAEN;
+
+	ret = atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
 
 	/* Clear pending interrupts */
 	(void)atmel_qspi_readl(aq, QSPI_SR);
 
 	/* Set QSPI Instruction Frame registers */
-	atmel_qspi_writel(aq, QSPI_IAR, iar);
-	atmel_qspi_writel(aq, QSPI_ICR, icr);
-	atmel_qspi_writel(aq, QSPI_IFR, ifr);
+	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
+	else
+		atmel_qspi_writel(aq, QSPI_RICR, cfg->icr);
+	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	struct atmel_qspi_cfg cfg = {0};
+	u32 sr;
+	int err;
+
+	err = aq->caps->ops->set_qspi_cfg(aq, op, &cfg);
+	if (err)
+		return err;
 
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -296,11 +413,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 		/* Send/Receive data */
 		if (op->data.dir == SPI_MEM_DATA_IN)
-			_memcpy_fromio(op->data.buf.in,
-				aq->mem + iar, op->data.nbytes);
+			_memcpy_fromio(op->data.buf.in, aq->mem + cfg.iar,
+				       op->data.nbytes);
 		else
-			_memcpy_toio(aq->mem + iar,
-				op->data.buf.out, op->data.nbytes);
+			_memcpy_toio(aq->mem + cfg.iar, op->data.buf.out,
+				     op->data.nbytes);
 
 		/* Release the chip-select */
 		atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
@@ -395,10 +512,84 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int atmel_sama5d2_qspi_clk_prepare_enable(struct atmel_qspi *aq)
+{
+	int ret;
+
+	if (!aq->clk) {
+		/* Get the peripheral clock */
+		aq->clk = devm_clk_get(&aq->pdev->dev, NULL);
+		if (IS_ERR(aq->clk)) {
+			dev_err(&aq->pdev->dev, "missing peripheral clock\n");
+			return PTR_ERR(aq->clk);
+		}
+	}
+
+	/* Enable the peripheral clock */
+	ret = clk_prepare_enable(aq->clk);
+	if (ret)
+		dev_err(&aq->pdev->dev,
+			"failed to enable the peripheral clock\n");
+
+	return ret;
+}
+
+static void atmel_sama5d2_qspi_clk_disable_unprepare(struct atmel_qspi *aq)
+{
+	clk_disable_unprepare(aq->clk);
+}
+
+static int atmel_sam9x60_qspi_clk_prepare_enable(struct atmel_qspi *aq)
+{
+	struct device *dev = &aq->pdev->dev;
+	int ret;
+
+	if (!aq->clk) {
+		/* Get the peripheral clock */
+		aq->clk = devm_clk_get(dev, "pclk");
+		if (IS_ERR(aq->clk)) {
+			dev_err(dev, "missing peripheral clock\n");
+			return PTR_ERR(aq->clk);
+		}
+	}
+
+	if (!aq->qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick = devm_clk_get(dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(dev, "missing system clock\n");
+			return PTR_ERR(aq->qspick);
+		}
+	}
+
+	/* Enable the peripheral clock */
+	ret = clk_prepare_enable(aq->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable the peripheral clock\n");
+		return ret;
+	}
+
+	/* Enable the QSPI system clock */
+	ret = clk_prepare_enable(aq->qspick);
+	if (ret) {
+		dev_err(dev, "failed to enable the QSPI system clock\n");
+		clk_disable_unprepare(aq->clk);
+	}
+
+	return ret;
+}
+
+static void atmel_sam9x60_qspi_clk_disable_unprepare(struct atmel_qspi *aq)
+{
+	clk_disable_unprepare(aq->qspick);
+	clk_disable_unprepare(aq->clk);
+}
+
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
+	const struct atmel_qspi_caps *caps;
 	struct resource *res;
 	int irq, err = 0;
 
@@ -437,20 +628,22 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	/* Get the peripheral clock */
-	aq->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(aq->clk)) {
-		dev_err(&pdev->dev, "missing peripheral clock\n");
-		err = PTR_ERR(aq->clk);
-		goto exit;
+	caps = of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		return -EINVAL;
 	}
 
-	/* Enable the peripheral clock */
-	err = clk_prepare_enable(aq->clk);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
-		goto exit;
+	if (!caps->ops->clk_prepare_enable ||
+	    !caps->ops->clk_disable_unprepare || !caps->ops->set_qspi_cfg) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI ops\n");
+		return -EINVAL;
 	}
+	aq->caps = caps;
+
+	err = caps->ops->clk_prepare_enable(aq);
+	if (err)
+		return err;
 
 	/* Request the IRQ */
 	irq = platform_get_irq(pdev, 0);
@@ -475,7 +668,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
 exit:
 	spi_controller_put(ctrl);
 
@@ -486,18 +679,20 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl = platform_get_drvdata(pdev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	const struct atmel_qspi_caps *caps = aq->caps;
 
 	spi_unregister_controller(ctrl);
 	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
 	return 0;
 }
 
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
+	const struct atmel_qspi_caps *caps = aq->caps;
 
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
 
 	return 0;
 }
@@ -505,8 +700,9 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 static int __maybe_unused atmel_qspi_resume(struct device *dev)
 {
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
+	const struct atmel_qspi_caps *caps = aq->caps;
 
-	clk_prepare_enable(aq->clk);
+	caps->ops->clk_prepare_enable(aq);
 
 	return atmel_qspi_init(aq);
 }
@@ -514,8 +710,35 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
 
+static const struct atmel_qspi_ops atmel_sama5d2_qspi_ops = {
+	.clk_prepare_enable = atmel_sama5d2_qspi_clk_prepare_enable,
+	.clk_disable_unprepare = atmel_sama5d2_qspi_clk_disable_unprepare,
+	.set_qspi_cfg = atmel_sama5d2_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {
+	.ops = &atmel_sama5d2_qspi_ops,
+};
+
+static const struct atmel_qspi_ops atmel_sam9x60_qspi_ops = {
+	.clk_prepare_enable = atmel_sam9x60_qspi_clk_prepare_enable,
+	.clk_disable_unprepare = atmel_sam9x60_qspi_clk_disable_unprepare,
+	.set_qspi_cfg = atmel_sam9x60_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
+	.ops = &atmel_sam9x60_qspi_ops,
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
