Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB7AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:43:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AEA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EaR5gdur";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KteVn27U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AEA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c2+OF8u3T8CPgH1rs1e/gZwGBrqxzluizcK08qELFZQ=; b=EaR5gdurxCbChe
	2p1jbglHr8L2tM1jDwnB9m0PgQtVjIFfpIleT289v0FRByziVts7BTa00lEi4H3ii78hr7oB5E7hJ
	N0UYbFu3JicTyvRBvZ+h+6afzNFyIwkyInrSSBruh3CJ8REh8SiZkEtdACf3NQG7lh8HDsmzYYKxj
	6i1DscD8zKKH6VMJp1zHtg7h5MJ8nUo3wNR1FbaAt5rg07A1WbwH/wRKv21vAfC3/TBS8R34TxFPm
	RgGAOCeIR/9iqjIShvwwgA2l7eKh/a1C/fXSinbWaiCELgj4bDBvfvoHIUECWsG7LTlZcTuiVX2y3
	63ib7XWAHZRxHEmYHKuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT8MX-0006WT-1y; Sat, 01 Dec 2018 16:43:25 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT8MT-0006VH-0v
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 16:43:22 +0000
Received: by mail-wm1-x341.google.com with SMTP id n133so1800069wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 08:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LURxEpFoQpbE01pm5s8u2VhCwkBhrR1RCuFsS9V/51c=;
 b=KteVn27UKVdUq3KI12wGmiicOxGN8+eVErhRRf8F93QdgSkEVQ2M7knInh2Osgv//w
 ycVMqoULoLBLvVKe+5nhm5lIfUAdomZ6sSerIXevptE85GdAEikP+3YLUn421NP1vrx1
 Pf+rx27XiwsSBt7EMOonWBYD8sF1qAMY3WYOq4oGYRno3RX6GKk6IujvVlp8jv1cDBYw
 /lhW4cwbYfpoNSiyZeYZREURTiNNcDAmwQrDw4ZUKoFPm3xxCwq6iexv39RBecXUSp+v
 stEidJGI1Jch4ibKS2RulMuVQsR+5EazzqN9UWSqlsSy7HA72WATo6D5baXPU08eh/fR
 TYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LURxEpFoQpbE01pm5s8u2VhCwkBhrR1RCuFsS9V/51c=;
 b=N/VXVd84UPNKSy5omgYGTSEMxhd5sgL/yqghT9ULcCKeXAb80Fp+FF/+59cWTR+PJR
 Y2zD1CYh3wcvwBLnWlyR0TJBOP/tZtUZryVdMiB63VtjiXMj6qkDL2cW8WVnHjGJ1qzY
 8S6gvJzr8JVsc5H4e8dj0ICOqkTlXx7Jv+5w1yugFV8dBNCmFIQsqF6yO0Fz44BphrUx
 +oOHQjWU8jXTPWItz5FaUxEqyV5PvG+X5pBeGiIxR0RldnkqbPLFV37yjyLbIuc3Shl/
 vNLFs9cxL19Wa0VjtE53k9LLpaMfotHGyrjYrR3U6oKiK/VuciXngaoWqdiohzIazVg4
 3lXQ==
X-Gm-Message-State: AA+aEWbKUDtq+R+qe9P0w2KFG0tKjEcM9EiKhA/2Kn+IDKV0AteF2HLl
 ViZLJzKWGzNPiSfCg9zh7EHyCw==
X-Google-Smtp-Source: AFSGD/WFSLxdN5SsvJVkdG9hc9IBop/EabUDv1hDBA+tqbBTaKLr7BQnqRrnrteB9+p/FciDF06vpA==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr2602270wmc.43.1543682588394; 
 Sat, 01 Dec 2018 08:43:08 -0800 (PST)
Received: from localhost.localdomain ([104.207.76.73])
 by smtp.gmail.com with ESMTPSA id c13sm19832843wrb.38.2018.12.01.08.43.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 08:43:07 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, khilman@baylibre.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 jbrunet@baylibre.com
Subject: [PATCH v2] arm64: dts: meson-axg: Enable GPIO interrupt controller
Date: Sat,  1 Dec 2018 16:43:01 +0000
Message-Id: <20181201164301.17274-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_084321_126908_EBD68D0F 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable the GPIO interrupt controller for the AXG SoCs.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Tested on a custom board derived from S400.

@Jerome: I know you had problems with this. I tested this on the apollo
board with the PHY IRQ and it seems to work fine. You probably want to
N/ACK this.
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index df017dbd2e57..a7d8219f7373 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1414,12 +1414,12 @@
 			};
 
 			gpio_intc: interrupt-controller@f080 {
-				compatible = "amlogic,meson-gpio-intc";
+				compatible = "amlogic,meson-axg-gpio-intc",
+					     "amlogic,meson-gpio-intc";
 				reg = <0x0 0xf080 0x0 0x10>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
-				status = "disabled";
 			};
 
 			pwm_ab: pwm@1b000 {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
