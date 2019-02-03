Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17458C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED2D21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRIZv1E6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSBKbq+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED2D21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dzpizKJPGyc0sjAIeTTNKclgm3Tk5NTTSehYTUrCnLQ=; b=gRIZv1E6PN0XlL
	Aymxn7fAnvLzsbHT5ohz9PoNtw/cxrKvFQ10CK0y6vx8AWjFWap12+lP2lkZNFrkWLfSE7Ptm7s5u
	DxG9ySU9aD8XT4zkuhOdpv1L9CY9Azodijn6qsarmwBbsdCc/QEgQPvmL89e6hvpxUMZMKIOIzjmY
	4FWz3DUoxOfmM4D/ReIrYWooaMRu9Jcaj+KyHVj9iEFcACVI5hkSYtuo4wHv8JW3ZGU7bNvZ0aNhP
	UAiLMc6qqrT7SDChqvwezF+pDFlcIwoXJfOO5lAzhlITYpn0zK8Dsh9skd7Mx6NAwMf9VqKZEAkn3
	V/dIgxHd3to1AlpYWiOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMw1-0005d8-H0; Sun, 03 Feb 2019 18:56:05 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvZ-00059v-RD
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:55:44 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so5729385pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jm5amfWkS3g5Hb8XjDhfzNWCLhwXk8B1sXZw9lm0n5s=;
 b=hSBKbq+F6Mn1Ti8CWh6hTcw/xAznLU1Nh+gO16QevbBztft0uvhcsBgyLXSfjvBXB7
 iRx1I6LpNNqCZbj6rq5KWFTbBKKpyKJdxc2sGG98h4ZdCSYKxvT5APTL2gZxC92AfXKL
 B6nxA0DXw/wNS0txsGg1awwizfFXcmWDQckNdvmTttcGgz4Mc9srD+QbVbFjIR8T/TGs
 cKixY3I4amAdocFUPdIzum2DDn43+lUXGi10+rkPgs5sU1wUAHJAEARSd76ISi/6PbB+
 W8fNVEtXxrm9+HlHbRisHIBHO7SaLWethnXN8J3nCN1IVMmvi0UdJ1ak052LYYo3AWcJ
 fcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jm5amfWkS3g5Hb8XjDhfzNWCLhwXk8B1sXZw9lm0n5s=;
 b=DgL0acajpTqUyGmcCW2cAac0+1FLtlM+cA6n5Xb3/V9BeBAnxlxGr5Ywmf5rb6gvfZ
 VGanb6XlU44g5kXfbAI95NffHLyLub9kjBI+h3NBhcci5y8KYmDwtyt3XbTL7uCY3PvP
 sZBHFxjeeWKZuKHtNrZAsm3DgLUscNqf/2g1ptNJoFUOxGjv4DZYGP7xOg+EMTdUYMFi
 18nrLmc6bhZtZcf0b5+gmFZk5a4sC2JiOLUFcgoQZYyOoRtv7gAOBFFs+NTIVcDOKQRw
 Z0YbRrGh+zBVl7fT/debJynGiirSvqiGNWpKg46krjKqKN9PAj6IqoYv0e4NEoIKeJJ0
 yIZw==
X-Gm-Message-State: AHQUAuYf63qq/0d9wEg7ymi5YkZVUv6tQD9AYd2kR+ELTcaJtbhi/6If
 LD2YQHvnoWQmNxdxHuKeByNa4Q6N1HM=
X-Google-Smtp-Source: AHgI3Iafi0nZMU+bpfYbN5SNIxt8rp3A0/tP5l7hs+6mLIGh0ACTXUIbo3NYfrWYCwSxP8+LOo9w0w==
X-Received: by 2002:a63:cf02:: with SMTP id j2mr10398790pgg.113.1549220137243; 
 Sun, 03 Feb 2019 10:55:37 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:36 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v2 03/12] drm/bridge: extract some Analogix I2C DP
 common code
