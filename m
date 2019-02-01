Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBCCC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41D52082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GB1HQte0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCz5E6SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41D52082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=g4t0t6qK5UN66tTGO8qBPqZ9Ex60DZ+kEBaHLPBQfgk=; b=GB1HQte0JsRqzQyDIBp3Zwf7vW
	QBafyFLupOdXnYx3Q8BoOBh8UxKU26de1m6fFFxXI09eopx4eOA1idftAh1HFCl9kkSLE1ba2wc4+
	hWTtR4aHNlgCV+OF0hCwMRbihSailIYLAkFBE5yI5QP4m2+krDhGhTtmRpqO5nCF0BLvQj+0f5KC0
	ckTpeb5204Sd6AxFI8ABLTVoFl6nvUfiEM3etAi/TxnjCHNYqV6QqKLfpQWbbraqz90sC5TSLl1cd
	w4YCl+6kk+3Uq/OijvEW6VrhPk3U4DToyDIP0Ty4re/YL/Q7S0B2BLwoUF0/W8AnPnMJXxTau24kj
	x69DRslQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpY04-0000sT-Fo; Fri, 01 Feb 2019 12:32:52 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpY01-0000rH-3y; Fri, 01 Feb 2019 12:32:50 +0000
Received: by mail-ed1-x541.google.com with SMTP id b14so5301562edt.6;
 Fri, 01 Feb 2019 04:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mfx8EngpD21F4beHFI4xnlcyVYLWy3PUGs790NCYd/k=;
 b=gCz5E6SWpg5ROaHec2f+peOAT4i5hMwL2a/A5uflM6xGh5XlzG74/qBxJEzkbpK/bh
 yBunrUM9GPysUE2hXjiBFglv1LaP6zbudawQ6lPfl2ACnE5oTp1yS4t+Lc9oBbTDIYZq
 OoNgVCrXIPU1zz4jTurmieGnSdiYCdnAG5QniN2Ufa5RmGm/UJjkrrSy8K63vRLPmdV0
 hmd5US6Mcnrx6VEfORR8NUj71o4p5sW0VdhmwH0oQFS6hKoQtmOFNynqXd9fTohPpwkG
 x8T4KAu/vtLVMZAM0c1vkkOse/5DfjA79YxwO+StlzERDyXKZKrLFjJg/j0ispqNZqrQ
 Bkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mfx8EngpD21F4beHFI4xnlcyVYLWy3PUGs790NCYd/k=;
 b=Us1b+qjvxH1SfjPRVTlA6m48LKvdSYaf7Xrjy57ThiikmIn9QELaJB3mA7hdDMxT2B
 TUe9Ep8OnGJWJCZrLoKI9ZfGtOi5nTmUxnFEw3mAmTN7GZSJ0DW95rVeheCX+qyDunON
 6qMTvbvrk7oG0TVlkUXNdwNX45fLlfgu/hb34KYqYhr0E8+fVaRknGa+XZ5W40/zeakX
 wZh7hh4Qekwtq7ZijSKRgyLPj5NBSmOIOSrPXw4xwB7s++Hy9if8ZvemmMZ9IctIfrld
 oaW1R09HaGeqReAFdMMYxLLYvPky0NIlO8MCHTFlI6kEdbLXDaLcQoRJ3lgqYYe+M4v0
 TV+A==
X-Gm-Message-State: AJcUukfZ5eRc0vOafEC7f8X9f7SLjMKlT7fq78RnNp9H9PjV96duAcm0
 aXKoshKOQ5YqqdpiiD5tgCM=
X-Google-Smtp-Source: ALg8bN6bAk2/kdTEEUEmQ5FKhX+c/OHqI4ZSEhFW/F1mKvzw3hnQ5hctz3KmYnK9gdfAXyc7SyJocQ==
X-Received: by 2002:a17:906:914a:: with SMTP id
 y10mr35335385ejw.124.1549024366907; 
 Fri, 01 Feb 2019 04:32:46 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id v6sm1221472eja.51.2019.02.01.04.32.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 04:32:46 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH] dt-bindings: display: rockchip: add document for rk3066 hdmi
Date: Fri,  1 Feb 2019 13:32:35 +0100
Message-Id: <20190201123235.1693-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_043249_156438_76370574 
X-CRM114-Status: GOOD (  15.28  )
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

This patch adds a binding that describes the HDMI controller for
rk3066.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../display/rockchip/rk3066_hdmi-rockchip.txt      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
new file mode 100644
index 000000000..6a8f3754f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
@@ -0,0 +1,60 @@
+Rockchip specific extensions for rk3066 HDMI
+============================================
+
+Required properties:
+- compatible:
+	"rockchip,rk3066-hdmi";
+- reg:
+	Physical base address and length of the controller's registers.
+- clocks, clock-names:
+	Phandle to HDMI controller clock, name should be "hclk".
+- interrupts:
+	HDMI interrupt number.
+- power-domains:
+	Phandle to the RK3066_PD_VIO power domain.
+- rockchip,grf:
+	This soc uses GRF regs to switch the HDMI TX input between vop0 and vop1.
+- ports:
+	Contains one port node with two endpoints, numbered 0 and 1,
+	connected respectively to vop0 and vop1.
+- pinctrl-0, pinctrl-name:
+	Switch the iomux for the HPD/I2C pins to HDMI function.
+
+Example:
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
+		};
+	};
+
+&pinctrl {
+		hdmi {
+			hdmi_hpd: hdmi-hpd {
+				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
+			};
+			hdmii2c_xfer: hdmii2c-xfer {
+				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
+						<0 RK_PA2 1 &pcfg_pull_none>;
+			};
+		};
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
