Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE250C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D292192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/vShf/v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEFiEAfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D292192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Xjnevz95OLu3rUKx+5uxGQa9Mu36SXLW7X7jVPwT7E=; b=M/vShf/vbWky0T
	HFN0J+L0jZWwG/BOdP97nNjNO4ymOBYXM3BNEJi35rk6FOkZt48s55UrGNwM0T+Obgmb3YcGq+lBP
	zzZlHAY36nVkxZTF73h6xXXG2PSo7Pb8vKMr6eGvx1b7ca9G3vEJ2o/k8NOSwqXBi6gimvMmcyWY0
	9HVWmzryNFEw9zrxRD3bwvDtP3g0ZkrvheaTbykcglJzZzBgPW+TsO26n6fD8WM+4dH5KqUS3yDLe
	WuSpMAH3y+VbH86tz0e5I7YBSrg80HSReX6M+4F+SsdskUjCy5qlkPZLvAZwAqhIlBAqNIeePBFT8
	uMk8bwOZ6qVWVpOMHkwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVmD-0004Hr-6A; Fri, 15 Feb 2019 05:11:05 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVlZ-0003V2-Pi
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:34 +0000
Received: by mail-pl1-x644.google.com with SMTP id bj4so4342851plb.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2HctiEDQDpu3N0HIWLZ2GlTUjz8I2TngZbsNQLJz1FY=;
 b=VEFiEAfAXkAD8zg0WDUErRMIB9gOsq5R9Brj/qL5oMhvdpjMO5aL82BKJDbb61r+5i
 9GCVK0KlLtQ3a3YwDs1AjpYSbjlxn4uTHCVkqEbVWb8bLb7+uFjdN76A99YrA9TY5ac0
 JunAZiuvQ1mHT4bYMRVBrLV25lazZVv4+ltLtMSBdU6CVWF3l6ioQ5+nWi4MG5nuKwjS
 0buWqdNBBfS/4jrfC4a86UcVgt0sWRm5GCu51vSB1OGfRK24LdI/5/6uPcXfR5ivUsP9
 ukkVqAt4byWyNRct0bklYZucIlzWUDmMLh748qHPu2ClOOFyiJaP3xNrW4M6bHRMKkaO
 NpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2HctiEDQDpu3N0HIWLZ2GlTUjz8I2TngZbsNQLJz1FY=;
 b=Cu/caqUKI5oN5czBkeQzwRmhaVMW2cuNtpNV66vwQQGFVXD1yHVaLKEVnuPl9C6dfU
 34Xg4lghqWah1e2RV4zNda8oAIsIlQFekAYUNvje+v03Ydea20n/0jDJkAC057xgVZRe
 n/DDqYrckv+N1HoNdXIeeBXXEaTUKIkB4W2m4z7IvJzT+Yib1iqAmJRvh5LzlUW2Wf9G
 nuGLRsB/YFPdgcg1uIQN4luubKnntidL/+NHMEykW+NJFH4DoaPVcRTnvAJVATLoeThW
 VqZPpmGWXbVsnbt3OucWJpBJm3tNvsvlLGJzslkwQXFLfHkNiRm/gwDT8K73EWunWKm9
 XdUQ==
X-Gm-Message-State: AHQUAubgOCfElwoxDMdwwz6FmdIAxaHCRnDYVlogFTjm7+Pib/MBJCIT
 HIQZCr1o3bx24VyZpl8iwT4=
X-Google-Smtp-Source: AHgI3Ib2Y6g6Xcj+heV6S2uztuG2v8CtYr8gdXTbmEWUraYe5Cen9HsVOZI2U1jeMNuNnWIx8lxnTw==
X-Received: by 2002:a17:902:ab84:: with SMTP id
 f4mr8059272plr.207.1550207424677; 
 Thu, 14 Feb 2019 21:10:24 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:24 -0800 (PST)
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
Subject: [PATCH v3 02/11] drm/bridge: split some definitions of ANX78xx to
 dedicated headers
Date: Thu, 14 Feb 2019 21:09:48 -0800
Message-Id: <20190215050957.20755-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211026_046303_166C1A49 
X-CRM114-Status: GOOD (  13.43  )
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

Some definitions currently in analogix-anx78xx.h are not restricted to
the ANX78xx series, but also applicable to other DisplayPort
transmitters by Analogix.

Split out them to dedicated headers, and make analogix-anx78xx.h include
them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../drm/bridge/analogix/analogix-anx78xx.h    | 464 +-----------------
 .../drm/bridge/analogix/analogix-i2c-dptx.h   | 248 ++++++++++
 .../bridge/analogix/analogix-i2c-txcommon.h   | 237 +++++++++
 3 files changed, 490 insertions(+), 459 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
index 38753c870137..8aa1eca306d3 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
@@ -15,9 +15,12 @@
 #ifndef __ANX78xx_H
 #define __ANX78xx_H
 
-#define TX_P0				0x70
+#include "analogix-i2c-dptx.h"
+#include "analogix-i2c-txcommon.h"
+
+#define TX_P0				ANALOGIX_I2C_DPTX
 #define TX_P1				0x7a
-#define TX_P2				0x72
+#define TX_P2				ANALOGIX_I2C_TXCOMMON
 
 #define RX_P0				0x7e
 #define RX_P1				0x80
@@ -225,463 +228,6 @@
 #define SP_CLEAR_AVMUTE			BIT(4)
 #define SP_SET_AVMUTE			BIT(0)
 
