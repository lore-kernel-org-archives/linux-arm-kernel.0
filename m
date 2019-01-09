Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E2C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF96206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QXpNEguJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF96206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xs/ntA/JJMR8jX9yK/VQoNvnYwQ4n5bLcEZ1T5A76vQ=; b=QXpNEguJdDRD+d
	4NcqeePH4hRKdlaG5d1eO34tROAU5Ath7smRfc4HHoYqSXJS84TbsdqfqGJJnzZ3c8i62mm+JQIrU
	AECF36dgFH0bs2rA8oGGuy9o5dnzDH6xq+s5IMlAbPVLO8S81hhLDCZG5UuZf0aXUHrvHORg6J1gn
	iffISuLlhOMFt/b6maWj4sZCWZLZmnoSVyTlWRv6RAyXwuE/nExGJnBlx7kja5U2yWE6GajlG+pGP
	jTmzdsy5Xhshf14a6Cj0L0auPliSnuR+SV8u+ZfSNsWXw2AxYzSNPMcNbmK90BoOZAxmnR4dXi270
	Yb8tlaNxYilAeKXwjCnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghE7y-0006Di-EA; Wed, 09 Jan 2019 13:42:38 +0000
Received: from mxout014.mail.hostpoint.ch ([2a00:d70:0:e::314])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghE7u-0006C0-CJ
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:42:36 +0000
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
 by mxout014.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1ghE7k-0007Wt-Sd; Wed, 09 Jan 2019 14:42:24 +0100
Received: from 252.222.41.212.static.wline.lns.sme.cust.swisscom.ch
 ([212.41.222.252] helo=philippe-pc.toradex.int)
 by asmtp012.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1ghE7k-0006KA-Mb; Wed, 09 Jan 2019 14:42:24 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From: Philippe Schenker <dev@pschenker.ch>
To: jic23@kernel.org,
	marcel.ziswiler@toradex.com,
	stefan@agner.ch
Subject: [PATCH v6 3/8] mfd: stmpe: preparations for STMPE ADC driver
Date: Wed,  9 Jan 2019 14:42:02 +0100
Message-Id: <20190109134208.5660-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109134208.5660-1-dev@pschenker.ch>
References: <20190109134208.5660-1-dev@pschenker.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_054234_419717_8C16EE0D 
X-CRM114-Status: GOOD (  16.15  )
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
Cc: robh@kernel.org, Max Krummenacher <max.krummenacher@toradex.com>,
 alexandre.torgue@st.com, lee.jones@linaro.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 mcoquelin.stm32@gmail.com, digetx@gmail.com, shawnguo@kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

This prepares the MFD for the STMPE ADC driver. This commit introduces
devicetree settings that are used by the ADC and adds an init function.
Common ADC settings that are shared with the touchscreen driver can now
reside in the overlying MFD.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

---

Changes in v6: None
Changes in v5:
 - Added Lee Jone's Ack
 - Changed author of commit. Previous patch versions author was wrong
   by mistake.

Changes in v4:
 - New patch: split mfd changes into this precursor patch
 - Export the added stmpe811_adc_commmon_init function
 - Disabling adc when mfd is removed

Changes in v3: None
Changes in v2:
 - Move code to setup ADC to MFD device, as it is used by both drivers
   adc and touchscreen

 drivers/mfd/Kconfig       |  3 +-
 drivers/mfd/stmpe.c       | 68 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stmpe.h | 10 ++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdce4326..bba159e8eaa4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1204,7 +1204,7 @@ config MFD_STMPE
 
 	  Currently supported devices are:
 
-		STMPE811: GPIO, Touchscreen
+		STMPE811: GPIO, Touchscreen, ADC
 		STMPE1601: GPIO, Keypad
 		STMPE1801: GPIO, Keypad
 		STMPE2401: GPIO, Keypad
@@ -1217,6 +1217,7 @@ config MFD_STMPE
 		GPIO: stmpe-gpio
 		Keypad: stmpe-keypad
 		Touchscreen: stmpe-ts
+		ADC: stmpe-adc
 
 menu "STMicroelectronics STMPE Interface Drivers"
 depends on MFD_STMPE
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 566caca4efd8..f582531a8f3e 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -463,6 +463,28 @@ static const struct mfd_cell stmpe_ts_cell = {
 	.num_resources	= ARRAY_SIZE(stmpe_ts_resources),
 };
 
