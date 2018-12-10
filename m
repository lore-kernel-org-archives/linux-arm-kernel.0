Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008CCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:44:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38A92081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V9kvUyXK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="TNhQU2+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38A92081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Q4k79mvTmb1QBnXOzvyAIoAKyww2mHohFe1KDbUKts=; b=V9kvUyXK/m96YW
	mbjEta441/4iTQu6571yywLl8SALhujTL19KPOSwSFy0868mrsN0zQubq1RYLOwKiQUC/2KZP3fsi
	g+MTpnj3hIhhle4K2GvyPNdFSr4sLQqyn0DKYECCLJZ+gcxX4ctMYvl3DrDHd4+gQgY6rRzHfc4K2
	/UkP+CZy4FoNmWqUjQwtzMS88e1xkJwxfRBCusU+PbGY9kcySEgAlbAED1xRy+DUHIrw03vZMpwCV
	vsw4pDQ686zFbE4AjcyJrCp/YXFAb8XjVNbHi9s6d6VUrnYarf6vILkzD0cKDco7mtBC1sezgLkJi
	etyYyvqiYDcSvob2rXrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQXW-0004bx-C0; Mon, 10 Dec 2018 18:44:22 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQWI-0003NF-IM
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:43:24 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 085D9418DE;
 Mon, 10 Dec 2018 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544467347; bh=kVazWeoBJTH1RfagB16nCXnVFLnAlX8uPnX2O4aNcZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TNhQU2+9kiHzHr2r0eh6QDKGwUgrDmxrva4AMNBAcOfaUCyc53Kc4MyL6DYlXAh+A
 QRpeLQ5jXhGAebKYSttBEOGHFI9WhVhYVw4mvulJLtXH7YaWP63OzFu3XuphamuXxw
 XXLvsVzoL7SzkVanAn4f6lehF2h9HgihvTiKBl51R+wLJERaKZwxUWuwcCoVGBboQX
 IvVKNEf/pou53ZKd34DtVR8hoMCNS09NeMJ/yvJXcVYygSVhfyIaqkced1ATpsv/jl
 IVvYs87x6UQxJ7drFbtCnMFPveYLrqg6I0n5PQTONtsCt+SBFG7x0+z4ap30+McPS5
 4+ncvWx5W5GHw==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH 4/8] regulator: axp20x: add software based soft_start for
 AXP209 LDO3
Date: Mon, 10 Dec 2018 20:42:15 +0200
Message-Id: <c77b37b68b18a299cafd282ef1edf3434eabeb2d.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_104307_352923_32ABB696 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: Priit Laes <plaes@plaes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

In the past, there have been words on various lists that if LDO3 is
disabled in u-boot, but enabled in the DTS, the axp209 driver would
fail to continue/hang. Several enable/disable patches have been
issues to devicetree's in both the kernel and u-boot to address
this issue.

What really happened however, was that the AXP209 shuts down without
a notice and without setting an interrupt. This is caused when LDO3
gets overloaded, for example with large capacitors on the LDO3 output.

Normally, we would expect that AXP209 would source 200 mA as per
datasheet and set and trigger an interrupt when being overloaded.
For some reason however, this does not happen.

As a work-around, we use the soft-start constraint of the regulator
node to first bring up the LDO3 to the lowest possible voltage and
then enable the LDO. After that, we can set the requested voltage
as usual.

Combining this setting with the regulator-ramp-delay allows LDO3 to
enable voltage slowly and staggered, potentially reducing overall
inrush current.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/regulator/axp20x-regulator.c | 57 ++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1d9fa62..e8a895b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mfd/axp20x.h>
@@ -23,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 
 #define AXP20X_GPIO0_FUNC_MASK		GENMASK(3, 0)
@@ -430,6 +432,59 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
 }
 
+static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
+	const struct regulator_desc *desc = rdev->desc;
+
+	if (!rdev)
+		return -EINVAL;
+
+	switch (axp20x->variant) {
+	case AXP209_ID:
+		if ((desc->id == AXP20X_LDO3) &&
+		    rdev->constraints && rdev->constraints->soft_start) {
+			int v_out;
+			int ret;
+
+			/*
+			 * On some boards, the LDO3 can be overloaded when
+			 * turning on, causing the entire PMIC to shutdown
+			 * without warning. Turning it on at the minimal voltage
+			 * and then setting the voltage to the requested value
+			 * works reliably.
+			 */
+			if (regulator_is_enabled_regmap(rdev))
+				break;
+
+			v_out = regulator_get_voltage_sel_regmap(rdev);
+			if (v_out < 0)
+				return v_out;
+
+			if (v_out == 0)
+				break;
+
+			ret = regulator_set_voltage_sel_regmap(rdev, 0x00);
+			/*
+			 * A small pause is needed between
+			 * setting the voltage and enabling the LDO to give the
+			 * internal state machine time to process the request.
+			 */
+			usleep_range(1000, 5000);
+			ret |= regulator_enable_regmap(rdev);
+			ret |= regulator_set_voltage_sel_regmap(rdev, v_out);
+
+			return ret;
+		}
+		break;
+	default:
+		/* No quirks */
+		break;
+	}
+
+	return regulator_enable_regmap(rdev);
+};
+
 static const struct regulator_ops axp20x_ops_fixed = {
 	.list_voltage		= regulator_list_voltage_linear,
 };
@@ -447,7 +502,7 @@ static const struct regulator_ops axp20x_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-	.enable			= regulator_enable_regmap,
+	.enable			= axp20x_regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.set_ramp_delay		= axp20x_set_ramp_delay,
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
