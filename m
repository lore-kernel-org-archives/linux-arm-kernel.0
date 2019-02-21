Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E003C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:03:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6132083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U8EmroSN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="syG1G6td";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdGQDh7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6132083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+GUJeE5F7a3qopqfo9CorhbSZA5g4GYZ+1h5UGUKX+4=; b=U8EmroSNBY2UUD
	bJms/PMbTLXwbD6pjkkcxOzqGOZhiEf4Y4RwBpAUr/OLH7KaAG++/+49KMWMipJtJUSMcMLtMVnJi
	xM/xYmAtc6W3cGbgke+/TEG1RAdyzu5w+Zzw/n4FoRoi6Op2eTIMZjDfjN4QbhVqDmfM53GbIA+CJ
	rlLUB0tfMn7RuuJDTzHrP4ZUh1cDPHT+K66oAc3qXOX+SSvbyn7CnGGULjm8QvHIzwAYCqpzR8X+q
	m8RjEP6qIDFY7Dv4AsgKNaksDxhJiQ7YtCC59TaZvZCOpG7NZSC3K2oAd4ArIK0Bd+vffb2UQls14
	nlmJLkiu0148/nYZaeNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqoh-0001rh-5m; Thu, 21 Feb 2019 16:03:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqns-0000bs-Mj
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GnaI9YHPXZ63mtHWRidjn+9xBecr9vZlVNuaRUYughg=; b=syG1G6tdU+hfWIzC/QbQsclPzV
 mI0dAZPHsbgKiFmkakzV8RqZklq26aRO0mnYsYP1ggOXTxRp1UtGaZCT8k/FCKvXPXmCGCGiMZbgB
 WP1gF6IR2CfknJRosY1TGgi19JZNXhyEX3+50TJftSvvxITVYWZFRR0sfBu0OCJbyHqpNGQvV/SFD
 X2mzSJZ2XjfKtpEqsf/Ze7tySmUB1yaZBqNMGQd5m/M8TOZdq0jAWOd+c2Z3FsXBBcr77px3gjvzs
 XcskP1sKTguyXo2j58/5V7IJIpM6Qb7Hgd+XlHSGaL37nADLLgkq8NCRBz/Iw6yviCiupQsm5iREh
 4GDlUV3g==;
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXm-0006oq-1Z
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:52 +0000
Received: by mail-lj1-x243.google.com with SMTP id j19so23605393ljg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GnaI9YHPXZ63mtHWRidjn+9xBecr9vZlVNuaRUYughg=;
 b=TdGQDh7C1vZdMooN9Tpo0mwTTuochx0oxAyQf7GtDI/6Y2987Yh3H6WyNZR458IP21
 QlDcAmsqaiX2BGm+rYMg+HnnJthQ+MTnTnI/EHADC4d8wxUYBWPfH9TaJhPcYSnKhUrO
 n+xJI8kTzwn7m3J/tbCKU7b4fVB/yzFu09gGPYRyjc9KPJsRQhBhn3PqZrJ2fDu8p07s
 Wrs47VkrjyvI/AXhCumDKsMkV7GThWBIlKW5fwnjidvPG9ca0F4bKeeMrS+zqyzpQ/DF
 NLwvM0lj+10eNigUemvtQKrHUR7cAl9r82U7BZvK+oVD7+8l1Fl2hFFYURohyH5TqT7/
 SX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GnaI9YHPXZ63mtHWRidjn+9xBecr9vZlVNuaRUYughg=;
 b=nwMx6o+LOdYEfF/HuyPyKjbw2SbTr1fq3qHthFGBux+i15+J7Wyc/nr6WPKTapPDtS
 WNosz2Y31BHDpjxmSIOtVLwQwJNb+Ze7MBe9RKpmK1+SrqTswozKWjE1GopX2tVOJ242
 h/piZYMgguuzTTtxn6c11RPSYfkCSqluST/BMXa2f6uS9XKc5oFuep3Ke19htvYEbnXM
 yf/DqqiH0DeHFBil8O6496VxcBtO6YmwMOyHzRceWrzSUK1U9bbptaEATRxuLA+VsGl6
 B/R0/9/bwTGWuhwLHtAXMsmKOH1Z+vGqokNMChL4nXGVUHe9PgQrv2C6mmKxriiYQMj3
 EmVw==
X-Gm-Message-State: AHQUAua+gK5C5fzF9QkmR6Y01EE952axdBbbHoINC4BlTfCOdzHeZKrJ
 oBc6M1Fj0d01kfvmpJaDXNCjIbmT968=
X-Google-Smtp-Source: AHgI3Ib3d7Jg+bEoLFuLEidja+13ExMzY8HvtkBT7uG0JnElTxg+aLhcTKYKRQbWT/9E8WZ9lHFeiw==
X-Received: by 2002:a2e:4285:: with SMTP id h5mr21972562ljf.32.1550763947317; 
 Thu, 21 Feb 2019 07:45:47 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:46 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 15/30 v2] ARM: ixp4xx: Add DT bindings
Date: Thu, 21 Feb 2019 16:44:43 +0100
Message-Id: <20190221154458.23763-16-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_154550_139040_86835CEC 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds initial device tree bindings for the IXP4xx machines.
This time I tried something wild and crazy and try to make proper
JSON-style YAML bindings for the top level.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix up the GW2358 compatible string.
---
 .../devicetree/bindings/arm/intel-ixp4xx.yaml | 22 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml

diff --git a/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml b/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
new file mode 100644
index 000000000000..f4f7451e5e8a
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
+              - gateworks,gw2358
+          - const: intel,ixp43x
diff --git a/MAINTAINERS b/MAINTAINERS
index b44ee076d57c..20d02e1e60a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ M:	Imre Kaloz <kaloz@openwrt.org>
 M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
 F:	Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
