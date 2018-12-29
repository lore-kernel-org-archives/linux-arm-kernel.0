Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F878C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:35:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF4D20828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NH4MXMk+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lROcxNZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF4D20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TAY3Bityrv8HQbmMR+WL03UkaEA4/NqYzUPRj37geLk=; b=NH4MXMk+F/Z0iZ3R3h2EvEJ62I
	s9JJtcpFz1xChQy5mD1WPtNGT2zRwCXswtAJrxdsB7fwyOhpuzZY/El6Xf9Z1P7CO6Dz+hq3HX5iu
	zrxWO6vKRlHHxWT/Qx3s2pJZPx/lIjbWVYAa7ao64JVzHF2ZBdgEkGKTgKFDc59OplaRbL/rqtf44
	0SNBZS7sTeg4Tzmu3P9u2PVOy0KyHSWyQSs0ZYNe9EhjFzsnSz8w+rjkmrkR6Vzn1wKoL8sYIO82h
	AkB5EwbU7bcdz4DmiUHcvZEpNHEUGFN0ttG5+NUQLM6lBlF51LtKpNUHKYZIi0rlpwMyAOqRJZ29T
	bnnCc3wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdElZ-0006VY-A4; Sat, 29 Dec 2018 13:35:01 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEkL-0005PM-8z; Sat, 29 Dec 2018 13:33:48 +0000
Received: by mail-ed1-x542.google.com with SMTP id y20so19444577edw.9;
 Sat, 29 Dec 2018 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ohQaTv2J9kKKkZzf1BMm6V+1alRU++HuBiNVjD/Tdc8=;
 b=lROcxNZtyZz0YqrsCbaYhuDDYoGcZtzQ5YVmgJ28QLNus2d5lKpfUlKr8dLNUKa2RY
 rUoHV9cJfN3s5z5SmmwIrk+shjN6sLo+zzSh324y7Wrpk4oVvOsJchKWn0AkKHI0dDsr
 zOOXGRf+dkBmbRyW+Ba86F/muGL6bBGkEScm+f4tZnr4evTcqXZbxBOzXUdFkwGkaHgW
 yN9o2+WexfsDhYSXcLhOPDkoXaAOe2tBseE48zy4BF22S80/900W/CRLHrF7PxiQ8OBt
 FYRgplwlBv7VqI0v2Gj/mgFB2a1837qBzwQUUoEFebEevMJ41IoQu1zOup8JeiG7gAMw
 4kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ohQaTv2J9kKKkZzf1BMm6V+1alRU++HuBiNVjD/Tdc8=;
 b=T/CnkDk1IstaVQkDrWe7JdG5Y1Yfr9FonK0Jz11S5mWmImasLsQyg0rCSuZVsCP7xf
 UyTJJ2JDVnj7Gkz9dMRLvJAAER4vo4rnIZHKFeHUmFn07QieRvW3cWovYI5JTuud/n+V
 8J8cAv7yYN3OHKeM+B/+T9n5YxFNc7/jD4OuQf8LFmdcb8eutc68iXfwFr6I7GJtt+0c
 MNnMSPFyrzG57txWia4NyMhwX9K4e4sTR2Wah2jdYKF6/Y2b0VvSrJ/Oi+lDB8draU5U
 tESrOuhwBu0dvq5fPKWMtdJTzYlVRG50kvdLKmpGReSHG/Lrv4HoOE/GsdGPJTKodWAA
 Qbiw==
X-Gm-Message-State: AA+aEWZr6b+2RfNitDWKC7AXpt9wApjhw7ks09/9Uz2n9dOUNwxaOjpF
 DlZQZ6WAc9jEBQnGfq3CMGM=
X-Google-Smtp-Source: AFSGD/VC0k1w65VqW7kPDVorcVnCE7blvPxWxkewJShB70llCBkmlHlsRSZBCrWVFmLqO86ITgpgzA==
X-Received: by 2002:a50:b5c6:: with SMTP id a64mr26354856ede.112.1546090420207; 
 Sat, 29 Dec 2018 05:33:40 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 05:33:39 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v2 6/7] ARM: dts: rockchip: add rk3066 hdmi nodes
Date: Sat, 29 Dec 2018 14:33:17 +0100
Message-Id: <20181229133318.18128-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_053345_318620_36C9EB40 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Zheng Yang <zhengyang@rock-chips.com>

This patch adds the hdmi nodes to rk3066.

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 653127a37..f95ce9881 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -80,6 +80,10 @@
 		vop0_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop0_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop0>;
+			};
 		};
 	};
 
@@ -101,6 +105,36 @@
 		vop1_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop1_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop1>;
+			};
+		};
+	};
+
+	hdmi: hdmi@10116000 {
+		compatible = "rockchip,rk3066-hdmi";
+		reg = <0x10116000 0x2000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HDMI>;
+		clock-names = "hclk";
+		power-domains = <&power RK3066_PD_VIO>;
+		rockchip,grf = <&grf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
+		status = "disabled";
+
+		hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in_vop0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&vop0_out_hdmi>;
+			};
+			hdmi_in_vop1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&vop1_out_hdmi>;
+			};
 		};
 	};
 
@@ -415,6 +449,16 @@
 			};
 		};
 
+		hdmi {
+			hdmi_hpd: hdmi-hpd {
+				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
+			};
+			hdmii2c_xfer: hdmii2c-xfer {
+				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
+						<0 RK_PA2 1 &pcfg_pull_none>;
+			};
+		};
+
 		pwm0 {
 			pwm0_out: pwm0-out {
 				rockchip,pins = <RK_GPIO0 3 RK_FUNC_1 &pcfg_pull_none>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
