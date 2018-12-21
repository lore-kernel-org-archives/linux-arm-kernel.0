Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8543C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:47:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FAD20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nR8n76v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FAD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mU1S3dy0D/7js9sTG6Z8u+J0P9eCxxLNjjDagtbaRuQ=; b=nR8n76v14cK/W4
	H9vmBmtxJ5E/jt98zNkEICQl9/lQHWgRS34b52STDb4Xf6IywVdWlE52Mtb7+Whe+qTr7wuefZ5/S
	E8sc6ma1AXkG5ZWo9p/A1uTwqzrqbL/UBU2+ENprmmJcCV9UA/CCs/vJalArfws4JV0mxdPgFBYzU
	h9Ar5f7oVI+lx7Ihi2uMB9eol8sA5XkMKUILKfe3xcsnatu9sX0o/y0g6WkfMEyPTVGEvrTepVbzX
	5knR2XDk+gTldeY5J0vcHplqi+Bt0bKftlixplndyzTvDY+F9j6acZs8D6QbVl3C8bWvoF2WdbLq7
	rnniz2ajlmunkqSyVSZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaL9I-0004ML-JE; Fri, 21 Dec 2018 13:47:32 +0000
Received: from mxout013.mail.hostpoint.ch ([2a00:d70:0:e::313])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaL8w-0003y7-Jt
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 13:47:13 +0000
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
 by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1gaL8d-000BDo-P1; Fri, 21 Dec 2018 14:46:51 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
 by asmtp013.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1gaL8d-000BCi-Jf; Fri, 21 Dec 2018 14:46:51 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From: Philippe Schenker <dev@pschenker.ch>
To: jic23@kernel.org,
	marcel.ziswiler@toradex.com,
	stefan@agner.ch
Subject: [PATCH v5 4/8] Input: stmpe-ts: preparations for STMPE ADC driver
Date: Fri, 21 Dec 2018 14:46:33 +0100
Message-Id: <20181221134638.20600-5-dev@pschenker.ch>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221134638.20600-1-dev@pschenker.ch>
References: <20181221134638.20600-1-dev@pschenker.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_054710_671947_BD37BA53 
X-CRM114-Status: GOOD (  13.69  )
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
 linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-input@vger.kernel.org,
 digetx@gmail.com, shawnguo@kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, coquelin.stm32@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This patch removes common ADC settings in favor to use
stmpe811_adc_common_init that is present in MFD. This is necessary in
preparation for the stmpe-adc driver, because those two drivers have
common settings for the ADC.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v5:
 - Changed author of commit to use correct email.

Changes in v4:
 - New patch: Split changes in stmpe-ts.c to a separate commit
 - Remove common adc settings from init and call the
   stmpe811_adc_common_init function

Changes in v3:
 - Undo ADC-settings related code-deletions in stmpe-ts.c that the code
   is backwards-compatible to older devicetrees.

Changes in v2: None

 drivers/input/touchscreen/stmpe-ts.c | 42 +++++-----------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index c5d9006588a2..cf9c9aa39f6e 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -30,8 +30,6 @@
  * with touchscreen controller
  */
 #define STMPE_REG_INT_STA		0x0B
-#define STMPE_REG_ADC_CTRL1		0x20
-#define STMPE_REG_ADC_CTRL2		0x21
 #define STMPE_REG_TSC_CTRL		0x40
 #define STMPE_REG_TSC_CFG		0x41
 #define STMPE_REG_FIFO_TH		0x4A
@@ -58,15 +56,6 @@
  * @idev: registered input device
  * @work: a work item used to scan the device
  * @dev: a pointer back to the MFD cell struct device*
- * @sample_time: ADC converstion time in number of clock.
- * (0 -> 36 clocks, 1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks,
- * 4 -> 80 clocks, 5 -> 96 clocks, 6 -> 144 clocks),
- * recommended is 4.
- * @mod_12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
- * @ref_sel: ADC reference source
- * (0 -> internal reference, 1 -> external reference)
- * @adc_freq: ADC Clock speed
- * (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
  * @ave_ctrl: Sample average control
  * (0 -> 1 sample, 1 -> 2 samples, 2 -> 4 samples, 3 -> 8 samples)
  * @touch_det_delay: Touch detect interrupt delay
@@ -88,10 +77,6 @@ struct stmpe_touch {
 	struct input_dev *idev;
 	struct delayed_work work;
 	struct device *dev;
-	u8 sample_time;
-	u8 mod_12b;
-	u8 ref_sel;
-	u8 adc_freq;
 	u8 ave_ctrl;
 	u8 touch_det_delay;
 	u8 settling;
@@ -192,7 +177,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 static int stmpe_init_hw(struct stmpe_touch *ts)
 {
 	int ret;
-	u8 adc_ctrl1, adc_ctrl1_mask, tsc_cfg, tsc_cfg_mask;
+	u8 tsc_cfg, tsc_cfg_mask;
 	struct stmpe *stmpe = ts->stmpe;
 	struct device *dev = ts->dev;
 
@@ -202,22 +187,9 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 		return ret;
 	}
 
-	adc_ctrl1 = STMPE_SAMPLE_TIME(ts->sample_time) |
-		    STMPE_MOD_12B(ts->mod_12b) | STMPE_REF_SEL(ts->ref_sel);
-	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
-			 STMPE_REF_SEL(0xff);
-
-	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
-			adc_ctrl1_mask, adc_ctrl1);
-	if (ret) {
-		dev_err(dev, "Could not setup ADC\n");
-		return ret;
-	}
-
-	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
-			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(ts->adc_freq));
+	ret = stmpe811_adc_common_init(stmpe);
 	if (ret) {
-		dev_err(dev, "Could not setup ADC\n");
+		stmpe_disable(stmpe, STMPE_BLOCK_TOUCHSCREEN | STMPE_BLOCK_ADC);
 		return ret;
 	}
 
@@ -295,13 +267,13 @@ static void stmpe_ts_get_platform_info(struct platform_device *pdev,
 
 	if (np) {
 		if (!of_property_read_u32(np, "st,sample-time", &val))
-			ts->sample_time = val;
+			ts->stmpe->sample_time = val;
 		if (!of_property_read_u32(np, "st,mod-12b", &val))
-			ts->mod_12b = val;
+			ts->stmpe->mod_12b = val;
 		if (!of_property_read_u32(np, "st,ref-sel", &val))
-			ts->ref_sel = val;
+			ts->stmpe->ref_sel = val;
 		if (!of_property_read_u32(np, "st,adc-freq", &val))
-			ts->adc_freq = val;
+			ts->stmpe->adc_freq = val;
 		if (!of_property_read_u32(np, "st,ave-ctrl", &val))
 			ts->ave_ctrl = val;
 		if (!of_property_read_u32(np, "st,touch-det-delay", &val))
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
