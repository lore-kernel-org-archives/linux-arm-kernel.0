Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:00:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3F9205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W099xtQj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="FVUqR9WU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3F9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PhKgDxmDYQMcCrRq2BruD2WTLUO70ZtesGbjByUfPxU=; b=W099xtQjdAM/ZL
	jbHXFArn1Hf0wgKOqQTkIlNwlwNUGRAob+fDqRD2OsYvZot3n35Oh1gw9YxFb2HRj16cgz+CtysD2
	9goPjxpfiMQsV30+eOWd6Igs2s6E+cYXQJqQ2YMzhf9jAzdMtKn77RkhmaFKFlnFtvQEfrV/ZvuCH
	Vki6h9kPy98R2AK0NpkY4KC+Z2OwAKCQX0MW4r7XCtNDxrLOqaFZs+k3YafJcPzyFkUp1+mEo1pMR
	LwJybDTxqEalEDc75jgokf+ujRu0Vtg0Df8D4vIeXc9QDE/mlj+5E+A63kf0f9H8fghhaAs4aZam6
	MyRomQ2J4mGMH2+/Ytgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1I7-0006Io-3I; Tue, 22 Jan 2019 19:00:55 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1I3-0006Ev-7q
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:00:53 +0000
Received: by mail-yb1-xb44.google.com with SMTP id a35so5257570ybi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3pzoLwjFOyfjRocTpsTdcEC8dm9cThmAzyf5ba6P5go=;
 b=FVUqR9WU+5cxA4Cj1qbohuj35y71lm2RPi4ziKJ3cHEfawVXPnORNudmF95T5wso5b
 s1ugGiCw24HTqJs8XAsXhWBaO0sXZy0DAXDyAaXy/rl9jm461T3vpE6vzC/JBMsloooT
 thlKdrbniEt5iBg077kp0phEP1TkYqQJ8l/gA3vvXSVMnprPqT7xSyFe9mTuhHQvOCJD
 rc4pSbCChmYOHuqHzKtWKirnxSiBppRsKt6VZGsDaaJlZuI52tZqokoYtul8SZmRo2Qm
 Vy43JpLQ0MpIoQqDNg95FvgKDgekHTHU0e3/NvoNbqc9bj4jYjzhXONGkI8KqIspbI9L
 L6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3pzoLwjFOyfjRocTpsTdcEC8dm9cThmAzyf5ba6P5go=;
 b=aiT3776wkcQekjVWQ4VxmdLqPXWhepwk8N2URHvQrMWc3v5UF6Bgpp6vTVHaxJsF+m
 ZAIqBKib5/KRikHgHDYQFCoYePz12Norxod8kX6o65c/UKZLxqR+CTn6IyEY3de0ZiAP
 c1rMSa5PMw0S3519hj0AWQufEyv7mDPoYZGu3y2QYBVVZAW9H6fbukts44lEgYdRKcWU
 B6BepoZ9ltUfiRjeisgv0418tRGboSRvsVed+WvotJIfthQIWW66G4/hWeB2acg80yn2
 DqXwVTwK7on2xNLq3wkz4WZE4HtnGgJ5yigoWOQtU88CXMjHvwSAqNWpZAu54pF2lKaR
 ErSA==
X-Gm-Message-State: AJcUukeDg+iDXLeBK2qEvru091SRQ7XLVyUMO5aM6myZMOGjdrGwlLPx
 nrNufiqRuykRErtxT00+EdKRF6nmmFkpZA==
X-Google-Smtp-Source: ALg8bN6p5o+DuUY9uoXi6x8fNB4G39HcbV0m9ZQe1CPCFqo6x2zmkKo/r9TCUEa39ME0gEKmlz9Iiw==
X-Received: by 2002:a25:416:: with SMTP id 22mr21611257ybe.334.1548183649418; 
 Tue, 22 Jan 2019 11:00:49 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
 by smtp.gmail.com with ESMTPSA id e124sm6841220ywf.17.2019.01.22.11.00.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 11:00:48 -0800 (PST)
