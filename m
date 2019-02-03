Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45CA2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bxBGk7pK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJwvs9MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45CA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zha59ETfzMp5y9xdTOJ7Lfi46MGjaJ3ccI0s+pAvykg=; b=bxBGk7pKvuEOVn
	bJnhoI2Iiyzxh8TP7OaOWyut7CJLtqOozGaYDmefIfFe0mx4+Xnb9Bk2AWmMbLKTbRRdMqX76lMxG
	ug76Ymk5rjwy0DGrN6lr6uRID8jDJsKzasvtlAZU3k+u9VOedtBpyqiqUnCPQilK5p3cx5NkvkOQq
	+tykas/KPoetlvURSorzlVTB5Ii++LJ4tiEHjFQeWKxUwWUwIvDh10aDbmigYI/nnK192M1bXq+oQ
	hm6LcdJFsRrV1ruceh8FxhFwVPm5XGxqYhOqx9InTfp8oaQjtWnso5GGMQFz0Jnng7T/up36y29xc
	C2WnOKH5doH4FKDaHsoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPa9-00046Z-FO; Sun, 03 Feb 2019 21:45:41 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXO-00009I-C5
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:11 +0000
Received: by mail-lj1-x241.google.com with SMTP id k19-v6so10000581lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tqkowpPvCE0gZkM+u8f2imx7BQRKOcq+GoRfFNueR54=;
 b=IJwvs9MOeRugN+kldoyML1h6U8pW/u5JfJB+FpKNU2ADfqbW0n4jBoiSTLsuZaaiCq
 fzSET1TqL26gc9Nm8nB/Qg3wnSuRXW8bp0y7MR35uLlkBwpXvVVnJ1ulUlX10fnVifxm
 MkuCnHz/yR9EsH/sV3TqEqmUxVxhdeQT3IODk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tqkowpPvCE0gZkM+u8f2imx7BQRKOcq+GoRfFNueR54=;
 b=KhiusSZ1CNzrl7A5oJP5ukZW3RE7qCHw2Q3mhJa3CS8YhpOv58ntRs8mdIVdKxRkby
 xlgXPRp4pi/T0sqEzI5F1BfuPCMtzd66djqACA8ZYNoLrsSVOh+o6cSWiTKulqTrQbEd
 w38+CLLbsRn1lbQid7NgnUTGM2k9UlJqMmSSOfkPsoRo8s8qqnoas6CaJ/etZj2G/Sq6
 xtbLtaguPE8zyiUaTi2jax2wcAPYPH1+KySD2qb2LfMQ3qRCx9DlXJakNfcZiknKXN6r
 KFIlGJI3UELXScoJh+xXxQ5cGPUS9EsudJHaDuye4gVZRzdQ94gRAmH7KLJZIGWmKk71
 Yslg==
X-Gm-Message-State: AJcUukfx9t1uuo9JAIwIUXRl9quWnDe9IbvT/+i6tbXHAX9hAUqLmWOC
 GomuFqyHwvcqS3uKtc3FJT0XfRpPyb8=
X-Google-Smtp-Source: ALg8bN6lftZYtdZ8S7AWncbZCgrCMsD4uwVN5T5vyITS3mEQeaJfYm60Z7LS3rMFni3DqnwiQkNV/A==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr37835659ljo.10.1549230168522; 
 Sun, 03 Feb 2019 13:42:48 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:47 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 13/17 v1] gpio: ixp4xx: Add DT bindings
Date: Sun,  3 Feb 2019 22:42:01 +0100
Message-Id: <20190203214205.13594-14-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134251_313391_3FDEAACC 
X-CRM114-Status: GOOD (  15.25  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds DT bindings for the IXP4xx GPIO controller.

Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Bartosz: looking for your ACK on this, it'd be good if
the other GPIO maintainer is aligned with my ideas here.
I intend to merge this through the ARM SoC tree.
---
 .../bindings/gpio/intel,ixp4xx-gpio.txt       | 38 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt b/Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
new file mode 100644
index 000000000000..8dc41ed99685
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
@@ -0,0 +1,38 @@
+Intel IXP4xx XScale Networking Processors GPIO
+
+This GPIO controller is found in the Intel IXP4xx processors.
+It supports 16 GPIO lines.
+
+The interrupt portions of the GPIO controller is hierarchical:
+the synchronous edge detector is part of the GPIO block, but the
+actual enabling/disabling of the interrupt line is done in the
+main IXP4xx interrupt controller which has a 1:1 mapping for
+the first 12 GPIO lines to 12 system interrupts.
+
+The remaining 4 GPIO lines can not be used for receiving
+interrupts.
+
+The interrupt parent of this GPIO controller must be the
+IXP4xx interrupt controller.
+
+Required properties:
+
+- compatible : Should be
+  "intel,ixp4xx-gpio"
+- reg : Should contain registers location and length
+- gpio-controller : marks this as a GPIO controller
+- #gpio-cells : Should be 2, see gpio/gpio.txt
+- interrupt-controller : marks this as an interrupt controller
+- #interrupt-cells : a standard two-cell interrupt, see
+  interrupt-controller/interrupts.txt
+
+Example:
+
+gpio0: gpio@c8004000 {
+	compatible = "intel,ixp4xx-gpio";
+	reg = <0xc8004000 0x1000>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 775a623dc91d..57d098b85523 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ M:	Imre Kaloz <kaloz@openwrt.org>
 M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt
 F:	arch/arm/mach-ixp4xx/
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