+/*
+ * ADC (STMPE811)
+ */
+
+static struct resource stmpe_adc_resources[] = {
+	{
+		.name	= "STMPE_TEMP_SENS",
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "STMPE_ADC",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static const struct mfd_cell stmpe_adc_cell = {
+	.name		= "stmpe-adc",
+	.of_compatible	= "st,stmpe-adc",
+	.resources	= stmpe_adc_resources,
+	.num_resources	= ARRAY_SIZE(stmpe_adc_resources),
+};
+
 /*
  * STMPE811 or STMPE610
  */
@@ -497,6 +519,11 @@ static struct stmpe_variant_block stmpe811_blocks[] = {
 		.irq	= STMPE811_IRQ_TOUCH_DET,
 		.block	= STMPE_BLOCK_TOUCHSCREEN,
 	},
+	{
+		.cell	= &stmpe_adc_cell,
+		.irq	= STMPE811_IRQ_TEMP_SENS,
+		.block	= STMPE_BLOCK_ADC,
+	},
 };
 
 static int stmpe811_enable(struct stmpe *stmpe, unsigned int blocks,
@@ -517,6 +544,35 @@ static int stmpe811_enable(struct stmpe *stmpe, unsigned int blocks,
 				enable ? 0 : mask);
 }
 
+int stmpe811_adc_common_init(struct stmpe *stmpe)
+{
+	int ret;
+	u8 adc_ctrl1, adc_ctrl1_mask;
+
+	adc_ctrl1 = STMPE_SAMPLE_TIME(stmpe->sample_time) |
+		    STMPE_MOD_12B(stmpe->mod_12b) |
+		    STMPE_REF_SEL(stmpe->ref_sel);
+	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
+			 STMPE_REF_SEL(0xff);
+
+	ret = stmpe_set_bits(stmpe, STMPE811_REG_ADC_CTRL1,
+			adc_ctrl1_mask, adc_ctrl1);
+	if (ret) {
+		dev_err(stmpe->dev, "Could not setup ADC\n");
+		return ret;
+	}
+
+	ret = stmpe_set_bits(stmpe, STMPE811_REG_ADC_CTRL2,
+			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(stmpe->adc_freq));
+	if (ret) {
+		dev_err(stmpe->dev, "Could not setup ADC\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stmpe811_adc_common_init);
+
 static int stmpe811_get_altfunc(struct stmpe *stmpe, enum stmpe_block block)
 {
 	/* 0 for touchscreen, 1 for GPIO */
@@ -1325,6 +1381,7 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 	struct device_node *np = ci->dev->of_node;
 	struct stmpe *stmpe;
 	int ret;
+	u32 val;
 
 	pdata = devm_kzalloc(ci->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -1342,6 +1399,15 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 	mutex_init(&stmpe->irq_lock);
 	mutex_init(&stmpe->lock);
 
+	if (!of_property_read_u32(np, "st,sample-time", &val))
+		stmpe->sample_time = val;
+	if (!of_property_read_u32(np, "st,mod-12b", &val))
+		stmpe->mod_12b = val;
+	if (!of_property_read_u32(np, "st,ref-sel", &val))
+		stmpe->ref_sel = val;
+	if (!of_property_read_u32(np, "st,adc-freq", &val))
+		stmpe->adc_freq = val;
+
 	stmpe->dev = ci->dev;
 	stmpe->client = ci->client;
 	stmpe->pdata = pdata;
@@ -1433,6 +1499,8 @@ int stmpe_remove(struct stmpe *stmpe)
 	if (!IS_ERR(stmpe->vcc))
 		regulator_disable(stmpe->vcc);
 
+	__stmpe_disable(stmpe, STMPE_BLOCK_ADC);
+
 	mfd_remove_devices(stmpe->dev);
 
 	return 0;
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index c0353f6431f9..07f55aac9390 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -21,6 +21,9 @@
 #define STMPE_I_DRIVE(x)	(x & 0x1)
 #define STMPE_OP_MODE(x)	((x & 0x7) << 1)
 
+#define STMPE811_REG_ADC_CTRL1	0x20
+#define STMPE811_REG_ADC_CTRL2	0x21
+
 struct device;
 struct regulator;
 
@@ -134,6 +137,12 @@ struct stmpe {
 	u8 ier[2];
 	u8 oldier[2];
 	struct stmpe_platform_data *pdata;
+
+	/* For devices that use an ADC */
+	u8 sample_time;
+	u8 mod_12b;
+	u8 ref_sel;
+	u8 adc_freq;
 };
 
 extern int stmpe_reg_write(struct stmpe *stmpe, u8 reg, u8 data);
@@ -147,6 +156,7 @@ extern int stmpe_set_altfunc(struct stmpe *stmpe, u32 pins,
 			     enum stmpe_block block);
 extern int stmpe_enable(struct stmpe *stmpe, unsigned int blocks);
 extern int stmpe_disable(struct stmpe *stmpe, unsigned int blocks);
+extern int stmpe811_adc_common_init(struct stmpe *stmpe);
 
 #define STMPE_GPIO_NOREQ_811_TOUCH	(0xf0)
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
