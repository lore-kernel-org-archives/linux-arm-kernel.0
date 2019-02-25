Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CDC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:31:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F108C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OevOHpy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F108C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wBukxnVqdATek94kBciLCpx/X3K3vYu8Gk3GnhRfG/o=; b=OevOHpy9P7lv1/
	YYWKYy5NFZ8GMcMviTFd8LNmq9JMla8shNYaPvWpBUZPnJ6uFMlc6pZF0MrFKkcK4zxp5XpAVcPIx
	73U/YdXjGP5iHxim0SC+fvx0YwU17krdPJIcEs4Zf4YnAA/Bob60/soz6d092+TCRp9H7gH77bxPd
	ta65N0NrmMgf9mcIjlbUaA6QNH5cTpT8UTX9bSjxJ2W5sF/1iDSE6sUPubFSFIsh39qjZ10Vv11Ds
	2cFGferex/cuKKcp3iRmqksPFxPTfvhZwlq9jiGzyDkbgAQvMvmhZbOCni0dOCLVQ6gMDhS0xb3SO
	odkmC08qtsQbH5lnTENA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy6zG-0007cy-L8; Mon, 25 Feb 2019 03:31:26 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy6zC-0007an-KE
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 03:31:24 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 38F495FCE3; Mon, 25 Feb 2019 11:31:16 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 2/9] power: supply: axp20x_usb_power: Fix typo in VBUS
 current limit macros
Date: Mon, 25 Feb 2019 11:31:00 +0800
Message-Id: <20190225033107.17326-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225033107.17326-1-wens@csie.org>
References: <20190225033107.17326-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_193122_800820_FFAAA3C0 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>,
 linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The VBUS current limit value macros have VBUS typed as VBUC, while
the bitmask macro is named correctly. Fix it.

Fixes: 69fb4dcada77 ("power: Add an axp20x-usb-power driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index f52fe77edb6f..cd9b90d79839 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -36,10 +36,10 @@
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
 #define AXP20X_VBUS_CLIMIT_MASK		3
-#define AXP20X_VBUC_CLIMIT_900mA	0
-#define AXP20X_VBUC_CLIMIT_500mA	1
-#define AXP20X_VBUC_CLIMIT_100mA	2
-#define AXP20X_VBUC_CLIMIT_NONE		3
+#define AXP20X_VBUS_CLIMIT_900mA	0
+#define AXP20X_VBUS_CLIMIT_500mA	1
+#define AXP20X_VBUS_CLIMIT_100mA	2
+#define AXP20X_VBUS_CLIMIT_NONE		3
 
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
@@ -107,19 +107,19 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 			return ret;
 
 		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-		case AXP20X_VBUC_CLIMIT_100mA:
+		case AXP20X_VBUS_CLIMIT_100mA:
 			if (power->axp20x_id == AXP221_ID)
 				val->intval = -1; /* No 100mA limit */
 			else
 				val->intval = 100000;
 			break;
-		case AXP20X_VBUC_CLIMIT_500mA:
+		case AXP20X_VBUS_CLIMIT_500mA:
 			val->intval = 500000;
 			break;
-		case AXP20X_VBUC_CLIMIT_900mA:
+		case AXP20X_VBUS_CLIMIT_900mA:
 			val->intval = 900000;
 			break;
-		case AXP20X_VBUC_CLIMIT_NONE:
+		case AXP20X_VBUS_CLIMIT_NONE:
 			val->intval = -1;
 			break;
 		}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
