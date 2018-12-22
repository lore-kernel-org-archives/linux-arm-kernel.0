Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DC3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 07:25:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6C421939
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 07:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W7ZMjdGK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gnmed0EE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6C421939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5fPDxB85dU+uBeED1xFyjdjOGB7XpOteo5Sycae6l7g=; b=W7ZMjdGKMP+dJM
	ZBeWvN6AWikSp/0XANn5PS9gBf4VKB4NtRBZ/FXr86M9E10XANn2Of7RcioSk6TlglmJ31+yB+MTb
	YNVDbONrIqzHi1tQqSkCByNfO11Fpi0iI0hE3qncTByY51IspWJ+rvllo0pWfpn4DBkpa6RNz/pXV
	MLv03jx4MlTxW0oQvdiPITP9RrSqInu7YpsNAjC6w9RMOQVY7o9YfJNXdSdySkdXV5OKkCGovC7Ny
	1Or2slbw7hCbhHiLljwxSopEq3ebmxuYHK2a8Whtg3pgf0wMMDHfwzE0avx1lrBiO/BK24QYspXd1
	pJ48XbkwrAoyppEEVECQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gabeq-0002SN-C6; Sat, 22 Dec 2018 07:25:12 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gabem-0001DS-Uz
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 07:25:10 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so3500826plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 23:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Am2wUODHH0JsEj7SXIZCLf5E3+sl55uz+ynr3m0M9Nw=;
 b=gnmed0EEX62vcIGeZntu9yWGS9IcOPbrLKx2pElcsezpP9VBv9RlKrHI7LsRlewzkj
 TioKp5ipzJvBiJICtlAFHtI3XjL+j9WVA/BRSLqvxmnWCq/ZeMFpa2pZB+pIjN4cH+Jc
 m7TCbrbgFHnm6TtC+LqzMUPj9bD21l1hd4zx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Am2wUODHH0JsEj7SXIZCLf5E3+sl55uz+ynr3m0M9Nw=;
 b=Lo2hR6NiPPb1br2Dfpv7N+ipEOMLC2EmI/CJ2ggjlvIQ5I2Z4uBjuZWkGQ8wS9XJYW
 7kRq5S+J98tI8HsMiTdef/6IDflPFIYM3lLbtKcljTFuuOOK2Pd+w2qmU3PikYF3FNRb
 GhP5rpeWXN4uBQxNwNmi//BKTsP7ibcIp1j6qsnthp7AfGs6bovxR7zFSEz8gZ6bZsl8
 3NIBjE+yS7RpoNYkUtWZv+LPgFcueY5VAAcCw4P5L/bpyhxd88JJBh0rMFeWhKooCPqi
 KEJOie0kQWbwrzZsSL7L5lLvIyl2qida6MxEBoKqXQlBEqmvrwwnR5pWg+OYpp4E7oTa
 I5fg==
X-Gm-Message-State: AJcUukdVGeAdze81+5IHK5jFW/6xGFgc2lDRs/w703G+N7dIA/ma++V3
 1gfoKv8meMQ/4XMYef9Lh5RrUA==
X-Google-Smtp-Source: ALg8bN4FuIBvdD6+z/okD6bFYs9tJf1Y1GhHqzXObzUinfzP3bwU67uQDiPmHbo6oLTZ7FDpWdxKEA==
X-Received: by 2002:a17:902:161:: with SMTP id
 88mr5694497plb.306.1545463494906; 
 Fri, 21 Dec 2018 23:24:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id 186sm53825350pga.36.2018.12.21.23.24.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 23:24:54 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: robh@kernel.org
Subject: [PATCH] driver core: platform: Add an error message to
 platform_get_irq*()
Date: Fri, 21 Dec 2018 23:24:52 -0800
Message-Id: <20181222072452.186726-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_232509_037195_FDFFE908 
X-CRM114-Status: GOOD (  24.32  )
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
Cc: b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 javierm@redhat.com, linux-kernel@vger.kernel.org, a.hajda@samsung.com,
 andy.shevchenko@gmail.com, broonie@kernel.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A grep of the kernel shows that many drivers print an error message if
they fail to get the irq they're looking for. Furthermore, those drivers
all decide to print the device name, or not, and the irq they were
requesting, or not, etc. Let's consolidate all these error messages into
the API itself, allowing us to get rid of the error messages in each
driver.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Rob Herring wrote:
> Shouldn't platform_get_irq (or what it calls) print the error message
> (like we do for kmalloc), rather than every driver? We could get rid
> of lots of error strings that way. I guess there are cases where no
> irq is not an error and we wouldn't want to always print an error. In
> some cases like that, we have 2 versions of the function.

Yes it should. Just by coincidence, I got around to implementing this
patch yesterday after I bemoaned this on the list a few months ago[1].

> Not what you're addressing here exactly, but what I'd like to see is
> the ability to print the exact locations generating errors in the
> first place. That would require wrapping all the error code
> assignments and returns (or at least the common sources). 

That could be done with some macro magic to add __line__ and __FILE__
into a definition of the "important" functions. In that sense nothing
would really need to change besides the implementation, right?

I also started working on a cocci script to fix up the call sites to
drop the extra prints, but I'm really bad at writing semantic patches so
please help improve the below. My simple grep shows that we can remove
~500 error prints out of the 1500 places the platform_get_irq()
functions are called.

	@@
	expression ret;
	struct platform_device *E;
	@@

	ret =
	(
	platform_get_irq(E, ...)
	|
	platform_get_irq_byname(E, ...)
	);

	if ( \( ret < 0 \| ret <= 0 \) )
	{
	(
	-if (ret != -EPROBE_DEFER)
	-{ ...
	-dev_err(...);
	-... }
	|
	...
	-dev_err(...);
	)
	...
	}

[1] https://lkml.kernel.org/r/153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com

 drivers/base/platform.c | 52 +++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..75ceda9f452a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,23 +79,18 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-/**
- * platform_get_irq - get an IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+static int __platform_get_irq(struct platform_device *dev, unsigned int num, bool warn)
 {
+	int ret = -ENXIO;
+
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
-		return -ENXIO;
+		goto error;
 	return dev->archdata.irqs[num];
 #else
 	struct resource *r;
 	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		int ret;
-
 		ret = of_irq_get(dev->dev.of_node, num);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			return ret;
@@ -104,11 +99,11 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 	if (has_acpi_companion(&dev->dev)) {
 		if (r && r->flags & IORESOURCE_DISABLED) {
-			int ret;
-
 			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
-			if (ret)
+			if (ret > 0 || ret == -EPROBE_DEFER)
 				return ret;
+			if (ret)
+				goto error;
 		}
 	}
 
@@ -122,13 +117,32 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
-		if (!irqd)
-			return -ENXIO;
+		if (!irqd) {
+			ret = -ENXIO;
+			goto error;
+		}
+
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
 #endif
+error:
+	if (warn)
+		dev_err(&dev->dev, "IRQ%d not found\n", num);
+
+	return ret;
+}
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	return __platform_get_irq(dev, num, true);
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
@@ -142,7 +156,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr, false)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -195,7 +209,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	dev_err(&dev->dev, "IRQ %s not found\n", name);
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
