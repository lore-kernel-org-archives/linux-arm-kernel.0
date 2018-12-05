Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616F92082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hhw/t3Zp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="htYb7sr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616F92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EaU5cFcsMigWlT0HS1zPsbN9ltcrJfG9x3X335iwXkk=; b=Hhw/t3ZpVJrGqQ
	bN59Qdyy5D9cQ44fBJNyRF8AvYj22gy5VtE4od4tqYRnSxfZ8LIdpzgGYJtm1scfzb9I8VZsZiAhX
	9VjLDFj5okAMHx2fm8dX1IrvuLj5puedjDtTh4tGoKAPqx/8k1UBqPySSgmx6JSBORxzyXiEMsKMo
	1r9zyFAz8NkIfkmEV7EJlHgFm+PI9MNyf/jZqHAz3FZvFAMN2D0FNfTQ4fcbwqGmjfBSlMx2Pe5rf
	CJaPtbpBdy5z/vCuHwqMeBmQc9nYcVGd9UgmJwqOH0A0IksMs86hFDU9AI9D0adlxEV63v31yiwBT
	+qKiXcV0b/dFGhnQWlKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUapv-0001NL-KD; Wed, 05 Dec 2018 17:19:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaps-0001BH-KJ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:19:46 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C32222082B;
 Wed,  5 Dec 2018 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544030373;
 bh=uzsaPsig8b873ezprISC8EwBO8YotKaZo0BtH68T5RA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=htYb7sr6bXuk8/biWoQ2AHhvWW1EZMe8nLkOVHeliuOUBx8kKGZEdUBUIfB4Q/yzf
 TQ28c4lstuiIv0o4P8Fx6h0mwOTbXmZ2y7UeHTDDVG4f7W3xr3mAwmX486ZANyX0UN
 rMEx/IUTXCGAVsPqlCT1jYwBIaUJVMrBVXeT9Q4c=
MIME-Version: 1.0
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From: Stephen Boyd <sboyd@kernel.org>
X-Patchwork-Hint: ignore
In-Reply-To: <20181205070046.GD31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
 <20181205070046.GD31204@localhost.localdomain>
Message-ID: <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Date: Wed, 05 Dec 2018 09:19:33 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_091944_704578_9D0B7722 
X-CRM114-Status: GOOD (  29.57  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, andrew.smirnov@gmail.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-04 23:00:46)
> Hello Stephen,
> 
> I copied some parts of the v4 discussion here as well. Let's continue
> them under this one email thread. (and yep, this is my bad we now have
> multiple email threads - I did these new patches without waiting for
> the final conclusion. I should try to be more patient in the future...)
> 
> > > > I think we should use parent device's node, not the paren node in DT,        
> > > > right? But I agree, we should only look "one level up in the chain".         
>                                                                                  
> > > Are these two things different? I'm suggesting looking at                      
> > > device_node::parent and trying to find a #clock-cells property.                
>                                                                                  
> > I thought that MFD sub-devices may completely lack the DT node but I
> > will verify this tomorrow.
> 
> So yep. It appears that the DT node for MFD sub-device is left NULL.
> This is quite logical as there really is no clk sub-node in MFD (pmic)
> node. The option to "hack around" this would be setting the of_node to
> parent node in driver code. But this feels wrong. Drivers should not
> mess with the "dt node ownership" - and it also feels a bit odd when
> many devices use same DT node. I think we may hit in problems when
> obtaining resources or doing reference counting. Hence I think we should
> keep the of_node NULL for sub-device if the sub-device does not have own
> node inside the main devie node. And I think Rob was not a fan of having
> own nodes for sub-devices inside the MFD node (AFAIR my first driver
> draft for this device had it but Rob and you thought that was not correct).

Yes let's not change this.

> > > @@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> > >   *
> > >   * Returns 0 on success or an errno on failure.
> > >   *
> > > - * Registers clock provider for given device's node. Provider is automatically
> > > - * released at device exit.
> > > + * Registers clock provider for given device's node. If the device has no DT
> > > + * node or if the device node lacks of clock provider information (#clock-cells)
> > > + * then the parent device's node is scanned for this information. If parent node
> > > + * has the #clock-cells then it is used in registration. Provider is
> > > + * automatically released at device exit.
> > >   */
> > >  int devm_of_clk_add_hw_provider(struct device *dev,
> > >                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > > @@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> > >         struct device_node **ptr, *np;
> > >         int ret;
> > >  
> > > +       np = dev->of_node;
> > > +
> > > +       if (!of_is_clk_provider(dev->of_node))
> > > +               if (of_is_clk_provider(dev->parent->of_node))
> > > +                       np = dev->parent->of_node;
> > 
> > As said on v5, let's just modify of_clk_add_provider() to do the parent
> > search.
> 
> But that won't solve the issue if we don't do "dirty hacks" in driver.
> The devm interface still only gets the device-pointer, not the DT node
> as argument. And if DT node for device is NULL (like in MFD cases) -
> then there is no parent node, only parent device with a node. For plain
> of_clk_add_provider() the driver can just give the parent's node pointer
> in cases where it knows it is the parent who has the provider data in
> DT. But our original problem is in devm interfaces.
> 

I was misunderstanding the MFD design. Should still work though, so I
squashed this into the patch to clean things up a bit. Does this work
for you?

------8<-----

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bb689161f0f5..6ff852bda892 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,9 +3893,23 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
-static int of_is_clk_provider(struct device_node *np)
+/*
+ * We allow a child device to use its parent device as the clock provider node
+ * for cases like MFD sub-devices where the child device driver wants to use
+ * devm_*() APIs but not list the device in DT as a sub-node.
+ */
+static struct device_node *get_clk_provider_node(struct device *dev)
 {
-	return !!of_find_property(np, "#clock-cells", NULL);
+	struct device_node *np, *parent_np;
+
+	np = dev->of_node;
+	parent_np = dev->parent ? dev->parent->of_node : NULL;
+
+	if (!of_find_property(np, "#clock-cells", NULL))
+		if (of_find_property(parent_np, "#clock-cells", NULL))
+			np = parent_np;
+
+	return np;
 }
 
 /**
@@ -3920,17 +3934,12 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	struct device_node **ptr, *np;
 	int ret;
 
-	np = dev->of_node;
-
-	if (!of_is_clk_provider(dev->of_node))
-		if (of_is_clk_provider(dev->parent->of_node))
-			np = dev->parent->of_node;
-
 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 
+	np = get_clk_provider_node(dev);
 	ret = of_clk_add_hw_provider(np, get, data);
 	if (!ret) {
 		*ptr = np;
@@ -3981,13 +3990,8 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
-	struct device_node *np;
-
-	np = dev->of_node;
+	struct device_node *np = get_clk_provider_node(dev);
 
-	if (!of_is_clk_provider(dev->of_node))
-		if (of_is_clk_provider(dev->parent->of_node))
-			np = dev->parent->of_node;
 	ret = devres_release(dev, devm_of_clk_release_provider,
 			     devm_clk_provider_match, np);
 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
