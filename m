Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91EFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:15:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EA22081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q8XJbCX2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZvA15MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EA22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a7jVEN65A4bX5bptArLP2ursV7bke+0PviIb1bFrEkg=; b=q8XJbCX2CAsux8
	hFs2XmRem1sX4O5YLV4ZM0NVZAuiygQxcBZPZY2idT4Am48ILj3pxLoSmsGM5vkQghrWjsjJSjmAD
	eLOF3BS/Qcf6FFb8dnQUlSCNz7yV5dMz3QtdYfgYqfVTkq/I90q9PERKekaWBLcPH3FPtjbjJ9h7P
	tk9JlsYhjR2WNm2XvPqclJASzXN5iaDNuU8wH+K6kc4sZLR++to7eHzwhG15njMKG9k++qEq+CeRc
	w+l/+iGd94qLBsrIFgtId09arW+LilvsJLnfquIP2CbbOehH/6EEmWXORj3LJeT+U8MPOl5Xzx114
	cHVJnEyUYk6wvpO+Rz7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlcb-0005PZ-M9; Tue, 11 Dec 2018 17:15:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlal-0003es-TH
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:13:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC43D2081B;
 Tue, 11 Dec 2018 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544548377;
 bh=GgCwKH/uEcw2pvZtG4f1Du5M6HKQEqDvBq9+YhBSbcM=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=MZvA15MJTH99gywPOSHC/hjS+4mJ+eZA7uW6/dlINdlJjnJPBnn+f32XGOJ6OXTy/
 si7RCFaZ9WXqXiR6Rao2D9nj2UEIBGGZUdvZ0Oz/+dJl+LjCtnbrV6POeefceIVU5j
 X7GggpT5hGLyoh8knH0l2kmholIR493G6X2pKfzg=
MIME-Version: 1.0
In-Reply-To: <20181204192440.12125-3-miquel.raynal@bootlin.com>
Message-ID: <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 2/4] clk: core: link consumer with clock driver
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-3-miquel.raynal@bootlin.com>
Date: Tue, 11 Dec 2018 09:12:55 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_091308_689426_2A8D3426 
X-CRM114-Status: GOOD (  21.41  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sorry, I'm not reviewing the whole patch right now, just this one little
bit because I'm also working in the same area.

Quoting Miquel Raynal (2018-12-04 11:24:38)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 60c51871b04b..721d6b55b2fa 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -781,6 +781,8 @@ void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
>  const char *__clk_get_name(const struct clk *clk);
>  const char *clk_hw_get_name(const struct clk_hw *hw);
>  struct clk_hw *__clk_get_hw(struct clk *clk);
> +void clk_link_consumer(struct device *consumer, struct clk *clk);
> +void clk_unlink_consumer(struct clk *clk);

We shouldn't need to add these functions as far as I can tell. That's
because __clk_get() has become an internal API between clkdev.c and
clk.c that does nothing now on implementations that aren't the CCF. We
can even change this API to take a clk_hw pointer instead of a clk
pointer.

I'd rather see us plumb a struct device and clk_hw structure down into
__clk_get() and fold it all into __clk_create_clk, possibly even
renaming __clk_create_clk to clk_hw_create_clk(). That way we can get
the calling device and clk_hw pointer in one call in the clk framework,
along with the device name and connection name, and then generate the
struct clk right there. This can simplify some code and make it easier
to extend this to associate calling devices with the clk consumer
somehow.

Here's the diff. With this, you should be able to add and remove device
links in clk_hw_create_clk() when dev != NULL.

----8<----

 drivers/clk/clk.c    | 57 +++++++++++++++++++++++-----------------------------
 drivers/clk/clk.h    | 12 +++++------
 drivers/clk/clkdev.c | 43 ++++++++++++++++++++-------------------
 3 files changed, 53 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..684f9a4b7d65 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3202,10 +3202,11 @@ static int __clk_core_init(struct clk_core *core)
 	return ret;
 }
 
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id)
+struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
+			      const char *dev_id, const char *con_id)
 {
 	struct clk *clk;
+	struct clk_core *core;
 
 	/* This is to allow this function to be chained to others */
 	if (IS_ERR_OR_NULL(hw))
@@ -3215,15 +3216,23 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
 
-	clk->core = hw->core;
+	core = hw->core;
+	clk->core = core;
 	clk->dev_id = dev_id;
 	clk->con_id = kstrdup_const(con_id, GFP_KERNEL);
 	clk->max_rate = ULONG_MAX;
 
 	clk_prepare_lock();
-	hlist_add_head(&clk->clks_node, &hw->core->clks);
+	hlist_add_head(&clk->clks_node, &core->clks);
 	clk_prepare_unlock();
 
+	if (!try_module_get(core->owner)) {
+		kfree(clk);
+		return ERR_PTR(-ENOENT);
+	}
+
+	kref_get(&core->ref);
+
 	return clk;
 }
 
