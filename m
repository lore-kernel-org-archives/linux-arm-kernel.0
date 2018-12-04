Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:35:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127212087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VielMhzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127212087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xTu7PW5xa6y/JvFSEAwe9011BgmRGAY2Rj0J+E5/yIs=; b=VielMhzWEHlTgt
	bj14p3/CclR7LoE7hh6lKFz9IYZFeMEqoU4zN4S2MdVQjBfMeosNr3PLNPSLtaVDuGPz9G5mXvwzh
	9haQNmvn9CaZk8J98U1XHl5HW5EOsPojNuo4vaFoIkSN1UPAY7dukSAr0BB1h1QfCdLgWrhh4ZLF4
	zkHNvi4lDKKkPc2DqsLKDdZY+3Oh2eb1amnQkJlkhwJKqHa1m51DyviRJ+Itm0ocdqH1aJ37pneD6
	iZNcYdyczBjVS6TiGuuBECtvn5ZJZx13+1GrXLpv+oPAA7B0Yju1cSeEe3/vR6sJO9IWagIfBTI0Y
	A47mSD2lpz2nkS+xv97w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8z7-0001YR-8A; Tue, 04 Dec 2018 11:35:25 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8z0-00019A-Ci
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:35:23 +0000
Received: by mail-lf1-f66.google.com with SMTP id a16so11693058lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0RckClGYQ+6fUhKznGresT7KY8caowujFh1vtX39WAg=;
 b=Y8I0KELimJPmFTKYRqc2Wl2KjOj0fx83BV/07MDbGifDtqkGen+D/YmAJvQOWsdySp
 La6eSDMvY2ysJmEe3gmo3uFbJ6uULjuPOsCOTMcei2lZyfL/AYNCaSD4Y0QyDcpn6rkc
 /JJXtxBv6hP0yfFbd6BlNLufZBLbnriC60rAGakpP5yFLajzMl7eoeIvkuYs6cvpScC/
 3FmLYjPMBMo94bxEgrhERR8sV5jZpl1FxkRoahR6FmofJwvZCnvIeDHJPhqYjSBpuyNt
 AGUKESQZiCGbno7QiW4mxC+xVjdAjBYS4bgWOLXMvpGYyvIjxuxUQWRY01hV0+e2d/mv
 dFmA==
X-Gm-Message-State: AA+aEWbkJvqVFjObBTlFow2Ofa/L29bZV80rs78aAR7/SfDYBDaBZ6OG
 DFDixwBmyWfUML2k87RF1GA=
X-Google-Smtp-Source: AFSGD/UgenwKc3SIhW9D1jJ9m5flJIPZI+ng3DCVvFo6WFolegTKyZfQr7vyCVs8/MQiK0k8Dg08+g==
X-Received: by 2002:a19:6a13:: with SMTP id u19mr11029739lfu.46.1543923306734; 
 Tue, 04 Dec 2018 03:35:06 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id f11sm2937781lfi.12.2018.12.04.03.35.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:35:06 -0800 (PST)
Date: Tue, 4 Dec 2018 13:34:53 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Message-ID: <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033518_431433_5F499891 
X-CRM114-Status: GOOD (  18.20  )
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
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It seems to be usual for MFD devices that the created 'clock sub-device'
do not have own DT node. The clock provider information is usually in the
main device node which is owned by the MFD device. Change the devm variant
of clk of-provider registration to check the parent device node if given
device has no own node or if the node does not contain the #clock-cells
property. In such case use the parent node if it contains the #clock-cells.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 78c90913f987..66dc7c1483d7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,6 +3893,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
+static int of_is_clk_provider(struct device_node *np)
+{
+	return !!of_find_property(np, "#clock-cells", NULL);
+}
+
 /**
  * devm_of_clk_add_hw_provider() - Managed clk provider node registration
  * @dev: Device acting as the clock provider. Used for DT node and lifetime.
@@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
  *
  * Returns 0 on success or an errno on failure.
  *
- * Registers clock provider for given device's node. Provider is automatically
- * released at device exit.
+ * Registers clock provider for given device's node. If the device has no DT
+ * node or if the device node lacks of clock provider information (#clock-cells)
+ * then the parent device's node is scanned for this information. If parent node
+ * has the #clock-cells then it is used in registration. Provider is
+ * automatically released at device exit.
  */
 int devm_of_clk_add_hw_provider(struct device *dev,
 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
@@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	struct device_node **ptr, *np;
 	int ret;
 
+	np = dev->of_node;
+
+	if (!of_is_clk_provider(dev->of_node))
+		if (of_is_clk_provider(dev->parent->of_node))
+			np = dev->parent->of_node;
+
 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 
-	np = dev->of_node;
 	ret = of_clk_add_hw_provider(np, get, data);
 	if (!ret) {
 		*ptr = np;
@@ -3968,9 +3981,15 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
+	struct device_node *np;
+
+	np = dev->of_node;
 
+	if (!of_is_clk_provider(dev->of_node))
+		if (of_is_clk_provider(dev->parent->of_node))
+			np = dev->parent->of_node;
 	ret = devres_release(dev, devm_of_clk_release_provider,
-			     devm_clk_provider_match, dev->of_node);
+			     devm_clk_provider_match, np);
 
 	WARN_ON(ret);
 }
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