-/***************************************************************/
-/* Register definition of device address 0x70                  */
-/***************************************************************/
-
-/* HDCP Status Register */
-#define SP_TX_HDCP_STATUS_REG		0x00
-#define SP_AUTH_FAIL			BIT(5)
-#define SP_AUTHEN_PASS			BIT(1)
-
-/* HDCP Control Register 0 */
-#define SP_HDCP_CTRL0_REG		0x01
-#define SP_RX_REPEATER			BIT(6)
-#define SP_RE_AUTH			BIT(5)
-#define SP_SW_AUTH_OK			BIT(4)
-#define SP_HARD_AUTH_EN			BIT(3)
-#define SP_HDCP_ENC_EN			BIT(2)
-#define SP_BKSV_SRM_PASS		BIT(1)
-#define SP_KSVLIST_VLD			BIT(0)
-/* HDCP Function Enabled */
-#define SP_HDCP_FUNCTION_ENABLED	(BIT(0) | BIT(1) | BIT(2) | BIT(3))
-
-/* HDCP Receiver BSTATUS Register 0 */
-#define	SP_HDCP_RX_BSTATUS0_REG		0x1b
-/* HDCP Receiver BSTATUS Register 1 */
-#define	SP_HDCP_RX_BSTATUS1_REG		0x1c
-
-/* HDCP Embedded "Blue Screen" Content Registers */
-#define SP_HDCP_VID0_BLUE_SCREEN_REG	0x2c
-#define SP_HDCP_VID1_BLUE_SCREEN_REG	0x2d
-#define SP_HDCP_VID2_BLUE_SCREEN_REG	0x2e
-
-/* HDCP Wait R0 Timing Register */
-#define SP_HDCP_WAIT_R0_TIME_REG	0x40
-
-/* HDCP Link Integrity Check Timer Register */
-#define SP_HDCP_LINK_CHECK_TIMER_REG	0x41
-
-/* HDCP Repeater Ready Wait Timer Register */
-#define SP_HDCP_RPTR_RDY_WAIT_TIME_REG	0x42
-
-/* HDCP Auto Timer Register */
-#define SP_HDCP_AUTO_TIMER_REG		0x51
-
-/* HDCP Key Status Register */
-#define SP_HDCP_KEY_STATUS_REG		0x5e
-
-/* HDCP Key Command Register */
-#define SP_HDCP_KEY_COMMAND_REG		0x5f
-#define SP_DISABLE_SYNC_HDCP		BIT(2)
-
-/* OTP Memory Key Protection Registers */
-#define SP_OTP_KEY_PROTECT1_REG		0x60
-#define SP_OTP_KEY_PROTECT2_REG		0x61
-#define SP_OTP_KEY_PROTECT3_REG		0x62
-#define SP_OTP_PSW1			0xa2
-#define SP_OTP_PSW2			0x7e
-#define SP_OTP_PSW3			0xc6
-
-/* DP System Control Registers */
-#define SP_DP_SYSTEM_CTRL_BASE		(0x80 - 1)
-/* Bits for DP System Control Register 2 */
-#define SP_CHA_STA			BIT(2)
-/* Bits for DP System Control Register 3 */
-#define SP_HPD_STATUS			BIT(6)
-#define SP_STRM_VALID			BIT(2)
-/* Bits for DP System Control Register 4 */
-#define SP_ENHANCED_MODE		BIT(3)
-
-/* DP Video Control Register */
-#define SP_DP_VIDEO_CTRL_REG		0x84
-#define SP_COLOR_F_MASK			0x06
-#define SP_COLOR_F_SHIFT		1
-#define SP_BPC_MASK			0xe0
-#define SP_BPC_SHIFT			5
-#  define SP_BPC_6BITS			0x00
-#  define SP_BPC_8BITS			0x01
-#  define SP_BPC_10BITS			0x02
-#  define SP_BPC_12BITS			0x03
-
-/* DP Audio Control Register */
-#define SP_DP_AUDIO_CTRL_REG		0x87
-#define SP_AUD_EN			BIT(0)
-
-/* 10us Pulse Generate Timer Registers */
-#define SP_I2C_GEN_10US_TIMER0_REG	0x88
-#define SP_I2C_GEN_10US_TIMER1_REG	0x89
-
-/* Packet Send Control Register */
-#define SP_PACKET_SEND_CTRL_REG		0x90
-#define SP_AUD_IF_UP			BIT(7)
-#define SP_AVI_IF_UD			BIT(6)
-#define SP_MPEG_IF_UD			BIT(5)
-#define SP_SPD_IF_UD			BIT(4)
-#define SP_AUD_IF_EN			BIT(3)
-#define SP_AVI_IF_EN			BIT(2)
-#define SP_MPEG_IF_EN			BIT(1)
-#define SP_SPD_IF_EN			BIT(0)
-
-/* DP HDCP Control Register */
-#define SP_DP_HDCP_CTRL_REG		0x92
-#define SP_AUTO_EN			BIT(7)
-#define SP_AUTO_START			BIT(5)
-#define SP_LINK_POLLING			BIT(1)
-
-/* DP Main Link Bandwidth Setting Register */
-#define SP_DP_MAIN_LINK_BW_SET_REG	0xa0
-#define SP_LINK_BW_SET_MASK		0x1f
-#define SP_INITIAL_SLIM_M_AUD_SEL	BIT(5)
-
-/* DP Training Pattern Set Register */
-#define SP_DP_TRAINING_PATTERN_SET_REG	0xa2
-
-/* DP Lane 0 Link Training Control Register */
-#define SP_DP_LANE0_LT_CTRL_REG		0xa3
-#define SP_TX_SW_SET_MASK		0x1b
-#define SP_MAX_PRE_REACH		BIT(5)
-#define SP_MAX_DRIVE_REACH		BIT(4)
-#define SP_PRE_EMP_LEVEL1		BIT(3)
-#define SP_DRVIE_CURRENT_LEVEL1		BIT(0)
-
-/* DP Link Training Control Register */
-#define SP_DP_LT_CTRL_REG		0xa8
-#define SP_LT_ERROR_TYPE_MASK		0x70
-#  define SP_LT_NO_ERROR		0x00
-#  define SP_LT_AUX_WRITE_ERROR		0x01
-#  define SP_LT_MAX_DRIVE_REACHED	0x02
-#  define SP_LT_WRONG_LANE_COUNT_SET	0x03
-#  define SP_LT_LOOP_SAME_5_TIME	0x04
-#  define SP_LT_CR_FAIL_IN_EQ		0x05
-#  define SP_LT_EQ_LOOP_5_TIME		0x06
-#define SP_LT_EN			BIT(0)
-
-/* DP CEP Training Control Registers */
-#define SP_DP_CEP_TRAINING_CTRL0_REG	0xa9
-#define SP_DP_CEP_TRAINING_CTRL1_REG	0xaa
-
-/* DP Debug Register 1 */
-#define SP_DP_DEBUG1_REG		0xb0
-#define SP_DEBUG_PLL_LOCK		BIT(4)
-#define SP_POLLING_EN			BIT(1)
-
-/* DP Polling Control Register */
-#define SP_DP_POLLING_CTRL_REG		0xb4
-#define SP_AUTO_POLLING_DISABLE		BIT(0)
-
-/* DP Link Debug Control Register */
-#define SP_DP_LINK_DEBUG_CTRL_REG	0xb8
-#define SP_M_VID_DEBUG			BIT(5)
-#define SP_NEW_PRBS7			BIT(4)
-#define SP_INSERT_ER			BIT(1)
-#define SP_PRBS31_EN			BIT(0)
-
-/* AUX Misc control Register */
-#define SP_AUX_MISC_CTRL_REG		0xbf
-
-/* DP PLL control Register */
-#define SP_DP_PLL_CTRL_REG		0xc7
-#define SP_PLL_RST			BIT(6)
-
-/* DP Analog Power Down Register */
-#define SP_DP_ANALOG_POWER_DOWN_REG	0xc8
-#define SP_CH0_PD			BIT(0)
-
-/* DP Misc Control Register */
-#define SP_DP_MISC_CTRL_REG		0xcd
-#define SP_EQ_TRAINING_LOOP		BIT(6)
-
-/* DP Extra I2C Device Address Register */
-#define SP_DP_EXTRA_I2C_DEV_ADDR_REG	0xce
-#define SP_I2C_STRETCH_DISABLE		BIT(7)
-
-#define SP_I2C_EXTRA_ADDR		0x50
-
-/* DP Downspread Control Register 1 */
-#define SP_DP_DOWNSPREAD_CTRL1_REG	0xd0
-
-/* DP M Value Calculation Control Register */
-#define SP_DP_M_CALCULATION_CTRL_REG	0xd9
-#define SP_M_GEN_CLK_SEL		BIT(0)
-
-/* AUX Channel Access Status Register */
-#define SP_AUX_CH_STATUS_REG		0xe0
-#define SP_AUX_STATUS			0x0f
-
-/* AUX Channel DEFER Control Register */
-#define SP_AUX_DEFER_CTRL_REG		0xe2
-#define SP_DEFER_CTRL_EN		BIT(7)
-
-/* DP Buffer Data Count Register */
-#define SP_BUF_DATA_COUNT_REG		0xe4
-#define SP_BUF_DATA_COUNT_MASK		0x1f
-#define SP_BUF_CLR			BIT(7)
-
-/* DP AUX Channel Control Register 1 */
-#define SP_DP_AUX_CH_CTRL1_REG		0xe5
-#define SP_AUX_TX_COMM_MASK		0x0f
-#define SP_AUX_LENGTH_MASK		0xf0
-#define SP_AUX_LENGTH_SHIFT		4
-
-/* DP AUX CH Address Register 0 */
-#define SP_AUX_ADDR_7_0_REG		0xe6
-
-/* DP AUX CH Address Register 1 */
-#define SP_AUX_ADDR_15_8_REG		0xe7
-
-/* DP AUX CH Address Register 2 */
-#define SP_AUX_ADDR_19_16_REG		0xe8
-#define SP_AUX_ADDR_19_16_MASK		0x0f
-
-/* DP AUX Channel Control Register 2 */
-#define SP_DP_AUX_CH_CTRL2_REG		0xe9
-#define SP_AUX_SEL_RXCM			BIT(6)
-#define SP_AUX_CHSEL			BIT(3)
-#define SP_AUX_PN_INV			BIT(2)
-#define SP_ADDR_ONLY			BIT(1)
-#define SP_AUX_EN			BIT(0)
-
-/* DP Video Stream Control InfoFrame Register */
-#define SP_DP_3D_VSC_CTRL_REG		0xea
-#define SP_INFO_FRAME_VSC_EN		BIT(0)
-
-/* DP Video Stream Data Byte 1 Register */
-#define SP_DP_VSC_DB1_REG		0xeb
-
-/* DP AUX Channel Control Register 3 */
-#define SP_DP_AUX_CH_CTRL3_REG		0xec
-#define SP_WAIT_COUNTER_7_0_MASK	0xff
-
-/* DP AUX Channel Control Register 4 */
-#define SP_DP_AUX_CH_CTRL4_REG		0xed
-
-/* DP AUX Buffer Data Registers */
-#define SP_DP_BUF_DATA0_REG		0xf0
-
-/***************************************************************/
-/* Register definition of device address 0x72                  */
-/***************************************************************/
-
-/*
- * Core Register Definitions
- */
-
-/* Device ID Low Byte Register */
-#define SP_DEVICE_IDL_REG		0x02
-
-/* Device ID High Byte Register */
-#define SP_DEVICE_IDH_REG		0x03
-
-/* Device version register */
-#define SP_DEVICE_VERSION_REG		0x04
-
-/* Power Down Control Register */
-#define SP_POWERDOWN_CTRL_REG		0x05
-#define SP_REGISTER_PD			BIT(7)
-#define SP_HDCP_PD			BIT(5)
-#define SP_AUDIO_PD			BIT(4)
-#define SP_VIDEO_PD			BIT(3)
-#define SP_LINK_PD			BIT(2)
-#define SP_TOTAL_PD			BIT(1)
-
-/* Reset Control Register 1 */
-#define SP_RESET_CTRL1_REG		0x06
-#define SP_MISC_RST			BIT(7)
-#define SP_VIDCAP_RST			BIT(6)
-#define SP_VIDFIF_RST			BIT(5)
-#define SP_AUDFIF_RST			BIT(4)
-#define SP_AUDCAP_RST			BIT(3)
-#define SP_HDCP_RST			BIT(2)
-#define SP_SW_RST			BIT(1)
-#define SP_HW_RST			BIT(0)
-
-/* Reset Control Register 2 */
-#define SP_RESET_CTRL2_REG		0x07
-#define SP_AUX_RST			BIT(2)
-#define SP_SERDES_FIFO_RST		BIT(1)
-#define SP_I2C_REG_RST			BIT(0)
-
-/* Video Control Register 1 */
-#define SP_VID_CTRL1_REG		0x08
-#define SP_VIDEO_EN			BIT(7)
-#define SP_VIDEO_MUTE			BIT(2)
-#define SP_DE_GEN			BIT(1)
-#define SP_DEMUX			BIT(0)
-
-/* Video Control Register 2 */
-#define SP_VID_CTRL2_REG		0x09
-#define SP_IN_COLOR_F_MASK		0x03
-#define SP_IN_YC_BIT_SEL		BIT(2)
-#define SP_IN_BPC_MASK			0x70
-#define SP_IN_BPC_SHIFT			4
-#  define SP_IN_BPC_12BIT		0x03
-#  define SP_IN_BPC_10BIT		0x02
-#  define SP_IN_BPC_8BIT		0x01
-#  define SP_IN_BPC_6BIT		0x00
-#define SP_IN_D_RANGE			BIT(7)
-
-/* Video Control Register 3 */
-#define SP_VID_CTRL3_REG		0x0a
-#define SP_HPD_OUT			BIT(6)
-
-/* Video Control Register 5 */
-#define SP_VID_CTRL5_REG		0x0c
-#define SP_CSC_STD_SEL			BIT(7)
-#define SP_XVYCC_RNG_LMT		BIT(6)
-#define SP_RANGE_Y2R			BIT(5)
-#define SP_CSPACE_Y2R			BIT(4)
-#define SP_RGB_RNG_LMT			BIT(3)
-#define SP_Y_RNG_LMT			BIT(2)
-#define SP_RANGE_R2Y			BIT(1)
-#define SP_CSPACE_R2Y			BIT(0)
-
-/* Video Control Register 6 */
-#define SP_VID_CTRL6_REG		0x0d
-#define SP_TEST_PATTERN_EN		BIT(7)
-#define SP_VIDEO_PROCESS_EN		BIT(6)
-#define SP_VID_US_MODE			BIT(3)
-#define SP_VID_DS_MODE			BIT(2)
-#define SP_UP_SAMPLE			BIT(1)
-#define SP_DOWN_SAMPLE			BIT(0)
-
-/* Video Control Register 8 */
-#define SP_VID_CTRL8_REG		0x0f
-#define SP_VID_VRES_TH			BIT(0)
-
-/* Total Line Status Low Byte Register */
-#define SP_TOTAL_LINE_STAL_REG		0x24
-
-/* Total Line Status High Byte Register */
-#define SP_TOTAL_LINE_STAH_REG		0x25
-
-/* Active Line Status Low Byte Register */
-#define SP_ACT_LINE_STAL_REG		0x26
-
-/* Active Line Status High Byte Register */
-#define SP_ACT_LINE_STAH_REG		0x27
-
-/* Vertical Front Porch Status Register */
-#define SP_V_F_PORCH_STA_REG		0x28
-
-/* Vertical SYNC Width Status Register */
-#define SP_V_SYNC_STA_REG		0x29
-
-/* Vertical Back Porch Status Register */
-#define SP_V_B_PORCH_STA_REG		0x2a
-
-/* Total Pixel Status Low Byte Register */
-#define SP_TOTAL_PIXEL_STAL_REG		0x2b
-
-/* Total Pixel Status High Byte Register */
-#define SP_TOTAL_PIXEL_STAH_REG		0x2c
-
-/* Active Pixel Status Low Byte Register */
-#define SP_ACT_PIXEL_STAL_REG		0x2d
-
-/* Active Pixel Status High Byte Register */
-#define SP_ACT_PIXEL_STAH_REG		0x2e
-
-/* Horizontal Front Porch Status Low Byte Register */
-#define SP_H_F_PORCH_STAL_REG		0x2f
-
-/* Horizontal Front Porch Statys High Byte Register */
-#define SP_H_F_PORCH_STAH_REG		0x30
-
-/* Horizontal SYNC Width Status Low Byte Register */
-#define SP_H_SYNC_STAL_REG		0x31
-
-/* Horizontal SYNC Width Status High Byte Register */
-#define SP_H_SYNC_STAH_REG		0x32
-
-/* Horizontal Back Porch Status Low Byte Register */
-#define SP_H_B_PORCH_STAL_REG		0x33
-
-/* Horizontal Back Porch Status High Byte Register */
-#define SP_H_B_PORCH_STAH_REG		0x34
-
-/* InfoFrame AVI Packet DB1 Register */
-#define SP_INFOFRAME_AVI_DB1_REG	0x70
-
-/* Bit Control Specific Register */
-#define SP_BIT_CTRL_SPECIFIC_REG	0x80
-#define SP_BIT_CTRL_SELECT_SHIFT	1
-#define SP_ENABLE_BIT_CTRL		BIT(0)
-
-/* InfoFrame Audio Packet DB1 Register */
-#define SP_INFOFRAME_AUD_DB1_REG	0x83
-
-/* InfoFrame MPEG Packet DB1 Register */
-#define SP_INFOFRAME_MPEG_DB1_REG	0xb0
-
-/* Audio Channel Status Registers */
-#define SP_AUD_CH_STATUS_BASE		0xd0
-
-/* Audio Channel Num Register 5 */
-#define SP_I2S_CHANNEL_NUM_MASK		0xe0
-#  define SP_I2S_CH_NUM_1		(0x00 << 5)
-#  define SP_I2S_CH_NUM_2		(0x01 << 5)
-#  define SP_I2S_CH_NUM_3		(0x02 << 5)
-#  define SP_I2S_CH_NUM_4		(0x03 << 5)
-#  define SP_I2S_CH_NUM_5		(0x04 << 5)
-#  define SP_I2S_CH_NUM_6		(0x05 << 5)
-#  define SP_I2S_CH_NUM_7		(0x06 << 5)
-#  define SP_I2S_CH_NUM_8		(0x07 << 5)
-#define SP_EXT_VUCP			BIT(2)
-#define SP_VBIT				BIT(1)
-#define SP_AUDIO_LAYOUT			BIT(0)
-
-/* Analog Debug Register 2 */
-#define SP_ANALOG_DEBUG2_REG		0xdd
-#define SP_FORCE_SW_OFF_BYPASS		0x20
-#define SP_XTAL_FRQ			0x1c
-#  define SP_XTAL_FRQ_19M2		(0x00 << 2)
-#  define SP_XTAL_FRQ_24M		(0x01 << 2)
-#  define SP_XTAL_FRQ_25M		(0x02 << 2)
-#  define SP_XTAL_FRQ_26M		(0x03 << 2)
-#  define SP_XTAL_FRQ_27M		(0x04 << 2)
-#  define SP_XTAL_FRQ_38M4		(0x05 << 2)
-#  define SP_XTAL_FRQ_52M		(0x06 << 2)
-#define SP_POWERON_TIME_1P5MS		0x03
-
-/* Analog Control 0 Register */
-#define SP_ANALOG_CTRL0_REG		0xe1
-
-/* Common Interrupt Status Register 1 */
-#define SP_COMMON_INT_STATUS_BASE	(0xf1 - 1)
-#define SP_PLL_LOCK_CHG			0x40
-
-/* Common Interrupt Status Register 2 */
-#define SP_COMMON_INT_STATUS2		0xf2
-#define SP_HDCP_AUTH_CHG		BIT(1)
-#define SP_HDCP_AUTH_DONE		BIT(0)
-
-#define SP_HDCP_LINK_CHECK_FAIL		BIT(0)
-
-/* Common Interrupt Status Register 4 */
-#define SP_COMMON_INT_STATUS4_REG	0xf4
-#define SP_HPD_IRQ			BIT(6)
-#define SP_HPD_ESYNC_ERR		BIT(4)
-#define SP_HPD_CHG			BIT(2)
-#define SP_HPD_LOST			BIT(1)
-#define SP_HPD_PLUG			BIT(0)
-
-/* DP Interrupt Status Register */
-#define SP_DP_INT_STATUS1_REG		0xf7
-#define SP_TRAINING_FINISH		BIT(5)
-#define SP_POLLING_ERR			BIT(4)
-
-/* Common Interrupt Mask Register */
-#define SP_COMMON_INT_MASK_BASE		(0xf8 - 1)
-
-#define SP_COMMON_INT_MASK4_REG		0xfb
-
-/* DP Interrupts Mask Register */
-#define SP_DP_INT_MASK1_REG		0xfe
-
-/* Interrupt Control Register */
-#define SP_INT_CTRL_REG			0xff
-
 /***************************************************************/
 /* Register definition of device address 0x7a                  */
 /***************************************************************/
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
new file mode 100644
index 000000000000..bc0831b127bf
--- /dev/null
+++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2017 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on analogix-anx78xx.h, which is:
+ *   Copyright(c) 2016, Analogix Semiconductor. All rights reserved.
+ */
+
+#ifndef _ANALOGIX_I2C_DPTX_H_
+#define _ANALOGIX_I2C_DPTX_H_
+
+#define ANALOGIX_I2C_DPTX		0x70
+
+/***************************************************************/
+/* Register definition of device address 0x70                  */
+/***************************************************************/
+
+/* HDCP Status Register */
+#define SP_TX_HDCP_STATUS_REG		0x00
+#define SP_AUTH_FAIL			BIT(5)
+#define SP_AUTHEN_PASS			BIT(1)
+
+/* HDCP Control Register 0 */
+#define SP_HDCP_CTRL0_REG		0x01
+#define SP_RX_REPEATER			BIT(6)
+#define SP_RE_AUTH			BIT(5)
+#define SP_SW_AUTH_OK			BIT(4)
+#define SP_HARD_AUTH_EN			BIT(3)
+#define SP_HDCP_ENC_EN			BIT(2)
+#define SP_BKSV_SRM_PASS		BIT(1)
+#define SP_KSVLIST_VLD			BIT(0)
+/* HDCP Function Enabled */
+#define SP_HDCP_FUNCTION_ENABLED	(BIT(0) | BIT(1) | BIT(2) | BIT(3))
+
+/* HDCP Receiver BSTATUS Register 0 */
+#define	SP_HDCP_RX_BSTATUS0_REG		0x1b
+/* HDCP Receiver BSTATUS Register 1 */
+#define	SP_HDCP_RX_BSTATUS1_REG		0x1c
+
+/* HDCP Embedded "Blue Screen" Content Registers */
+#define SP_HDCP_VID0_BLUE_SCREEN_REG	0x2c
+#define SP_HDCP_VID1_BLUE_SCREEN_REG	0x2d
+#define SP_HDCP_VID2_BLUE_SCREEN_REG	0x2e
+
+/* HDCP Wait R0 Timing Register */
+#define SP_HDCP_WAIT_R0_TIME_REG	0x40
+
+/* HDCP Link Integrity Check Timer Register */
+#define SP_HDCP_LINK_CHECK_TIMER_REG	0x41
+
+/* HDCP Repeater Ready Wait Timer Register */
+#define SP_HDCP_RPTR_RDY_WAIT_TIME_REG	0x42
+
+/* HDCP Auto Timer Register */
+#define SP_HDCP_AUTO_TIMER_REG		0x51
+
+/* HDCP Key Status Register */
+#define SP_HDCP_KEY_STATUS_REG		0x5e
+
+/* HDCP Key Command Register */
+#define SP_HDCP_KEY_COMMAND_REG		0x5f
+#define SP_DISABLE_SYNC_HDCP		BIT(2)
+
+/* OTP Memory Key Protection Registers */
+#define SP_OTP_KEY_PROTECT1_REG		0x60
+#define SP_OTP_KEY_PROTECT2_REG		0x61
+#define SP_OTP_KEY_PROTECT3_REG		0x62
+#define SP_OTP_PSW1			0xa2
+#define SP_OTP_PSW2			0x7e
+#define SP_OTP_PSW3			0xc6
+
+/* DP System Control Registers */
+#define SP_DP_SYSTEM_CTRL_BASE		(0x80 - 1)
+/* Bits for DP System Control Register 2 */
+#define SP_CHA_STA			BIT(2)
+/* Bits for DP System Control Register 3 */
+#define SP_HPD_STATUS			BIT(6)
+#define SP_STRM_VALID			BIT(2)
+/* Bits for DP System Control Register 4 */
+#define SP_ENHANCED_MODE		BIT(3)
+
+/* DP Video Control Register */
+#define SP_DP_VIDEO_CTRL_REG		0x84
+#define SP_COLOR_F_MASK			0x06
+#define SP_COLOR_F_SHIFT		1
+#define SP_BPC_MASK			0xe0
+#define SP_BPC_SHIFT			5
+#  define SP_BPC_6BITS			0x00
+#  define SP_BPC_8BITS			0x01
+#  define SP_BPC_10BITS			0x02
+#  define SP_BPC_12BITS			0x03
+
+/* DP Audio Control Register */
+#define SP_DP_AUDIO_CTRL_REG		0x87
+#define SP_AUD_EN			BIT(0)
+
+/* 10us Pulse Generate Timer Registers */
+#define SP_I2C_GEN_10US_TIMER0_REG	0x88
+#define SP_I2C_GEN_10US_TIMER1_REG	0x89
+
+/* Packet Send Control Register */
+#define SP_PACKET_SEND_CTRL_REG		0x90
+#define SP_AUD_IF_UP			BIT(7)
+#define SP_AVI_IF_UD			BIT(6)
+#define SP_MPEG_IF_UD			BIT(5)
+#define SP_SPD_IF_UD			BIT(4)
+#define SP_AUD_IF_EN			BIT(3)
+#define SP_AVI_IF_EN			BIT(2)
+#define SP_MPEG_IF_EN			BIT(1)
+#define SP_SPD_IF_EN			BIT(0)
+
+/* DP HDCP Control Register */
+#define SP_DP_HDCP_CTRL_REG		0x92
+#define SP_AUTO_EN			BIT(7)
+#define SP_AUTO_START			BIT(5)
+#define SP_LINK_POLLING			BIT(1)
+
+/* DP Main Link Bandwidth Setting Register */
+#define SP_DP_MAIN_LINK_BW_SET_REG	0xa0
+#define SP_LINK_BW_SET_MASK		0x1f
+#define SP_INITIAL_SLIM_M_AUD_SEL	BIT(5)
+
+/* DP Training Pattern Set Register */
+#define SP_DP_TRAINING_PATTERN_SET_REG	0xa2
+
+/* DP Lane 0 Link Training Control Register */
+#define SP_DP_LANE0_LT_CTRL_REG		0xa3
+#define SP_TX_SW_SET_MASK		0x1b
+#define SP_MAX_PRE_REACH		BIT(5)
+#define SP_MAX_DRIVE_REACH		BIT(4)
+#define SP_PRE_EMP_LEVEL1		BIT(3)
+#define SP_DRVIE_CURRENT_LEVEL1		BIT(0)
+
+/* DP Link Training Control Register */
+#define SP_DP_LT_CTRL_REG		0xa8
+#define SP_LT_ERROR_TYPE_MASK		0x70
+#  define SP_LT_NO_ERROR		0x00
+#  define SP_LT_AUX_WRITE_ERROR		0x01
+#  define SP_LT_MAX_DRIVE_REACHED	0x02
+#  define SP_LT_WRONG_LANE_COUNT_SET	0x03
+#  define SP_LT_LOOP_SAME_5_TIME	0x04
+#  define SP_LT_CR_FAIL_IN_EQ		0x05
+#  define SP_LT_EQ_LOOP_5_TIME		0x06
+#define SP_LT_EN			BIT(0)
+
+/* DP CEP Training Control Registers */
+#define SP_DP_CEP_TRAINING_CTRL0_REG	0xa9
+#define SP_DP_CEP_TRAINING_CTRL1_REG	0xaa
+
+/* DP Debug Register 1 */
+#define SP_DP_DEBUG1_REG		0xb0
+#define SP_DEBUG_PLL_LOCK		BIT(4)
+#define SP_POLLING_EN			BIT(1)
+
+/* DP Polling Control Register */
+#define SP_DP_POLLING_CTRL_REG		0xb4
+#define SP_AUTO_POLLING_DISABLE		BIT(0)
+
+/* DP Link Debug Control Register */
+#define SP_DP_LINK_DEBUG_CTRL_REG	0xb8
+#define SP_M_VID_DEBUG			BIT(5)
+#define SP_NEW_PRBS7			BIT(4)
+#define SP_INSERT_ER			BIT(1)
+#define SP_PRBS31_EN			BIT(0)
+
+/* AUX Misc control Register */
+#define SP_AUX_MISC_CTRL_REG		0xbf
+
+/* DP PLL control Register */
+#define SP_DP_PLL_CTRL_REG		0xc7
+#define SP_PLL_RST			BIT(6)
+
+/* DP Analog Power Down Register */
+#define SP_DP_ANALOG_POWER_DOWN_REG	0xc8
+#define SP_CH0_PD			BIT(0)
+
+/* DP Misc Control Register */
+#define SP_DP_MISC_CTRL_REG		0xcd
+#define SP_EQ_TRAINING_LOOP		BIT(6)
+
+/* DP Extra I2C Device Address Register */
+#define SP_DP_EXTRA_I2C_DEV_ADDR_REG	0xce
+#define SP_I2C_STRETCH_DISABLE		BIT(7)
+
+#define SP_I2C_EXTRA_ADDR		0x50
+
+/* DP Downspread Control Register 1 */
+#define SP_DP_DOWNSPREAD_CTRL1_REG	0xd0
+
+/* DP M Value Calculation Control Register */
+#define SP_DP_M_CALCULATION_CTRL_REG	0xd9
+#define SP_M_GEN_CLK_SEL		BIT(0)
+
+/* AUX Channel Access Status Register */
+#define SP_AUX_CH_STATUS_REG		0xe0
+#define SP_AUX_STATUS			0x0f
+
+/* AUX Channel DEFER Control Register */
+#define SP_AUX_DEFER_CTRL_REG		0xe2
+#define SP_DEFER_CTRL_EN		BIT(7)
+
+/* DP Buffer Data Count Register */
+#define SP_BUF_DATA_COUNT_REG		0xe4
+#define SP_BUF_DATA_COUNT_MASK		0x1f
+#define SP_BUF_CLR			BIT(7)
+
+/* DP AUX Channel Control Register 1 */
+#define SP_DP_AUX_CH_CTRL1_REG		0xe5
+#define SP_AUX_TX_COMM_MASK		0x0f
+#define SP_AUX_LENGTH_MASK		0xf0
+#define SP_AUX_LENGTH_SHIFT		4
+
+/* DP AUX CH Address Register 0 */
+#define SP_AUX_ADDR_7_0_REG		0xe6
+
+/* DP AUX CH Address Register 1 */
+#define SP_AUX_ADDR_15_8_REG		0xe7
+
+/* DP AUX CH Address Register 2 */
+#define SP_AUX_ADDR_19_16_REG		0xe8
+#define SP_AUX_ADDR_19_16_MASK		0x0f
+
+/* DP AUX Channel Control Register 2 */
+#define SP_DP_AUX_CH_CTRL2_REG		0xe9
+#define SP_AUX_SEL_RXCM			BIT(6)
+#define SP_AUX_CHSEL			BIT(3)
+#define SP_AUX_PN_INV			BIT(2)
+#define SP_ADDR_ONLY			BIT(1)
+#define SP_AUX_EN			BIT(0)
+
+/* DP Video Stream Control InfoFrame Register */
+#define SP_DP_3D_VSC_CTRL_REG		0xea
+#define SP_INFO_FRAME_VSC_EN		BIT(0)
+
+/* DP Video Stream Data Byte 1 Register */
+#define SP_DP_VSC_DB1_REG		0xeb
+
+/* DP AUX Channel Control Register 3 */
+#define SP_DP_AUX_CH_CTRL3_REG		0xec
+#define SP_WAIT_COUNTER_7_0_MASK	0xff
+
+/* DP AUX Channel Control Register 4 */
+#define SP_DP_AUX_CH_CTRL4_REG		0xed
+
+/* DP AUX Buffer Data Registers */
+#define SP_DP_BUF_DATA0_REG		0xf0
+
+#endif
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
new file mode 100644
index 000000000000..7d683573e970
--- /dev/null
+++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2017 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on analogix-anx78xx.h, which is:
+ *   Copyright(c) 2016, Analogix Semiconductor. All rights reserved.
+ */
+
+#ifndef _ANALOGIX_I2C_TXCOMMON_H_
+#define _ANALOGIX_I2C_TXCOMMON_H_
+
+#define ANALOGIX_I2C_TXCOMMON		0x72
+
+/***************************************************************/
+/* Register definition of device address 0x72                  */
+/***************************************************************/
+
+/*
+ * Core Register Definitions
+ */
+
+/* Device ID Low Byte Register */
+#define SP_DEVICE_IDL_REG		0x02
+
+/* Device ID High Byte Register */
+#define SP_DEVICE_IDH_REG		0x03
+
+/* Device version register */
+#define SP_DEVICE_VERSION_REG		0x04
+
+/* Power Down Control Register */
+#define SP_POWERDOWN_CTRL_REG		0x05
+#define SP_REGISTER_PD			BIT(7)
+#define SP_HDCP_PD			BIT(5)
+#define SP_AUDIO_PD			BIT(4)
+#define SP_VIDEO_PD			BIT(3)
+#define SP_LINK_PD			BIT(2)
+#define SP_TOTAL_PD			BIT(1)
+
+/* Reset Control Register 1 */
+#define SP_RESET_CTRL1_REG		0x06
+#define SP_MISC_RST			BIT(7)
+#define SP_VIDCAP_RST			BIT(6)
+#define SP_VIDFIF_RST			BIT(5)
+#define SP_AUDFIF_RST			BIT(4)
+#define SP_AUDCAP_RST			BIT(3)
+#define SP_HDCP_RST			BIT(2)
+#define SP_SW_RST			BIT(1)
+#define SP_HW_RST			BIT(0)
+
+/* Reset Control Register 2 */
+#define SP_RESET_CTRL2_REG		0x07
+#define SP_AUX_RST			BIT(2)
+#define SP_SERDES_FIFO_RST		BIT(1)
+#define SP_I2C_REG_RST			BIT(0)
+
+/* Video Control Register 1 */
+#define SP_VID_CTRL1_REG		0x08
+#define SP_VIDEO_EN			BIT(7)
+#define SP_VIDEO_MUTE			BIT(2)
+#define SP_DE_GEN			BIT(1)
+#define SP_DEMUX			BIT(0)
+
+/* Video Control Register 2 */
+#define SP_VID_CTRL2_REG		0x09
+#define SP_IN_COLOR_F_MASK		0x03
+#define SP_IN_YC_BIT_SEL		BIT(2)
+#define SP_IN_BPC_MASK			0x70
+#define SP_IN_BPC_SHIFT			4
+#  define SP_IN_BPC_12BIT		0x03
+#  define SP_IN_BPC_10BIT		0x02
+#  define SP_IN_BPC_8BIT		0x01
+#  define SP_IN_BPC_6BIT		0x00
+#define SP_IN_D_RANGE			BIT(7)
+
+/* Video Control Register 3 */
+#define SP_VID_CTRL3_REG		0x0a
+#define SP_HPD_OUT			BIT(6)
+
+/* Video Control Register 5 */
+#define SP_VID_CTRL5_REG		0x0c
+#define SP_CSC_STD_SEL			BIT(7)
+#define SP_XVYCC_RNG_LMT		BIT(6)
+#define SP_RANGE_Y2R			BIT(5)
+#define SP_CSPACE_Y2R			BIT(4)
+#define SP_RGB_RNG_LMT			BIT(3)
+#define SP_Y_RNG_LMT			BIT(2)
+#define SP_RANGE_R2Y			BIT(1)
+#define SP_CSPACE_R2Y			BIT(0)
+
+/* Video Control Register 6 */
+#define SP_VID_CTRL6_REG		0x0d
+#define SP_TEST_PATTERN_EN		BIT(7)
+#define SP_VIDEO_PROCESS_EN		BIT(6)
+#define SP_VID_US_MODE			BIT(3)
+#define SP_VID_DS_MODE			BIT(2)
+#define SP_UP_SAMPLE			BIT(1)
+#define SP_DOWN_SAMPLE			BIT(0)
+
+/* Video Control Register 8 */
+#define SP_VID_CTRL8_REG		0x0f
+#define SP_VID_VRES_TH			BIT(0)
+
+/* Total Line Status Low Byte Register */
+#define SP_TOTAL_LINE_STAL_REG		0x24
+
+/* Total Line Status High Byte Register */
+#define SP_TOTAL_LINE_STAH_REG		0x25
+
+/* Active Line Status Low Byte Register */
+#define SP_ACT_LINE_STAL_REG		0x26
+
+/* Active Line Status High Byte Register */
+#define SP_ACT_LINE_STAH_REG		0x27
+
+/* Vertical Front Porch Status Register */
+#define SP_V_F_PORCH_STA_REG		0x28
+
+/* Vertical SYNC Width Status Register */
+#define SP_V_SYNC_STA_REG		0x29
+
+/* Vertical Back Porch Status Register */
+#define SP_V_B_PORCH_STA_REG		0x2a
+
+/* Total Pixel Status Low Byte Register */
+#define SP_TOTAL_PIXEL_STAL_REG		0x2b
+
+/* Total Pixel Status High Byte Register */
+#define SP_TOTAL_PIXEL_STAH_REG		0x2c
+
+/* Active Pixel Status Low Byte Register */
+#define SP_ACT_PIXEL_STAL_REG		0x2d
+
+/* Active Pixel Status High Byte Register */
+#define SP_ACT_PIXEL_STAH_REG		0x2e
+
+/* Horizontal Front Porch Status Low Byte Register */
+#define SP_H_F_PORCH_STAL_REG		0x2f
+
+/* Horizontal Front Porch Statys High Byte Register */
+#define SP_H_F_PORCH_STAH_REG		0x30
+
+/* Horizontal SYNC Width Status Low Byte Register */
+#define SP_H_SYNC_STAL_REG		0x31
+
+/* Horizontal SYNC Width Status High Byte Register */
+#define SP_H_SYNC_STAH_REG		0x32
+
+/* Horizontal Back Porch Status Low Byte Register */
+#define SP_H_B_PORCH_STAL_REG		0x33
+
+/* Horizontal Back Porch Status High Byte Register */
+#define SP_H_B_PORCH_STAH_REG		0x34
+
+/* InfoFrame AVI Packet DB1 Register */
+#define SP_INFOFRAME_AVI_DB1_REG	0x70
+
+/* Bit Control Specific Register */
+#define SP_BIT_CTRL_SPECIFIC_REG	0x80
+#define SP_BIT_CTRL_SELECT_SHIFT	1
+#define SP_ENABLE_BIT_CTRL		BIT(0)
+
+/* InfoFrame Audio Packet DB1 Register */
+#define SP_INFOFRAME_AUD_DB1_REG	0x83
+
+/* InfoFrame MPEG Packet DB1 Register */
+#define SP_INFOFRAME_MPEG_DB1_REG	0xb0
+
+/* Audio Channel Status Registers */
+#define SP_AUD_CH_STATUS_BASE		0xd0
+
+/* Audio Channel Num Register 5 */
+#define SP_I2S_CHANNEL_NUM_MASK		0xe0
+#  define SP_I2S_CH_NUM_1		(0x00 << 5)
+#  define SP_I2S_CH_NUM_2		(0x01 << 5)
+#  define SP_I2S_CH_NUM_3		(0x02 << 5)
+#  define SP_I2S_CH_NUM_4		(0x03 << 5)
+#  define SP_I2S_CH_NUM_5		(0x04 << 5)
+#  define SP_I2S_CH_NUM_6		(0x05 << 5)
+#  define SP_I2S_CH_NUM_7		(0x06 << 5)
+#  define SP_I2S_CH_NUM_8		(0x07 << 5)
+#define SP_EXT_VUCP			BIT(2)
+#define SP_VBIT				BIT(1)
+#define SP_AUDIO_LAYOUT			BIT(0)
+
+/* Analog Debug Register 2 */
+#define SP_ANALOG_DEBUG2_REG		0xdd
+#define SP_FORCE_SW_OFF_BYPASS		0x20
+#define SP_XTAL_FRQ			0x1c
+#  define SP_XTAL_FRQ_19M2		(0x00 << 2)
+#  define SP_XTAL_FRQ_24M		(0x01 << 2)
+#  define SP_XTAL_FRQ_25M		(0x02 << 2)
+#  define SP_XTAL_FRQ_26M		(0x03 << 2)
+#  define SP_XTAL_FRQ_27M		(0x04 << 2)
+#  define SP_XTAL_FRQ_38M4		(0x05 << 2)
+#  define SP_XTAL_FRQ_52M		(0x06 << 2)
+#define SP_POWERON_TIME_1P5MS		0x03
+
+/* Analog Control 0 Register */
+#define SP_ANALOG_CTRL0_REG		0xe1
+
+/* Common Interrupt Status Register 1 */
+#define SP_COMMON_INT_STATUS_BASE	(0xf1 - 1)
+#define SP_PLL_LOCK_CHG			0x40
+
+/* Common Interrupt Status Register 2 */
+#define SP_COMMON_INT_STATUS2		0xf2
+#define SP_HDCP_AUTH_CHG		BIT(1)
+#define SP_HDCP_AUTH_DONE		BIT(0)
+
+#define SP_HDCP_LINK_CHECK_FAIL		BIT(0)
+
+/* Common Interrupt Status Register 4 */
+#define SP_COMMON_INT_STATUS4_REG	0xf4
+#define SP_HPD_IRQ			BIT(6)
+#define SP_HPD_ESYNC_ERR		BIT(4)
+#define SP_HPD_CHG			BIT(2)
+#define SP_HPD_LOST			BIT(1)
+#define SP_HPD_PLUG			BIT(0)
+
+/* DP Interrupt Status Register */
+#define SP_DP_INT_STATUS1_REG		0xf7
+#define SP_TRAINING_FINISH		BIT(5)
+#define SP_POLLING_ERR			BIT(4)
+
+/* Common Interrupt Mask Register */
+#define SP_COMMON_INT_MASK_BASE		(0xf8 - 1)
+
+#define SP_COMMON_INT_MASK4_REG		0xfb
+
+/* DP Interrupts Mask Register */
+#define SP_DP_INT_MASK1_REG		0xfe
+
+/* Interrupt Control Register */
+#define SP_INT_CTRL_REG			0xff
+
+#endif /* _ANALOGIX_I2C_TXCOMMON_H_ */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
