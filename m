Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE9BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:07:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6712081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bMGbn9ZC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I6sALBJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6712081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ye5vPfhTIJKB43WCjZgRoWNQtFVhwORORU5WkLLycPk=; b=bMGbn9ZC4iu9WI
	uL8DuWgvki8sHHNaPSwLxEf4lfs8eNQE6gKQVZeHrmla89VLjtGa/sbWmaW7tZJIur0X83GpWQhfW
	2een+1kVwm/56L269P83R1VBuA5nvvXT6MylRAzi7+/yecopJUO4FQyqdElh/hFQPXzb/cGCvHHYP
	nYhYb7E5qPzl52QDB7XdNq1pUd4LmINLTc/mI3D4fUfj9aS/YXImMSQyRbLJHBSK0EvdXn9ZM6elW
	yBnUlwEqOx/fgvM9kuixm+rXmAwlbSoztYwAKG7iOcrTrFWhv0q1wKpQxxbGTcNXJS/mmi+Svge2+
	hc9zIyovXtrIUNK5gScg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHXZ-0000zS-Bp; Mon, 10 Dec 2018 09:07:49 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHWm-0000E1-Bq
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:07:06 +0000
Received: by mail-wr1-x443.google.com with SMTP id u3so9621147wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oeULTOCMjinSO4pcUUBmFdzaevw7sbCnt/ss9FK3o1w=;
 b=I6sALBJbSf6Ws+I7JqLVMwcAtWQrE0bPZ/XjUMKIB5DaZXXLO4G0eDpjU2NWZqQiPn
 3SX9EaaZS53obN5APJNkjQ3f6hPiXY0xzyfq66655nIxKDFMWakiF43WsmgyDVwYLcVG
 D6DmDs1+9BEBsQ/Qoj/VhZG6w8WUYP3hRmBVBkyFk+Xtwt5heqM8/L1BAORcuAVkaL7i
 A4EQDbGs8CV9skqzsVsb41DGRWXgu9j4pUj1NOOBIKRfeH5Be1V7fi+U82xCopFDimgJ
 1ZmzVw2OhJGStO/n4abCHX3h10TK2EUHCvQSsnrbdzHxSsJ6abi+et1k0JIsrl6Zib+M
 6UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oeULTOCMjinSO4pcUUBmFdzaevw7sbCnt/ss9FK3o1w=;
 b=ucmf4mqzTQfqKSwbbhTC40cAqF4MIglkQlQpkAmKTwX5BrXg3jMszCtEu8UBc80hjP
 4cHQYcF6KUeWB+sc9/Vx4kNC5QW3EooLG6dOY/Ztt38fqlJJTX2QTb/jmyUyy5PKRl9J
 43B70GpDAMsHhEA3uM6BMXW5hNNFEZnHsW0GDXv6CrwRDNuEAYRF1Fat15NAfBYqMUJc
 /U5CHq60miehEpQze0MKZy2+YBThHetLQNhvvZACEi6aU2N7csmVDSbpqPAh/il5plXh
 U4YX0HeKYpAUDY5Gsnj1vMstULu+uBzmxUXWJNZncQK+ZFq77THHIBcUgb2eChjfsHBs
 DRUA==
X-Gm-Message-State: AA+aEWbz4oq7SeywgpPjN26fsIV0gy2npZrHIwLwTiKIVlDbJ7lMUFbJ
 zN2A6RK1gIjksaPKoud39xeFSw==
X-Google-Smtp-Source: AFSGD/WJBOPUDjl+ckutJZaMe1sCrcXaNJGZkTGnLYoyGCphvlVOi0PwvL2B9J8iZ1no34lSplU4HQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id
 f7mr9572449wrx.302.1544432808854; 
 Mon, 10 Dec 2018 01:06:48 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id 14sm15856555wmv.36.2018.12.10.01.06.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 01:06:48 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: meson: add specific simplefb bindings
Date: Mon, 10 Dec 2018 10:06:39 +0100
Message-Id: <20181210090640.4495-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_010700_400920_61F037B9 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Similar to simple-framebuffer-sunxi, we support different display pipelines
that the firmware is free to choose from.

This documents the "amlogic,simple-framebuffer" compatible and the
"amlogic,pipeline" extension.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
new file mode 100644
index 000000000000..122a5c005cd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
@@ -0,0 +1,33 @@
+Meson specific Simple Framebuffer bindings
+
+This binding documents meson specific extensions to the simple-framebuffer
+bindings. The meson simplefb u-boot code relies on the devicetree containing
+pre-populated simplefb nodes.
+
+These extensions are intended so that u-boot can select the right node based
+on which pipeline is being used. As such they are solely intended for
+firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "amlogic,simple-framebuffer"
+- amlogic,pipeline, one of:
+  "vpu-cvbs"
+  "vpu-hdmi"
+
+Example:
+
+chosen {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	framebuffer@0 {
+		compatible = "amlogic,simple-framebuffer",
+			     "simple-framebuffer";
+		amlogic,pipeline = "vpu-hdmi";
+		clocks = <&clkc CLKID_HDMI_PCLK>,
+			 <&clkc CLKID_CLK81>,
+			 <&clkc CLKID_GCLK_VENCI_INT0>;
+		power-domains = <&pwrc_vpu>;
+	};
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
