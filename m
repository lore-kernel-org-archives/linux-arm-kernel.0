Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2D520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgNcyHue";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYnabqTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2D520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kNOUHRKlLWmX86MDWawIJ4acY5hD0niMa7HIUfoiU0M=; b=YgNcyHueJ91rx3
	CGil3O5boTA2jqVzRxpmU+XibJ3lOY6dJZ2aDFyK9wuBu7ng5X6702FUpHk0L1wnnb7YkUpF6Ivid
	nbeRsEdzgVCOHVrYftlYbY8m7hftjlDUkWvor72F6YzOto5l/rRnKxzfK6qQqWEBggdxuUA6/bz+i
	EYThKeB2pEmBDyhjTVRByiFUH2W2kW3jkrVx0GO3HaSnnsmCmO8NyJMSQmtzZFRd0zYT8e4HjUGlZ
	fCplopzS8JrW6QjY0sZ7eqkJf0NBHGDgg4l4l4lSySaxDU+h8+rPARLWXxfMZ11a705uLBc9Ig/GY
	5e0Tgp3fIBDCCv0fPqlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqZi-0007fz-Dz; Thu, 21 Feb 2019 15:47:50 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXg-0005Me-SQ
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:07 +0000
Received: by mail-lf1-f66.google.com with SMTP id z15so4428533lff.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aeX9DWMdIFwcCgwi5VRHCh7QUyGrTDz0LIVexfDO4ns=;
 b=XYnabqTjwlcFuRqpn1M7sOJ7WljjxZ5KskCNH9dePB+MUgaOmEb98LhAj99/0QL+S2
 5IWtF6IzRmgXj4MWGBvxhE2+Uj0O4ErDOgAskSv00NppLWEqMwHXrWUZ2S5RN7evnqzv
 08cv76XGysCdG+0ynYindZFE7VKg4/NrF0v6lNlKBXqzNNS5M+WhSJv2Z7xMDXThcjJv
 AaDirCR4pWgIKJrDphX6dVRxyR9M1m5k4dP65kONEAm3uzoJ6HvK/XPlKko6jz28Tgnd
 VnvZHwN4MU27DxpvjAx8G+UTQaveYJ/G5AsyN6dO+x/YKf6aycntJZUHCuBG1dm2Zz3e
 ak4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aeX9DWMdIFwcCgwi5VRHCh7QUyGrTDz0LIVexfDO4ns=;
 b=MIraI87uID8Vk9UqJqI8PicQOdR8dvCcIJmdby2Etpe081bhaFj6ZEG1Rw6yeDBgja
 5eMmpwJql+VrevqiiYWAqzt54GeBuVeRuQ1qcRK6p0FOy9AvCM8ejBTXnA8Ht9ZBcZG6
 CifhB8Y8NUxh3xk4XHXj5V68C8rSQBhvriYgLzj5rCzzqxaoOZZYfyuIpipi1yn6BXMl
 quMyniXOu+99Tw6aGXn6UgyVMzwqtsZWFlunrEyPkqWKEgznIrpEiNLPaplU4/xEYEHK
 /0ZsU5lIsB6QYSQwHyKBsucUfLCS2eJ6qJayylXC3e2xY8M0uwdBgnAL9mJJ0wYM6Tq5
 yFYA==
X-Gm-Message-State: AHQUAuZMQPVLTDQzJt0+hAvvMfQKNKlGSGuKmWEEHucnVzxQt8tOpHgZ
 G3yDT820MIzMZEf1cd/Mb4m0Mrj50dE=
X-Google-Smtp-Source: AHgI3IahL2XAYHRi70eDjSQLT20MNWwqltlhq3pvb5n06LR76ySF8ttXZat/T2kAxdiWjA5tJCoTjA==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr19569935lfl.4.1550763942246; 
 Thu, 21 Feb 2019 07:45:42 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:41 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 13/30 v2] gpio: ixp4xx: Add DT bindings
Date: Thu, 21 Feb 2019 16:44:41 +0100
Message-Id: <20190221154458.23763-14-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074545_406312_A76579A7 
X-CRM114-Status: GOOD (  14.72  )
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
 Rob Herring <robh@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds DT bindings for the IXP4xx GPIO controller.

Cc: devicetree@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collect Bartosz and Rob's review tags.
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
index bd04142b1026..b44ee076d57c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ M:	Imre Kaloz <kaloz@openwrt.org>
 M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
 F:	arch/arm/mach-ixp4xx/
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
