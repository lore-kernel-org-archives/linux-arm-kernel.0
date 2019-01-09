Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2558CC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:56:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABC2206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O+qxbg3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABC2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vE+d2Y0aHbLnHI+sn/DHoC2jyapUB/jyGnnZqi7yCBM=; b=O+qxbg3is6IpIw
	YmNcQJVjsmyJTXng6pgrZu0YadWeF8+GXhgV9DsV88nuwvTj06M3YKM7sIYtz3xjpgoL5eiP0HiRq
	M2pWWaEouqFFD5BFdzV1dCgrZ5VkpWKGEi1tZb5UYDF26xKgbNd8+2dFCOv4sWvXFmVdeZslPRtrz
	arXESzqLNhbTO4tSsDYOyMCagsys8VLowMn6wtFncnJm2TSfBKcmrAZoT40rSYusPkmn7qdpFAGUP
	KqucLOg697ND/ymE8Mzo/0ZuTpleJCN0hPWhxlV74z+Prc/gY97aRDkV6ns+iTfg2O2xwCP2sgUg5
	8B8noNqtVn3ZUTyTSGlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghELX-00066P-Cs; Wed, 09 Jan 2019 13:56:39 +0000
Received: from mxout012.mail.hostpoint.ch ([2a00:d70:0:e::312])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghE7u-0006C1-Da
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:42:38 +0000
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
 by mxout012.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1ghE7j-000DGa-Me; Wed, 09 Jan 2019 14:42:23 +0100
Received: from 252.222.41.212.static.wline.lns.sme.cust.swisscom.ch
 ([212.41.222.252] helo=philippe-pc.toradex.int)
 by asmtp012.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1ghE7j-0006KA-Gg; Wed, 09 Jan 2019 14:42:23 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From: Philippe Schenker <dev@pschenker.ch>
To: jic23@kernel.org,
	marcel.ziswiler@toradex.com,
	stefan@agner.ch
Subject: [PATCH v6 2/8] mfd: stmpe: Move ADC related defines to header of mfd
Date: Wed,  9 Jan 2019 14:42:01 +0100
Message-Id: <20190109134208.5660-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109134208.5660-1-dev@pschenker.ch>
References: <20190109134208.5660-1-dev@pschenker.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_054234_515295_7A305A0F 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: robh@kernel.org, alexandre.torgue@st.com, lee.jones@linaro.org,
 dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 mcoquelin.stm32@gmail.com, linux-input@vger.kernel.org, digetx@gmail.com,
 shawnguo@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Move defines that are ADC related to the header of the overlying mfd,
so they can be used from multiple sub-devices.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

Changes in v6: None
Changes in v5:
 - Changed author of commit to use correct email

Changes in v4:
 - Added Lee Jone's Ack
 - Added Dmitry Torokhov's Ack

Changes in v3: None
Changes in v2:
 - This is a new added commit. Separate commit for moving the defines
   out of drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device
   drivers/mfd/stmpe.c
 - Pre-fix defines with STMPE_

 drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
 include/linux/mfd/stmpe.h            | 11 +++++++++
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 2a78e27b4495..c5d9006588a2 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -49,17 +49,6 @@
 
 #define STMPE_IRQ_TOUCH_DET		0
 
-#define SAMPLE_TIME(x)			((x & 0xf) << 4)
-#define MOD_12B(x)			((x & 0x1) << 3)
-#define REF_SEL(x)			((x & 0x1) << 1)
-#define ADC_FREQ(x)			(x & 0x3)
-#define AVE_CTRL(x)			((x & 0x3) << 6)
-#define DET_DELAY(x)			((x & 0x7) << 3)
-#define SETTLING(x)			(x & 0x7)
-#define FRACTION_Z(x)			(x & 0x7)
-#define I_DRIVE(x)			(x & 0x1)
-#define OP_MODE(x)			((x & 0x7) << 1)
-
 #define STMPE_TS_NAME			"stmpe-ts"
 #define XY_MASK				0xfff
 
@@ -213,9 +202,10 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 		return ret;
 	}
 
-	adc_ctrl1 = SAMPLE_TIME(ts->sample_time) | MOD_12B(ts->mod_12b) |
-		REF_SEL(ts->ref_sel);
-	adc_ctrl1_mask = SAMPLE_TIME(0xff) | MOD_12B(0xff) | REF_SEL(0xff);
+	adc_ctrl1 = STMPE_SAMPLE_TIME(ts->sample_time) |
+		    STMPE_MOD_12B(ts->mod_12b) | STMPE_REF_SEL(ts->ref_sel);
+	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
+			 STMPE_REF_SEL(0xff);
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
 			adc_ctrl1_mask, adc_ctrl1);
@@ -225,15 +215,17 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
-			ADC_FREQ(0xff), ADC_FREQ(ts->adc_freq));
+			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(ts->adc_freq));
 	if (ret) {
 		dev_err(dev, "Could not setup ADC\n");
 		return ret;
 	}
 
-	tsc_cfg = AVE_CTRL(ts->ave_ctrl) | DET_DELAY(ts->touch_det_delay) |
-			SETTLING(ts->settling);
-	tsc_cfg_mask = AVE_CTRL(0xff) | DET_DELAY(0xff) | SETTLING(0xff);
+	tsc_cfg = STMPE_AVE_CTRL(ts->ave_ctrl) |
+		  STMPE_DET_DELAY(ts->touch_det_delay) |
+		  STMPE_SETTLING(ts->settling);
+	tsc_cfg_mask = STMPE_AVE_CTRL(0xff) | STMPE_DET_DELAY(0xff) |
+		       STMPE_SETTLING(0xff);
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_CFG, tsc_cfg_mask, tsc_cfg);
 	if (ret) {
@@ -242,14 +234,14 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_FRACTION_Z,
-			FRACTION_Z(0xff), FRACTION_Z(ts->fraction_z));
+			STMPE_FRACTION_Z(0xff), STMPE_FRACTION_Z(ts->fraction_z));
 	if (ret) {
 		dev_err(dev, "Could not config touch\n");
 		return ret;
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_I_DRIVE,
-			I_DRIVE(0xff), I_DRIVE(ts->i_drive));
+			STMPE_I_DRIVE(0xff), STMPE_I_DRIVE(ts->i_drive));
 	if (ret) {
 		dev_err(dev, "Could not config touch\n");
 		return ret;
@@ -263,7 +255,7 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_CTRL,
-			OP_MODE(0xff), OP_MODE(OP_MOD_XYZ));
+			STMPE_OP_MODE(0xff), STMPE_OP_MODE(OP_MOD_XYZ));
 	if (ret) {
 		dev_err(dev, "Could not set mode\n");
 		return ret;
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index 4a827af17e59..c0353f6431f9 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -10,6 +10,17 @@
 
 #include <linux/mutex.h>
 
+#define STMPE_SAMPLE_TIME(x)	((x & 0xf) << 4)
+#define STMPE_MOD_12B(x)	((x & 0x1) << 3)
+#define STMPE_REF_SEL(x)	((x & 0x1) << 1)
+#define STMPE_ADC_FREQ(x)	(x & 0x3)
+#define STMPE_AVE_CTRL(x)	((x & 0x3) << 6)
+#define STMPE_DET_DELAY(x)	((x & 0x7) << 3)
+#define STMPE_SETTLING(x)	(x & 0x7)
+#define STMPE_FRACTION_Z(x)	(x & 0x7)
+#define STMPE_I_DRIVE(x)	(x & 0x1)
+#define STMPE_OP_MODE(x)	((x & 0x7) << 1)
+
 struct device;
 struct regulator;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
