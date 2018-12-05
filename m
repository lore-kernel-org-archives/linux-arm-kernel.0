Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60BC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:02:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37BF2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y5HFBCyK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fPRfJWgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37BF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ns7Yd5CCjZrXSqFj8slaXmamXGso8ypoyiFg2J4Desk=; b=Y5HFBCyKiFUdYh
	pgLweGnU7etP53y7lLq8fga/FTtOvPj26/jis93+akVKD/gsSQL/83AZxdRD+VwEh+NjgkjKAF73C
	yKd/uVIIe42A9uMFGNN9Sd3VfdbB2bmKZI1CaaHBzulDJSrlLtCpR1FZNbB49SQ/BftEQKXKkZcyS
	QYaubfQT+SkX3kAb0CwID/cohlfhagxqZoJfEkKqZZnN/C/1VUfnJ6LHwT8//bIrUSUmwyngYHbet
	9IkyHYd4l4M04zJPKyOTc5L5iMbxxEMRFjT7Ur/fx/PnjgTLnWtqQBcLvS1XfZJ9TEB8CAB+IBjNP
	Y+BRDYVP/TlxwoNlK3sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNRh-00061V-KN; Wed, 05 Dec 2018 03:01:53 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNRe-000606-J8
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:01:52 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so8307375pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 19:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aEyY2esnyy3IdaqIe/pCkfAfBQQ+yS1skDDXIsiASBg=;
 b=fPRfJWgH91RF32pw2dmnn27m3zpx6owVHFQui45eJMX1jMGAhSBZ0fsJyzhg5DH9lM
 DyHrpAy+ec2vsjZsS9x22FKyxGzEenc/U0an3poJ5J0LOiofAWJQFyN7mEwX1wFB0pbS
 o8j6kXn9NK3Lg8xZ5cpUpTXWPQmbFX4bhNlDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aEyY2esnyy3IdaqIe/pCkfAfBQQ+yS1skDDXIsiASBg=;
 b=c9ZuJh2/LsOGTDxrOCI0j49ASico9BPaBKaapotIFvEL4wBBNmTYiyZu5W6yChrfEC
 An/7KUHXHb60/lukmyyglxmHFm8pA7ohtLLHn3S59dEfcwDyAgPcr20lGJBvllqjtCbz
 jVWn17fvLabtfdJUE+AhVC6r8YDcY7Z6qi1apCst4dRvWiJXwoQNFK6Y2F/s1uIKU6Lz
 OThRDHmDlhaY/gk6wHRHIFB4eMl8iasIrul83CEBL+cKAb5yhLYD5ohYszhLYBa2IV5e
 2/gu09oayG9p1MJdo79FeYn5QPQGmRq8cqschAlAm5LQpBFgYTqtGYiHsK64WnbbJ288
 e7og==
X-Gm-Message-State: AA+aEWayucZbggZ2VQKQNDJo45lQPgHLciXNbyloCpO4qDAUPSZyoC97
 1rXPd1q7QRBl36W8JtGEPTheKg==
X-Google-Smtp-Source: AFSGD/XSwmlai3435j4LMDh4RpazXp5z1sB/LeQV8MEZzzAu7rcB2THMXvd5e9HxJlcCOVzSeUu4QA==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr18603161pfh.228.1543978899435; 
 Tue, 04 Dec 2018 19:01:39 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id l64sm22327815pge.73.2018.12.04.19.01.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 19:01:37 -0800 (PST)