Date: Tue, 22 Jan 2019 14:00:48 -0500
From: Sean Paul <sean@poorly.run>
To: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] drm/msm/dpu: Convert to a chained irq chip
Message-ID: <20190122190048.GE114153@art_vandelay>
References: <20190103190602.92612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103190602.92612-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_110051_350367_658A841B 
X-CRM114-Status: GOOD (  23.58  )
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
Cc: Jordan Crouse <jcrouse@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jayant Shekhar <jshekhar@codeaurora.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Jeykumar Sankaran <jsanka@codeaurora.org>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 11:06:02AM -0800, Stephen Boyd wrote:
> Devices that make up DPU, i.e. graphics card, request their interrupts
> from this "virtual" interrupt chip. The interrupt chip builds upon a GIC
> SPI interrupt that raises high when any of the interrupts in the DPU's
> irq status register are triggered. From the kernel's perspective this is
> a chained irq chip, so requesting a flow handler for the GIC SPI and
> then calling generic IRQ handling code from that irq handler is not
> completely proper. It's better to convert this to a chained irq so that
> the GIC SPI irq doesn't appear in /proc/interrupts, can't have CPU
> affinity changed, and won't be accounted for with irq stats. Doing this
> also silences a recursive lockdep warning because we can specify a
> different lock class for the chained interrupts, silencing a warning
> that is easy to see with 'threadirqs' on the kernel commandline.
> 
>  WARNING: inconsistent lock state
>  4.19.10 #76 Tainted: G        W
>  --------------------------------
>  inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>  irq/40-dpu_mdss/203 [HC0[0]:SC0[2]:HE1:SE0] takes:
>  0000000053ea9021 (&irq_desc_lock_class){?.-.}, at: handle_level_irq+0x34/0x26c
>  {IN-HARDIRQ-W} state was registered at:
>    lock_acquire+0x244/0x360
>    _raw_spin_lock+0x64/0xa0
>    handle_fasteoi_irq+0x54/0x2ec
>    generic_handle_irq+0x44/0x5c
>    __handle_domain_irq+0x9c/0x11c
>    gic_handle_irq+0x208/0x260
>    el1_irq+0xb4/0x130
>    arch_cpu_idle+0x178/0x3cc
>    default_idle_call+0x3c/0x54
>    do_idle+0x1a8/0x3dc
>    cpu_startup_entry+0x24/0x28
>    rest_init+0x240/0x270
>    start_kernel+0x5a8/0x6bc
>  irq event stamp: 18
>  hardirqs last  enabled at (17): [<ffffff9042385e80>] _raw_spin_unlock_irq+0x40/0xc0
>  hardirqs last disabled at (16): [<ffffff904237a1f4>] __schedule+0x20c/0x1bbc
>  softirqs last  enabled at (0): [<ffffff9040f318d0>] copy_process+0xb50/0x3964
>  softirqs last disabled at (18): [<ffffff9041036364>] local_bh_disable+0x8/0x20
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&irq_desc_lock_class);
>    <Interrupt>
>      lock(&irq_desc_lock_class);
> 
>   *** DEADLOCK ***
> 
>  no locks held by irq/40-dpu_mdss/203.
> 
>  stack backtrace:
>  CPU: 0 PID: 203 Comm: irq/40-dpu_mdss Tainted: G        W         4.19.10 #76
>  Call trace:
>   dump_backtrace+0x0/0x2f8
>   show_stack+0x20/0x2c
>   __dump_stack+0x20/0x28
>   dump_stack+0xcc/0x10c
>   mark_lock+0xbe0/0xe24
>   __lock_acquire+0x4cc/0x2708
>   lock_acquire+0x244/0x360
>   _raw_spin_lock+0x64/0xa0
>   handle_level_irq+0x34/0x26c
>   generic_handle_irq+0x44/0x5c
>   dpu_mdss_irq+0x64/0xec
>   irq_forced_thread_fn+0x58/0x9c
>   irq_thread+0x120/0x1dc
>   kthread+0x248/0x260
>   ret_from_fork+0x10/0x18
>  ------------[ cut here ]------------
>  irq 169 handler irq_default_primary_handler+0x0/0x18 enabled interrupts
> 
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Jayant Shekhar <jshekhar@codeaurora.org>
> Cc: Rajesh Yadav <ryadav@codeaurora.org>
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

LGTM, applied to dpu-staging.

Thanks,

Sean

