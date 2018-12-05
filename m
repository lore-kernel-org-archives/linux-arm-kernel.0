Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BEAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:52:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2024820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QenZ1yEa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d9o4snlR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GwQbiP4fpHjCtxoR8igR27iuN/mtPgHfeIf8zE0I9J4=; b=QenZ1yEazlJ19O
	MpkeO7R7JBZ5/pbr2fDsOzJcS/j4fFszZrWyTjpaAspiAenwC9S4goIOxI5Dp2kSlbVyjzBudz/y4
	ccxeR9NdGQ2Fl8hb1S4nZatShZASjZ59L1siUeIKOPYXH7Mcuth3s5cyRT/kIRAfS4H4U3XXGNmA4
	jjqs7ljdGABlHRbPXaOA045KXuDWl1NsM7hu5e6HR/rrnDLrje5o5s5NRbgi3W67RsEjpUF1YL0yN
	/WiUDhBZCKjAWaAm0zL7GQ6LIQSO3WNVoviLN+Rq3uK37W1gds0cru5SBMfobL1lJHm3MSs/JZgCc
	r2y+uqjdq74WPWApXTjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZTO-0007ZK-BI; Wed, 05 Dec 2018 15:52:26 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZTK-0007Xr-KF
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:52:24 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so20237859wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NPPfILoIFLKE7CBqXxkvn0Ogwxu3zT6g0QVqfWBCWbg=;
 b=d9o4snlRCVdxGIqNZrjHZnYmS8JjPoF5c9BE3fu402CAq/zoGotTblGUI3shHkALRL
 R/WqK+kzy6InmCSCTttJOT44hDbTJqlO9tNXcbmsriWx60ru0SeL0w0np47vZWZIuJmY
 clWpPB0c3N88fWm7sPb5sSkJt24oj4OF6R4gCM795x4C41i2mK38jYCmcK4TlYpA/Bmy
 Z2Dh6R2ykWMqWq10RupaujH8FBeiHwYO2YgTm2k8R8QWfYrUeN3980h0MQlhjudSBUPk
 q5cBz0efDjLJHVHX+2F4hGBWY111XMLqiUN8dCRslsR+4ufx8gzFOBuSxnnG6OBuo7Vq
 Ipww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NPPfILoIFLKE7CBqXxkvn0Ogwxu3zT6g0QVqfWBCWbg=;
 b=sRsWCCIZHfHIQfiiDytSxRZfpye7a4TlbErtwVC205vpc/WFRiZxpxzA/7hQaD92WV
 F8+HTPrrPP0umlq1M3F6laBYvYvLGRoJRgTrwgBzVnoKmHnSlDV0e1IHyK2Ft0KMj4f9
 F5naw4i9j8Gcpwd5+APx2x72HmacC+zk3C5tZ+zG8D44bljZmpEk3fzjiezhgFOcBe5u
 67IZsw518teIHO0ATC3de+PAiy2jeF9y9SaVsj7y8jwMzaQr7qEqCBkF7BIH20DipNE2
 hvwuVMRjgWp8RHDtc2oDXyqhFD6E7qCVjQUaPtVpW4UUMI6zQs5Ky1FaT6j1Ff4gemu6
 rJhg==
X-Gm-Message-State: AA+aEWbdTQZUzPoCoxlKAdvRYk61WRRxmHxDnlxiUpVX8VMhXMnDqe7n
 uoZZSwA8PeqaCSjqfZafMAlKKA==
X-Google-Smtp-Source: AFSGD/UH1O9NI33z49IodR57efpZAwkDq+v7iIVwMBLxOmOeZvjL04cyVcqbtUrWA9jheqPZdTUZjg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr21248739wrv.308.1544025130359; 
 Wed, 05 Dec 2018 07:52:10 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:88c3:9e55:d084:7f7c])
 by smtp.gmail.com with ESMTPSA id l197sm12587759wma.44.2018.12.05.07.52.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 07:52:09 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Subject: [PATCH] arm64: dts: meson-axg: s400: Enable PHY interrupt
Date: Wed,  5 Dec 2018 15:52:07 +0000
Message-Id: <20181205155207.25568-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_075222_798475_1AB9BE56 
X-CRM114-Status: GOOD (  10.65  )
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

Now that the GPIO controller has been enabled also on AXG we can hook up
the GPIO interrupt for the PHY.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---

This depends on https://patchwork.kernel.org/patch/10707741/

---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 18778ada7bd3..e7efb5a76f04 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -357,6 +357,8 @@
 		eth_phy0: ethernet-phy@0 {
 			/* Realtek RTL8211F (0x001cc916) */
 			reg = <0>;
+			interrupt-parent = <&gpio_intc>;
+			interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
 			eee-broken-1000t;
 		};
 	};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