@@ -3313,7 +3322,11 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 
 	INIT_HLIST_HEAD(&core->clks);
 
-	hw->clk = __clk_create_clk(hw, NULL, NULL);
+	/*
+	 * Pass NULL here for device because we eventually plan
+	 * to get rid of this clk created here
+	 */
+	hw->clk = clk_hw_create_clk(NULL, hw, NULL, NULL);
 	if (IS_ERR(hw->clk)) {
 		ret = PTR_ERR(hw->clk);
 		goto fail_parents;
@@ -3594,18 +3607,6 @@ EXPORT_SYMBOL_GPL(devm_clk_hw_unregister);
 /*
  * clkdev helpers
  */
-int __clk_get(struct clk *clk)
-{
-	struct clk_core *core = !clk ? NULL : clk->core;
-
-	if (core) {
-		if (!try_module_get(core->owner))
-			return 0;
-
-		kref_get(&core->ref);
-	}
-	return 1;
-}
 
 /* keep in sync with __clk_free_clk */
 void __clk_put(struct clk *clk)
@@ -3976,12 +3977,12 @@ __of_clk_get_hw_from_provider(struct of_clk_provider *provider,
 	return __clk_get_hw(clk);
 }
 
-struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
+struct clk *__of_clk_get_from_provider(struct device *dev,
+				       struct of_phandle_args *clkspec,
 				       const char *dev_id, const char *con_id)
 {
 	struct of_clk_provider *provider;
-	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
-	struct clk_hw *hw;
+	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);
 
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
@@ -3991,21 +3992,13 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
 			hw = __of_clk_get_hw_from_provider(provider, clkspec);
-			clk = __clk_create_clk(hw, dev_id, con_id);
-		}
-
-		if (!IS_ERR(clk)) {
-			if (!__clk_get(clk)) {
-				__clk_free_clk(clk);
-				clk = ERR_PTR(-ENOENT);
-			}
-
-			break;
+			if (!IS_ERR(hw))
+				break;
 		}
 	}
 	mutex_unlock(&of_clk_mutex);
 
-	return clk;
+	return clk_hw_create_clk(dev, hw, dev_id, con_id);
 }
 
 /**
@@ -4018,7 +4011,7 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
  */
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
-	return __of_clk_get_from_provider(clkspec, NULL, __func__);
+	return __of_clk_get_from_provider(NULL, clkspec, NULL, __func__);
 }
 EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
 
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 70c0ba6336c1..a0d4aa0fcfcd 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -12,20 +12,21 @@
 struct clk_hw;
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
+struct clk *__of_clk_get_from_provider(struct device *dev,
+				       struct of_phandle_args *clkspec,
 				       const char *dev_id, const char *con_id);
 #endif
 
 #ifdef CONFIG_COMMON_CLK
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id);
+struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
+			      const char *dev_id, const char *con_id);
 void __clk_free_clk(struct clk *clk);
-int __clk_get(struct clk *clk);
 void __clk_put(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
-__clk_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id)
+clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
+		  const char *con_id)
 {
 	return (struct clk *)hw;
 }
