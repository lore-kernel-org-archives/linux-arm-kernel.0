Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82246C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517D52084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WLEZffut";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECxyQy0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517D52084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WPpR42iWJu3LTZojGsOAstwMWvcVefNb/6tsrc6QjLQ=; b=WLEZffut/gLQ5s
	wTtNuQYkxrYSO+Qozz1TApfLs6/sR/eYqll/3iM+u7kZBq3qUld/FTSmhSJ1h+G6snTVqViKsqDpH
	7b2AamJhOIQ7yW25hsVIZ/U8XlyqFc8JDnRHbpYEm9ZPCKH1td92G63zDXP/o07ainRTS4qYX93Cu
	KtzU6n0Jp44m8vXjBrYmR+wN8oVxXXnO2ImzMCYK0hy7wxud60D/vbcoFDCILPGuaTAZWV24Z+VbN
	oHvUxK3J2c5IhhNUelNdwDMhwMJzlx7NPiRYr0w0tOlcQfysCKGdAjNxm5woaGkj9U0oMpSsxBA+D
	OXMWlb7LlWHacPibU8Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPab-0004Zg-G6; Sun, 03 Feb 2019 21:46:09 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXS-0000DT-GP
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:21 +0000
Received: by mail-lf1-x142.google.com with SMTP id z13so8858615lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZXVoeReBcA5qhCvRDJOIchocuRkU673IoSvxfhcDnRc=;
 b=ECxyQy0xpoDT+C64AisnWqfw9kRIIkSzRvPct5hFWkrma/NU1AIvwFhXQ9n/a0fmpH
 VsEaB24wBIsmTrzWNbsLzdKh/DTN9plGIX+inS0yUvNg7I1V/LuzevgA25/dU1ElLBW6
 pQk+bgfRjlxL0Ak4PvUc5biFksJJbuVfudSfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZXVoeReBcA5qhCvRDJOIchocuRkU673IoSvxfhcDnRc=;
 b=iAlf0+v7bIn1EB94vIrbc/IsmXWklx2pRyeIqR6k79dkc917vRbo14jcUTSMBawMP/
 RgqnhkMj85vP+URtPW/pNb3Vu4Ntuq+gCyfB4Dqh/MPC1r3Pk+xZplU7QWFkzwGhzT0X
 C5/EZbj5R+UV2no1zYNzdlxR+zymDlbyXobd08NCOndUCp1JmMTY5fAQYCJ3qJ0ZLoT2
 LRAbkJO7448G2gWvq2ma/4nZQ43kkeMoPeWCLABtY+GvIGIfedr+XVCP/8+iCMeyiHQH
 RG9kIjq8jZb3aXfTUt3vnhpHha0+kazWWQmkPmzXjieGP16R3U+K9RN7aG4+LrQUc2lI
 41Dg==
X-Gm-Message-State: AHQUAubV5rOFdXW26yYJc+ez4mddDk8AuSQE3vRsqu0Kk8p8A2L++W+p
 jLsxQR1uDnEsIPmVTQYeGX1y6eu08Xw=
X-Google-Smtp-Source: AHgI3IZdawhcvOEItZ3jyw7pBrf3ST/2h22zI3u0BjdshkL51jTI/+wuO6r1+T1rz1HCNJ4PO/03qg==
X-Received: by 2002:ac2:5087:: with SMTP id f7mr10905533lfm.100.1549230172698; 
 Sun, 03 Feb 2019 13:42:52 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:51 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 15/17 v1] ARM: ixp4xx: Add DT bindings
Date: Sun,  3 Feb 2019 22:42:03 +0100
Message-Id: <20190203214205.13594-16-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134254_949645_6FC78B21 
X-CRM114-Status: GOOD (  15.54  )
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
Cc: Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
 Tim Harvey <tharvey@gateworks.com>, Linus Walleij <linus.walleij@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds initial device tree bindings for the IXP4xx machines.
This time I tried something wild and crazy and try to make proper
JSON-style YAML bindings for the top level.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I have no clear idea on how to auto-test this schema for validity,
since it is a bit of a new thing I hope to figure it out as
we go.
---
 .../devicetree/bindings/arm/intel-ixp4xx.yaml | 22 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml

diff --git a/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml b/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
new file mode 100644
index 000000000000..da5f6ffe6f2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/intel-ixp4xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel IXP4xx Device Tree Bindings
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - linksys,nslu2
+          - const: intel,ixp42x
+      - items:
+          - enum:
+              - gateworks,gw2358-4
+          - const: intel,ixp43x
diff --git a/MAINTAINERS b/MAINTAINERS
index 57d098b85523..c4ca249a2075 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ M:	Imre Kaloz <kaloz@openwrt.org>
 M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
 F:	Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
