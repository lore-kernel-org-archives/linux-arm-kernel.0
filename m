Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA31C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:18:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1FF20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cVLJBj/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1FF20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t0Y0XmYIKFkE7miw8HhxUmG9GIjWpuyqHLtgUI9lVdg=; b=cVLJBj/ATLeWb8
	rGvjZNjrF4LA5QjtCVCemhHyH7KPC0pbwIjVuerqHBukkTP3BEpCQoaqW0IPKLHQuy+lphnr0wNhF
	VV9LO8KYfI9F///qp/ZUydUMJqKZtdL85gE9+RcUmsAA67KDROoHz+RpMcAlOyk3qZlPZikfmvLG1
	6oPUM/qst8mu+6TkB/qtAd14w2Vxym8c/X4iDkC5gvlDLIqfmR05hxBIotT8L0bDrlnTggL0Vo78Q
	7LhI1whrDHmbmpX6qW/d9BDoQA8me+vlPayvzkOxeNBjltZELU0VUw2kXoDraudt+s6/jCbmvscES
	rEgtco3t5o6aolhoUqsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnBe-0007Wp-Ju; Mon, 03 Dec 2018 12:18:54 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnBZ-0007TQ-B7
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:18:52 +0000
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so11137802ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VuiEaW0Oj53yp3q4uxN2C3Fqx50TMkjVvsBbGOjHZUY=;
 b=qJH36OOPvA+8KnXUnn6ZOX6TA93P9hBf/QKGEFe/diremRDjqoEKoRhKHJsYT0j8yi
 jC6cNc+1Z/ysNZF6J+cRVlA959xBdu4JVmpALzaM49rG7v8msc4YVlJBeG+Sjhyf2XTf
 63Fxc8BqWa3AMUR4qHpIkktCNQZIRmwGYU5rC4vhzgOfqKURVFTGg+BgLlJxG3mW1pxH
 hD+r22EJRnMVRlFnxYBSNYsIi8qwKMzPebBCVyzqyxA3Y66ioq5aWz9OJZBqOfpPCNHp
 z/t3p5pw4L3AXQcL/VdrW99vJCiTbcsI/adxB80mu/wzQVWpbM6zjyY/OG7PbsKjmqno
 JsGw==
X-Gm-Message-State: AA+aEWaUOk+giEUhG0McxmPgnYTiNUSiR/NfK9GBFq2EYWIEPQ9RCDxh
 oVMNo8B0+4a2x9yG63FenBo=
X-Google-Smtp-Source: AFSGD/XA0By5ECSehpqZO8rpWGHa5fzid7ZDNrkXSvC063FdQgEuCV198/ybPvKkV2wyFX5cxcZkuQ==
X-Received: by 2002:a2e:9b52:: with SMTP id
 o18-v6mr9879341ljj.108.1543839517681; 
 Mon, 03 Dec 2018 04:18:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id h85-v6sm2478439ljf.68.2018.12.03.04.18.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:18:37 -0800 (PST)
Date: Mon, 3 Dec 2018 14:18:24 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v5 2/9] clk: of_clk - add managed provider registrations
Message-ID: <72d98b6f8deca66d4182c37669ec4421977922b3.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_041849_378427_4E0A8A25 
X-CRM114-Status: GOOD (  19.06  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, lee.jones@linaro.org,
 sjhuang@iluvatar.ai, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With MFD devices the clk properties may be contained in MFD (parent) DT
node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
subdevice not to MFD device (parent). Add
devm_of_clk_add_hw_provider_parent to tackle this issue.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/clk/clk.c                     | 65 ++++++++++++++++++++++++++++++-----
 include/linux/clk-provider.h          | 11 ++++++
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index dbf14326243b..97c9c575b2af 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -238,6 +238,7 @@ CLOCK
   devm_clk_put()
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
+  devm_of_clk_add_parent_hw_provider()
   devm_clk_hw_register_clkdev()
 
 DMA
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..30beb60bd8f9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,12 +3893,12 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
-int devm_of_clk_add_hw_provider(struct device *dev,
+static int __devm_of_clk_add_hw_provider(struct device *dev,
 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 					      void *data),
-			void *data)
+			struct device_node *of_node, void *data)
 {
-	struct device_node **ptr, *np;
+	struct device_node **ptr;
 	int ret;
 
 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
@@ -3906,19 +3906,62 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	if (!ptr)
 		return -ENOMEM;
 
-	np = dev->of_node;
-	ret = of_clk_add_hw_provider(np, get, data);
-	if (!ret) {
-		*ptr = np;
+	*ptr = of_node;
+	ret = of_clk_add_hw_provider(of_node, get, data);
+	if (!ret)
 		devres_add(dev, ptr);
-	} else {
+	else
 		devres_free(ptr);
-	}
 
 	return ret;
 }
+
+/**
+ * devm_of_clk_add_hw_provider() - Managed clk provider node registration
+ * @dev: Device acting as the clock provider. Used for DT node and lifetime.
+ * @get: callback for decoding clk_hw
+ * @data: context pointer for @get callback.
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * Registers clock provider for given device's node. Provider is automatically
+ * released at device exit.
+ */
+int devm_of_clk_add_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
+}
 EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
 
+/**
+ * devm_of_clk_add_parent_hw_provider() - Managed clk provider node registration
+ * @dev: Device acting as the clock provider. Provider's DT node is parent node.
+ * @get: callback for decoding clk_hw
+ * @data: context pointer for @get callback.
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * Registers clock provider for given device's parent node. Usable in cases
+ * where it really is the parent node that contains the provider information.
+ * Typical use-cases are MFD devices where the MFD sub-device is handling
+ * actual clock HW but the MFD node (parent) is containing the clock
+ * information.
+ *
+ * Provider is automatically released at device exit.
+ */
+int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_node,
+					     data);
+}
+EXPORT_SYMBOL_GPL(devm_of_clk_add_parent_hw_provider);
+
 /**
  * of_clk_del_provider() - Remove a previously registered clock provider
  * @np: Device node pointer associated with clock provider
@@ -3950,6 +3993,10 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
 	return *np == data;
 }
 
+/**
+ * devm_of_clk_del_provider() - Remove clock provider registered using devm
+ * @dev: Device to whose lifetime the clock provider was bound
+ */
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..a6663f084cf1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -916,6 +916,10 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data);
+int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data);
 void of_clk_del_provider(struct device_node *np);
 void devm_of_clk_del_provider(struct device *dev);
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
@@ -953,6 +957,13 @@ static inline int devm_of_clk_add_hw_provider(struct device *dev,
 {
 	return 0;
 }
+static inline int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data)
+{
+	return 0;
+}
 static inline void of_clk_del_provider(struct device_node *np) {}
 static inline void devm_of_clk_del_provider(struct device *dev) {}
 static inline struct clk *of_clk_src_simple_get(
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