@@ -34,7 +35,6 @@ static struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return (struct clk_hw *)clk;
 }
-static inline int __clk_get(struct clk *clk) { return 1; }
 static inline void __clk_put(struct clk *clk) { }
 
 #endif
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..08cf01c168fb 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -28,8 +28,9 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-static struct clk *__of_clk_get(struct device_node *np, int index,
-			       const char *dev_id, const char *con_id)
+static struct clk *__of_clk_get(struct device *dev, struct device_node *np,
+				int index, const char *dev_id,
+				const char *con_id)
 {
 	struct of_phandle_args clkspec;
 	struct clk *clk;
@@ -40,7 +41,7 @@ static struct clk *__of_clk_get(struct device_node *np, int index,
 	if (rc)
 		return ERR_PTR(rc);
 
-	clk = __of_clk_get_from_provider(&clkspec, dev_id, con_id);
+	clk = __of_clk_get_from_provider(dev, &clkspec, dev_id, con_id);
 	of_node_put(clkspec.np);
 
 	return clk;
@@ -48,13 +49,13 @@ static struct clk *__of_clk_get(struct device_node *np, int index,
 
 struct clk *of_clk_get(struct device_node *np, int index)
 {
-	return __of_clk_get(np, index, np->full_name, NULL);
+	return __of_clk_get(NULL, np, index, np->full_name, NULL);
 }
 EXPORT_SYMBOL(of_clk_get);
 
-static struct clk *__of_clk_get_by_name(struct device_node *np,
-					const char *dev_id,
-					const char *name)
+static struct clk *__of_clk_get_by_name(struct device *dev,
+					struct device_node *np,
+					const char *dev_id, const char *name)
 {
 	struct clk *clk = ERR_PTR(-ENOENT);
 
@@ -69,7 +70,7 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		 */
 		if (name)
 			index = of_property_match_string(np, "clock-names", name);
-		clk = __of_clk_get(np, index, dev_id, name);
+		clk = __of_clk_get(dev, np, index, dev_id, name);
 		if (!IS_ERR(clk)) {
 			break;
 		} else if (name && index >= 0) {
@@ -106,13 +107,14 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 	if (!np)
 		return ERR_PTR(-ENOENT);
 
-	return __of_clk_get_by_name(np, np->full_name, name);
+	return __of_clk_get_by_name(NULL, np, np->full_name, name);
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
 
 #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
 
-static struct clk *__of_clk_get_by_name(struct device_node *np,
+static struct clk *__of_clk_get_by_name(struct device *dev,
+					struct device_node *np,
 					const char *dev_id,
 					const char *name)
 {
@@ -163,7 +165,8 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 	return cl;
 }
 
-struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+static struct clk *__clk_get_sys(struct device *dev, const char *dev_id,
+				 const char *con_id)
 {
 	struct clk_lookup *cl;
 	struct clk *clk = NULL;
@@ -174,21 +177,19 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 	if (!cl)
 		goto out;
 
-	clk = __clk_create_clk(cl->clk_hw, dev_id, con_id);
+	clk = clk_hw_create_clk(dev, cl->clk_hw, dev_id, con_id);
 	if (IS_ERR(clk))
-		goto out;
-
-	if (!__clk_get(clk)) {
-		__clk_free_clk(clk);
 		cl = NULL;
-		goto out;
-	}
-
 out:
 	mutex_unlock(&clocks_mutex);
 
 	return cl ? clk : ERR_PTR(-ENOENT);
 }
+
+struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+{
+	return __clk_get_sys(NULL, dev_id, con_id);
+}
 EXPORT_SYMBOL(clk_get_sys);
 
 struct clk *clk_get(struct device *dev, const char *con_id)
@@ -197,12 +198,12 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+		clk = __of_clk_get_by_name(dev, dev->of_node, dev_id, con_id);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
 
-	return clk_get_sys(dev_id, con_id);
+	return __clk_get_sys(dev, dev_id, con_id);
 }
 EXPORT_SYMBOL(clk_get);
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
