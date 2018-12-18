Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D900BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E91A218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RSi8NSqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E91A218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RqeBuKEo+va2k7kf1180qjWTEyDIfuc4tnQ49Ju+P2o=; b=RSi8NSqClFspFH
	O7Xjz62Ty8xblSu7owRN2WMtUYTSdGzAX6+FutDobjMyC5xcYPp2uNLPt/wWKl6d4tD2hjyUMUt9x
	iAwN0khVSOROn5CU+8B6QJnBOIRuj97a9CkGuU8sS8WPhZmAeUM39WiBueLrXZPoaU1a/EN6+Rxs8
	z2wVrEbYP0BdRAS6knQbDyT/U33WJS+K3Psc1FKStmqYobkTyNYWAPEvvRuCnFER/6qxjB+kemiOv
	s9oIB/HwToGhlsTOSjD5oJoz5fgEgg4uNCB4MWpRg8x+2sy6qPlGbvb+Xtps3ZnPl03C255JEkeAZ
	oyOWMMY3+4xdc0kpi8Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZH9a-0000Th-I5; Tue, 18 Dec 2018 15:19:26 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZH9W-0000QH-B5
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:19:24 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id AF237CA2C1;
 Tue, 18 Dec 2018 16:19:03 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id TLZllIyIoEXR; Tue, 18 Dec 2018 16:19:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 5255ACA2C2;
 Tue, 18 Dec 2018 16:19:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id dyE3bnz5jnAI; Tue, 18 Dec 2018 16:18:59 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 94594CA2C1;
 Tue, 18 Dec 2018 16:18:59 +0100 (CET)
Message-ID: <77130e281e078315d346d54b731c578c68f2ff04.camel@v3.sk>
Subject: Re: [PATCH 2/3] drm/armada: add OF reserved memory support
From: Lubomir Rintel <lkundrak@v3.sk>
To: Russell King <rmk+kernel@armlinux.org.uk>
Date: Tue, 18 Dec 2018 16:18:58 +0100
In-Reply-To: <E1fcpoh-0003Z2-BB@rmk-PC.armlinux.org.uk>
References: <20180710102344.GH17271@n2100.armlinux.org.uk>
 <E1fcpoh-0003Z2-BB@rmk-PC.armlinux.org.uk>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_071922_697638_2C46EA33 