Date: Tue, 4 Dec 2018 19:01:34 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Message-ID: <20181205030127.GA200921@google.com>
References: <20180805124807.18169-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180805124807.18169-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_190150_632469_2D8433EB 
X-CRM114-Status: GOOD (  24.16  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ others

Hi,

On Sun, Aug 05, 2018 at 01:48:07PM +0100, Marc Zyngier wrote:
> Leaving the DRM driver enabled on reboot or kexec has the annoying
> effect of leaving the display generating transactions whilst the
> IOMMU has been shut down.
> 
> In turn, the IOMMU driver (which shares its interrupt line with
> the VOP) starts warning either on shutdown or when entering the
> secondary kernel in the kexec case (nothing is expected on that
> front).
> 
> A cheap way of ensuring that things are nicely shut down is to
> register a shutdown callback in the platform driver.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

This patch made it into 4.20-rc1 as well as -stable, and it has caused
regressions for me, on the Kevin and Scarlet [1] RK3399 platforms. On
shutdown/reboot, I see this:

[   94.742559] WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x294
...
[   94.775904] CPU: 4 PID: 2035 Comm: reboot Tainted: G        W         4.20.0-rc5+ #83
[   94.784651] Hardware name: Google Scarlet (DT)
[   94.789611] pstate: 20000005 (nzCv daif -PAN -UAO)
[   94.794959] pc : drm_mode_config_cleanup+0x1c4/0x294
[   94.800500] lr : drm_mode_config_cleanup+0x108/0x294
...
[   94.898683] Call trace:
[   94.901410]  drm_mode_config_cleanup+0x1c4/0x294
[   94.906565]  rockchip_drm_unbind+0x4c/0x8c
[   94.911138]  component_master_del+0x88/0xb8
[   94.915807]  rockchip_drm_platform_remove+0x2c/0x44
[   94.921243]  rockchip_drm_platform_shutdown+0x20/0x2c
[   94.926881]  platform_drv_shutdown+0x2c/0x38
[   94.931647]  device_shutdown+0x164/0x1b8
[   94.936016]  kernel_restart_prepare+0x40/0x48
[   94.940878]  kernel_restart+0x20/0x68
[   94.944964]  __se_sys_reboot+0x1ac/0x204
[   94.949331]  __arm64_sys_reboot+0x2c/0x38
[   94.953806]  el0_svc_common+0xa4/0xec
[   94.957891]  el0_svc_compat_handler+0x30/0x3c
[   94.962753]  el0_svc_compat+0x8/0x18
[   94.966740] ---[ end trace b9ba2e701f4fb233 ]---
[   95.255169] Memory manager not clean during takedown.
[   95.260824] WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mm.c:950 drm_mm_takedown+0x34/0x44
...
[   95.292314] CPU: 4 PID: 2035 Comm: reboot Tainted: G        W         4.20.0-rc5+ #83
[   95.301061] Hardware name: Google Scarlet (DT)
[   95.306020] pstate: 60000005 (nZCv daif -PAN -UAO)
[   95.311369] pc : drm_mm_takedown+0x34/0x44
[   95.315940] lr : drm_mm_takedown+0x34/0x44
...
[   95.415857]  drm_mm_takedown+0x34/0x44
[   95.420042]  rockchip_drm_unbind+0x64/0x8c
[   95.424613]  component_master_del+0x88/0xb8
[   95.429283]  rockchip_drm_platform_remove+0x2c/0x44
[   95.434728]  rockchip_drm_platform_shutdown+0x20/0x2c
[   95.440360]  platform_drv_shutdown+0x2c/0x38
[   95.445127]  device_shutdown+0x164/0x1b8
[   95.449504]  kernel_restart_prepare+0x40/0x48
[   95.454358]  kernel_restart+0x20/0x68
[   95.458436]  __se_sys_reboot+0x1ac/0x204
[   95.462812]  __arm64_sys_reboot+0x2c/0x38
[   95.467287]  el0_svc_common+0xa4/0xec
[   95.471373]  el0_svc_compat_handler+0x30/0x3c
[   95.476235]  el0_svc_compat+0x8/0x18
[   95.480215] ---[ end trace b9ba2e701f4fb234 ]---

It's especially bad on -stable kernels, where I believe the remove()
paths were even worse. This triggers a variety of OOPSes, and it's not
clear if those are simply because of backports (e.g., RK3399 did not
have support in 4.4.y, but our downstream has merged all sorts of
backports to make it work).

Anyway, the above warnings occur on v4.20-rc, which I think is
justification enough for a revert.

I plan to submit a revert which I hope can go to 4.20 as well as
-stable. I'd hope the remove()/shutdown() paths should be fixed before
this gets applied again, and that it does not get shipped to -stable
kernels.

Brian

[1] Technically Scarlet needed a few patches from -next to work at all,
    but Kevin is a similar platform that has been working for several
    releases.

>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index f814d37b1db2..05368fa4f956 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -442,6 +442,11 @@ static int rockchip_drm_platform_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
> +{
> +	rockchip_drm_platform_remove(pdev);
> +}
> +
>  static const struct of_device_id rockchip_drm_dt_ids[] = {
>  	{ .compatible = "rockchip,display-subsystem", },
>  	{ /* sentinel */ },
> @@ -451,6 +456,7 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_ids);
>  static struct platform_driver rockchip_drm_platform_driver = {
>  	.probe = rockchip_drm_platform_probe,
>  	.remove = rockchip_drm_platform_remove,
> +	.shutdown = rockchip_drm_platform_shutdown,
>  	.driver = {
>  		.name = "rockchip-drm",
>  		.of_match_table = rockchip_drm_dt_ids,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