> ---
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 36 ++++++++++++++----------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index cb307a2abf06..7316b4ab1b85 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -23,11 +23,14 @@ struct dpu_mdss {
>  	struct dpu_irq_controller irq_controller;
>  };
>  
> -static irqreturn_t dpu_mdss_irq(int irq, void *arg)
> +static void dpu_mdss_irq(struct irq_desc *desc)
>  {
> -	struct dpu_mdss *dpu_mdss = arg;
> +	struct dpu_mdss *dpu_mdss = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	u32 interrupts;
>  
> +	chained_irq_enter(chip, desc);
> +
>  	interrupts = readl_relaxed(dpu_mdss->mmio + HW_INTR_STATUS);
>  
>  	while (interrupts) {
> @@ -39,20 +42,20 @@ static irqreturn_t dpu_mdss_irq(int irq, void *arg)
>  					   hwirq);
>  		if (mapping == 0) {
>  			DRM_ERROR("couldn't find irq mapping for %lu\n", hwirq);
> -			return IRQ_NONE;
> +			break;
>  		}
>  
>  		rc = generic_handle_irq(mapping);
>  		if (rc < 0) {
>  			DRM_ERROR("handle irq fail: irq=%lu mapping=%u rc=%d\n",
>  				  hwirq, mapping, rc);
> -			return IRQ_NONE;
> +			break;
>  		}
>  
>  		interrupts &= ~(1 << hwirq);
>  	}
>  
> -	return IRQ_HANDLED;
> +	chained_irq_exit(chip, desc);
>  }
>  
>  static void dpu_mdss_irq_mask(struct irq_data *irqd)
> @@ -83,16 +86,16 @@ static struct irq_chip dpu_mdss_irq_chip = {
>  	.irq_unmask = dpu_mdss_irq_unmask,
>  };
>  
> +static struct lock_class_key dpu_mdss_lock_key, dpu_mdss_request_key;
> +
>  static int dpu_mdss_irqdomain_map(struct irq_domain *domain,
>  		unsigned int irq, irq_hw_number_t hwirq)
>  {
>  	struct dpu_mdss *dpu_mdss = domain->host_data;
> -	int ret;
>  
> +	irq_set_lockdep_class(irq, &dpu_mdss_lock_key, &dpu_mdss_request_key);
>  	irq_set_chip_and_handler(irq, &dpu_mdss_irq_chip, handle_level_irq);
> -	ret = irq_set_chip_data(irq, dpu_mdss);
> -
> -	return ret;
> +	return irq_set_chip_data(irq, dpu_mdss);
>  }
>  
>  static const struct irq_domain_ops dpu_mdss_irqdomain_ops = {
> @@ -159,11 +162,13 @@ static void dpu_mdss_destroy(struct drm_device *dev)
>  	struct msm_drm_private *priv = dev->dev_private;
>  	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
>  	struct dss_module_power *mp = &dpu_mdss->mp;
> +	int irq;
>  
>  	pm_runtime_suspend(dev->dev);
>  	pm_runtime_disable(dev->dev);
>  	_dpu_mdss_irq_domain_fini(dpu_mdss);
> -	free_irq(platform_get_irq(pdev, 0), dpu_mdss);
> +	irq = platform_get_irq(pdev, 0);
> +	irq_set_chained_handler_and_data(irq, NULL, NULL);
>  	msm_dss_put_clk(mp->clk_config, mp->num_clk);
>  	devm_kfree(&pdev->dev, mp->clk_config);
>  
> @@ -187,6 +192,7 @@ int dpu_mdss_init(struct drm_device *dev)
>  	struct dpu_mdss *dpu_mdss;
>  	struct dss_module_power *mp;
>  	int ret = 0;
> +	int irq;
>  
>  	dpu_mdss = devm_kzalloc(dev->dev, sizeof(*dpu_mdss), GFP_KERNEL);
>  	if (!dpu_mdss)
> @@ -219,12 +225,12 @@ int dpu_mdss_init(struct drm_device *dev)
>  	if (ret)
>  		goto irq_domain_error;
>  
> -	ret = request_irq(platform_get_irq(pdev, 0),
> -			dpu_mdss_irq, 0, "dpu_mdss_isr", dpu_mdss);
> -	if (ret) {
> -		DPU_ERROR("failed to init irq: %d\n", ret);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
>  		goto irq_error;
> -	}
> +
> +	irq_set_chained_handler_and_data(irq, dpu_mdss_irq,
> +					 dpu_mdss);
>  
>  	pm_runtime_enable(dev->dev);
>  
> -- 
> Sent by a computer through tubes
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