Date: Sun,  3 Feb 2019 10:54:52 -0800
Message-Id: <20190203185501.8958-4-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105538_155377_4D7B5EB3 
X-CRM114-Status: GOOD (  22.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Some code can be shared within different DP bridges by Analogix.

Extract them to a new module.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/Kconfig       |   4 +
 drivers/gpu/drm/bridge/analogix/Makefile      |   2 +
 .../drm/bridge/analogix/analogix-anx78xx.c    | 146 +--------------
 .../drm/bridge/analogix/analogix-i2c-dptx.c   | 169 ++++++++++++++++++
 .../drm/bridge/analogix/analogix-i2c-dptx.h   |   2 +
 5 files changed, 178 insertions(+), 145 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c

diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index c4d343a2f04d..ed2d05c12546 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -1,5 +1,6 @@
 config DRM_ANALOGIX_ANX78XX
 	tristate "Analogix ANX78XX bridge"
+	select DRM_ANALOGIX_DP_I2C
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
 	help
@@ -11,3 +12,6 @@ config DRM_ANALOGIX_ANX78XX
 config DRM_ANALOGIX_DP
 	tristate
 	depends on DRM
+
+config DRM_ANALOGIX_DP_I2C
+	tristate
diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
index ce1687e60975..2d523b67487d 100644
--- a/drivers/gpu/drm/bridge/analogix/Makefile
+++ b/drivers/gpu/drm/bridge/analogix/Makefile
@@ -1,3 +1,5 @@
 analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
+analogix_dp_i2c-objs := analogix-i2c-dptx.o
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
+obj-$(CONFIG_DRM_ANALOGIX_DP_I2C) += analogix_dp_i2c.o
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index f8433c93f463..bf8291d0ddd0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -45,8 +45,6 @@
 #define I2C_IDX_RX_P1		4
 
 #define XTAL_CLK		270 /* 27M */
-#define AUX_CH_BUFFER_SIZE	16
-#define AUX_WAIT_TIMEOUT_MS	15
 
 static const u8 anx78xx_i2c_addresses[] = {
 	[I2C_IDX_TX_P0] = TX_P0,
@@ -109,153 +107,11 @@ static int anx78xx_clear_bits(struct regmap *map, u8 reg, u8 mask)
 	return regmap_update_bits(map, reg, mask, 0);
 }
 
-static bool anx78xx_aux_op_finished(struct anx78xx *anx78xx)
-{
-	unsigned int value;
-	int err;
-
-	err = regmap_read(anx78xx->map[I2C_IDX_TX_P0], SP_DP_AUX_CH_CTRL2_REG,
-			  &value);
-	if (err < 0)
-		return false;
-
-	return (value & SP_AUX_EN) == 0;
-}
-
-static int anx78xx_aux_wait(struct anx78xx *anx78xx)
-{
-	unsigned long timeout;
-	unsigned int status;
-	int err;
-
-	timeout = jiffies + msecs_to_jiffies(AUX_WAIT_TIMEOUT_MS) + 1;
-
-	while (!anx78xx_aux_op_finished(anx78xx)) {
-		if (time_after(jiffies, timeout)) {
-			if (!anx78xx_aux_op_finished(anx78xx)) {
-				DRM_ERROR("Timed out waiting AUX to finish\n");
-				return -ETIMEDOUT;
-			}
-
-			break;
-		}
-
-		usleep_range(1000, 2000);
-	}
-
-	/* Read the AUX channel access status */
-	err = regmap_read(anx78xx->map[I2C_IDX_TX_P0], SP_AUX_CH_STATUS_REG,
-			  &status);
-	if (err < 0) {
-		DRM_ERROR("Failed to read from AUX channel: %d\n", err);
-		return err;
-	}
-
-	if (status & SP_AUX_STATUS) {
-		DRM_ERROR("Failed to wait for AUX channel (status: %02x)\n",
-			  status);
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
-static int anx78xx_aux_address(struct anx78xx *anx78xx, unsigned int addr)
-{
-	int err;
-
-	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0], SP_AUX_ADDR_7_0_REG,
-			   addr & 0xff);
-	if (err)
-		return err;
-
-	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0], SP_AUX_ADDR_15_8_REG,
-			   (addr & 0xff00) >> 8);
-	if (err)
-		return err;
-
-	/*
-	 * DP AUX CH Address Register #2, only update bits[3:0]
-	 * [7:4] RESERVED
-	 * [3:0] AUX_ADDR[19:16], Register control AUX CH address.
-	 */
-	err = regmap_update_bits(anx78xx->map[I2C_IDX_TX_P0],
-				 SP_AUX_ADDR_19_16_REG,
-				 SP_AUX_ADDR_19_16_MASK,
-				 (addr & 0xf0000) >> 16);
-
-	if (err)
-		return err;
-
-	return 0;
-}
-
 static ssize_t anx78xx_aux_transfer(struct drm_dp_aux *aux,
 				    struct drm_dp_aux_msg *msg)
 {
 	struct anx78xx *anx78xx = container_of(aux, struct anx78xx, aux);
-	u8 ctrl1 = msg->request;
-	u8 ctrl2 = SP_AUX_EN;
-	u8 *buffer = msg->buffer;
-	int err;
-
-	/* The DP AUX transmit and receive buffer has 16 bytes. */
-	if (WARN_ON(msg->size > AUX_CH_BUFFER_SIZE))
-		return -E2BIG;
-
-	/* Zero-sized messages specify address-only transactions. */
-	if (msg->size < 1)
-		ctrl2 |= SP_ADDR_ONLY;
-	else	/* For non-zero-sized set the length field. */
-		ctrl1 |= (msg->size - 1) << SP_AUX_LENGTH_SHIFT;
-
-	if ((msg->request & DP_AUX_I2C_READ) == 0) {
-		/* When WRITE | MOT write values to data buffer */
-		err = regmap_bulk_write(anx78xx->map[I2C_IDX_TX_P0],
-					SP_DP_BUF_DATA0_REG, buffer,
-					msg->size);
-		if (err)
-			return err;
-	}
-
-	/* Write address and request */
-	err = anx78xx_aux_address(anx78xx, msg->address);
-	if (err)
-		return err;
-
-	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0], SP_DP_AUX_CH_CTRL1_REG,
-			   ctrl1);
-	if (err)
-		return err;
-
-	/* Start transaction */
-	err = regmap_update_bits(anx78xx->map[I2C_IDX_TX_P0],
-				 SP_DP_AUX_CH_CTRL2_REG, SP_ADDR_ONLY |
-				 SP_AUX_EN, ctrl2);
-	if (err)
-		return err;
-
-	err = anx78xx_aux_wait(anx78xx);
-	if (err)
-		return err;
-
-	msg->reply = DP_AUX_I2C_REPLY_ACK;
-
-	if ((msg->size > 0) && (msg->request & DP_AUX_I2C_READ)) {
-		/* Read values from data buffer */
-		err = regmap_bulk_read(anx78xx->map[I2C_IDX_TX_P0],
-				       SP_DP_BUF_DATA0_REG, buffer,
-				       msg->size);
-		if (err)
-			return err;
-	}
-
-	err = anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P0],
-				 SP_DP_AUX_CH_CTRL2_REG, SP_ADDR_ONLY);
-	if (err)
-		return err;
-
-	return msg->size;
+	return anx_aux_transfer(anx78xx->map[I2C_IDX_TX_P0], msg);
 }
 
 static int anx78xx_set_hpd(struct anx78xx *anx78xx)
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
new file mode 100644
index 000000000000..9cb30962032e
--- /dev/null
+++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2017 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on analogix-anx78xx.c, which is:
+ *   Copyright(c) 2016, Analogix Semiconductor. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <drm/drm.h>
+#include <drm/drmP.h>
+#include <drm/drm_dp_helper.h>
+
+#include "analogix-i2c-dptx.h"
+
+#define AUX_WAIT_TIMEOUT_MS	15
+#define AUX_CH_BUFFER_SIZE	16
+
+static int anx_clear_bits(struct regmap *map, u8 reg, u8 mask)
+{
+	return regmap_update_bits(map, reg, mask, 0);
+}
+
+static bool anx_aux_op_finished(struct regmap *map_dptx)
+{
+	unsigned int value;
+	int err;
+
+	err = regmap_read(map_dptx, SP_DP_AUX_CH_CTRL2_REG, &value);
+	if (err < 0)
+		return false;
+
+	return (value & SP_AUX_EN) == 0;
+}
+
+static int anx_aux_wait(struct regmap *map_dptx)
+{
+	unsigned long timeout;
+	unsigned int status;
+	int err;
+
+	timeout = jiffies + msecs_to_jiffies(AUX_WAIT_TIMEOUT_MS) + 1;
+
+	while (!anx_aux_op_finished(map_dptx)) {
+		if (time_after(jiffies, timeout)) {
+			if (!anx_aux_op_finished(map_dptx)) {
+				DRM_ERROR("Timed out waiting AUX to finish\n");
+				return -ETIMEDOUT;
+			}
+
+			break;
+		}
+
+		usleep_range(1000, 2000);
+	}
+
+	/* Read the AUX channel access status */
+	err = regmap_read(map_dptx, SP_AUX_CH_STATUS_REG, &status);
+	if (err < 0) {
+		DRM_ERROR("Failed to read from AUX channel: %d\n", err);
+		return err;
+	}
+
+	if (status & SP_AUX_STATUS) {
+		DRM_ERROR("Failed to wait for AUX channel (status: %02x)\n",
+			  status);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int anx_aux_address(struct regmap *map_dptx, unsigned int addr)
+{
+	int err;
+
+	err = regmap_write(map_dptx, SP_AUX_ADDR_7_0_REG, addr & 0xff);
+	if (err)
+		return err;
+
+	err = regmap_write(map_dptx, SP_AUX_ADDR_15_8_REG,
+			   (addr & 0xff00) >> 8);
+	if (err)
+		return err;
+
+	/*
+	 * DP AUX CH Address Register #2, only update bits[3:0]
+	 * [7:4] RESERVED
+	 * [3:0] AUX_ADDR[19:16], Register control AUX CH address.
+	 */
+	err = regmap_update_bits(map_dptx, SP_AUX_ADDR_19_16_REG,
+				 SP_AUX_ADDR_19_16_MASK,
+				 (addr & 0xf0000) >> 16);
+
+	if (err)
+		return err;
+
+	return 0;
+}
+
+ssize_t anx_aux_transfer(struct regmap *map_dptx, struct drm_dp_aux_msg *msg)
+{
+	u8 ctrl1 = msg->request;
+	u8 ctrl2 = SP_AUX_EN;
+	u8 *buffer = msg->buffer;
+	int err;
+
+	/* The DP AUX transmit and receive buffer has 16 bytes. */
+	if (WARN_ON(msg->size > AUX_CH_BUFFER_SIZE))
+		return -E2BIG;
+
+	/* Zero-sized messages specify address-only transactions. */
+	if (msg->size < 1)
+		ctrl2 |= SP_ADDR_ONLY;
+	else	/* For non-zero-sized set the length field. */
+		ctrl1 |= (msg->size - 1) << SP_AUX_LENGTH_SHIFT;
+
+	if ((msg->request & DP_AUX_I2C_READ) == 0) {
+		/* When WRITE | MOT write values to data buffer */
+		err = regmap_bulk_write(map_dptx,
+					SP_DP_BUF_DATA0_REG, buffer,
+					msg->size);
+		if (err)
+			return err;
+	}
+
+	/* Write address and request */
+	err = anx_aux_address(map_dptx, msg->address);
+	if (err)
+		return err;
+
+	err = regmap_write(map_dptx, SP_DP_AUX_CH_CTRL1_REG, ctrl1);
+	if (err)
+		return err;
+
+	/* Start transaction */
+	err = regmap_update_bits(map_dptx, SP_DP_AUX_CH_CTRL2_REG,
+				 SP_ADDR_ONLY | SP_AUX_EN, ctrl2);
+	if (err)
+		return err;
+
+	err = anx_aux_wait(map_dptx);
+	if (err)
+		return err;
+
+	msg->reply = DP_AUX_I2C_REPLY_ACK;
+
+	if ((msg->size > 0) && (msg->request & DP_AUX_I2C_READ)) {
+		/* Read values from data buffer */
+		err = regmap_bulk_read(map_dptx,
+				       SP_DP_BUF_DATA0_REG, buffer,
+				       msg->size);
+		if (err)
+			return err;
+	}
+
+	err = anx_clear_bits(map_dptx, SP_DP_AUX_CH_CTRL2_REG, SP_ADDR_ONLY);
+	if (err)
+		return err;
+
+	return msg->size;
+}
+EXPORT_SYMBOL(anx_aux_transfer);
+
+MODULE_DESCRIPTION("Analogix DisplayPort Transmitter common code");
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
index bc0831b127bf..c2ca854613a0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
@@ -245,4 +245,6 @@
 /* DP AUX Buffer Data Registers */
 #define SP_DP_BUF_DATA0_REG		0xf0
 
+ssize_t anx_aux_transfer(struct regmap *map_dptx, struct drm_dp_aux_msg *msg);
+
 #endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