X-CRM114-Status: GOOD (  18.82  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-07-10 at 11:24 +0100, Russell King wrote:
> Existing Armada DRM makes use of reserved memory for allocating
> contiguous screen buffers, which currently prevents its use with
> DT systems.  Add support for this for DT systems.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/armada/Makefile      |  3 +++
>  drivers/gpu/drm/armada/armada_drv.c  | 24 ++++++++++++++++--
>  drivers/gpu/drm/armada/armada_rmem.c | 49
> ++++++++++++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/armada/armada_rmem.c
> 
> diff --git a/drivers/gpu/drm/armada/Makefile
> b/drivers/gpu/drm/armada/Makefile
> index ecf25cf9f9f5..0b8bf3b8aa6a 100644
> --- a/drivers/gpu/drm/armada/Makefile
> +++ b/drivers/gpu/drm/armada/Makefile
> @@ -5,3 +5,6 @@ armada-y	+= armada_510.o
>  armada-$(CONFIG_DEBUG_FS) += armada_debugfs.o
>  
>  obj-$(CONFIG_DRM_ARMADA) := armada.o
> +
> +armada-rmem-$(CONFIG_DRM_ARMADA) += armada_rmem.o
> +obj-y += $(armada-rmem-y) $(armada-rmem-m)
> diff --git a/drivers/gpu/drm/armada/armada_drv.c
> b/drivers/gpu/drm/armada/armada_drv.c
> index 217f0590fd61..a9ee492a2810 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -9,6 +9,7 @@
>  #include <linux/component.h>
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
> +#include <linux/of_reserved_mem.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_of.h>
> @@ -96,6 +97,9 @@ static int armada_drm_bind(struct device *dev)
>  			return -EINVAL;
>  	}
>  
> +	if (!mem && dev->of_node)
> +		mem = dev->platform_data;
> +
>  	if (!mem)
>  		return -ENXIO;
>  
> @@ -250,9 +254,17 @@ static int armada_drm_probe(struct
> platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	ret = drm_of_component_probe(dev, compare_dev_name,
> &armada_master_ops);
> -	if (ret != -EINVAL)
> +	if (dev->of_node) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret && ret != -ENODEV)
> +			return ret;
> +
> +		ret = drm_of_component_probe(dev, compare_of,
> +					     &armada_master_ops);
> +		if (ret)
> +			of_reserved_mem_device_release(dev);
>  		return ret;
> +	}
>  
>  	if (dev->platform_data) {
>  		char **devices = dev->platform_data;
> @@ -287,6 +299,7 @@ static int armada_drm_probe(struct
> platform_device *pdev)
>  static int armada_drm_remove(struct platform_device *pdev)
>  {
>  	component_master_del(&pdev->dev, &armada_master_ops);
> +	of_reserved_mem_device_release(&pdev->dev);
>  	return 0;
>  }
>  
> @@ -300,11 +313,18 @@ static const struct platform_device_id
> armada_drm_platform_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, armada_drm_platform_ids);
>  
> +static const struct of_device_id armada_drm_dt_ids[] = {
> +	{ .compatible = "marvell,dove-display-subsystem", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, armada_drm_dt_ids);
> +
>  static struct platform_driver armada_drm_platform_driver = {
>  	.probe	= armada_drm_probe,
>  	.remove	= armada_drm_remove,
>  	.driver	= {
>  		.name	= "armada-drm",
> +		.of_match_table = armada_drm_dt_ids,
>  	},
>  	.id_table = armada_drm_platform_ids,
>  };
> diff --git a/drivers/gpu/drm/armada/armada_rmem.c
> b/drivers/gpu/drm/armada/armada_rmem.c
> new file mode 100644
> index 000000000000..36bb20e426b6
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_rmem.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2017 Russell King
> +#include <linux/errno.h>
> +#include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/slab.h>
> +
> +static int armada_rmem_dev_init(struct reserved_mem *rmem, struct
> device *dev)
> +{
> +	struct resource *r;
> +
> +	if (dev->platform_data)
> +		return -EBUSY;
> +
> +	r = kzalloc(sizeof(*r), GFP_KERNEL);
> +	if (!r)
> +		return -ENOMEM;
> +
> +	r->start = rmem->base;
> +	r->end = rmem->base + rmem->size - 1;
> +	r->flags = IORESOURCE_MEM;
> +
> +	rmem->priv = r;
> +	dev->platform_data = r;
> +
> +	return 0;
> +}
> +
> +static void armada_rmem_dev_release(struct reserved_mem *rmem,
> +	struct device *dev)
> +{
> +	kfree(rmem->priv);
> +	rmem->priv = NULL;
> +	dev->platform_data = NULL;
> +}
> +
> +static const struct reserved_mem_ops armada_rmem_ops = {
> +	.device_init = armada_rmem_dev_init,
> +	.device_release = armada_rmem_dev_release,
> +};
> +
> +static int __init armada_rmem_init(struct reserved_mem *rmem)
> +{
> +	rmem->ops = &armada_rmem_ops;
> +	return 0;
> +}
> +
> +RESERVEDMEM_OF_DECLARE(armada_rmem, "marvell,dove-framebuffer",
> +			armada_rmem_init);

Hi,

wouldn't "marvell,armada-framebuffer" make more sense here?
The driver will do just well for MMP2 and perhaps more hardware that is
not Dove; the DTs could just say:

compatible = "marvell,dove-framebuffer", "marvell,armada-framebuffer";
compatible = "marvell,mmp2-framebuffer", "marvell,armada-framebuffer";

Lubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
