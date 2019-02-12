Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983ACC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:06:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69323217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4ZcqBgF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="0rVmao9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69323217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Ab5eNmI1CLbJdLgXe+oR9hFM43sLTOjFDAo+hOFwAY=; b=a4ZcqBgF35kAGQ
	3ofh7nT6OPW1WmurEeE/iMSzbEW+WBUnrwN5Y8/xw+uEICt+q+BvtXDI31ese/8e1d+dvOaND3Jsc
	sHRR5Wmem2pv+hYCs75iSRGJfzQgm5FL8h8ilFfi7Vv0BViVsQobZN4HTUFz3KeuNfvutXFrfMCPP
	GKpaxt7j5zIftxHH2wId7YFNupCuIRux5ZnSn9b720lDKzm7xNh362P878p37hfWbR4E352cdmNwe
	/cVVIHoKZUQOSl/HOKirHDh3L6ru/liv5AJDgUvjN0iOfXgYHmZfFIfgKoLmUExwQeKW0wdvOACc6
	0wB8V4TAujEma0JqV66g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVtu-0000Wv-Bn; Tue, 12 Feb 2019 11:06:54 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVtq-0000WO-UW
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:06:52 +0000
Received: by mail-yw1-xc43.google.com with SMTP id k188so837789ywa.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ettus-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ffgy+Ihrxny8kltfexYOi745w+fb3oVxQWzVL3oOP9k=;
 b=0rVmao9wjojW97L0JyB1CRZQYB382Nv6OJZ6Hw8W+vgzZKTfoPf1lExpUyjzRWV/GW
 JBIdb8QmpLP2YTQqm7kl2tjqmwclKlAbyxcklZzOpSB9yrFnGIZp41XqvBg8vfM29vx4
 +8QnnAXMV91TuRez2zPNtFwGDLT1Gu/xGDHZzMsljDYilbXKKHx3bcwC64cfVITQa4NB
 aqK1ffpNugNzNM0sKpJ5bcGtHxMbxUZJx2ViELtsExglBYoUGFONkeIwNzAhraYf9bSQ
 Hw+nGS5IIizjTiJB5pTW2iHl4x9G70Iw+rEtdzDbKWak2T9rVO8ibZMYjfRQyBlVxJWt
 qTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ffgy+Ihrxny8kltfexYOi745w+fb3oVxQWzVL3oOP9k=;
 b=rnWkf6QbX2Puj0/aNRNiGgx3YnxQm0jchvacAW9ueKvSAzay3YrECf3j5FQ6dJauR8
 n0xx9OaUITuCD4iMysq3mCOjiKFxs3copwX9fH364rkY/YMHogss+20x4CJdBih/ZeFZ
 TTL7hdN7Ij7ZBEbUCqsPDA/GvoAh/SNMhpaMAaMcbsTtFBkxl7bz6zacSWBpIhwRxdlG
 j26AlGhNfFWdvclO577PkubbFLJn1ZG78cZ63c3JUPZ+MV3xGIdJUN8np8pYebfWcMZc
 sRARyaJy/jcj5ZsnYrrCuV00ZIF223mRtLe6vf9E9QGRHOQO4Y4l0X/0nfZrdGENm1xh
 19hQ==
X-Gm-Message-State: AHQUAuYrPbIrCFuvILSTwMz/q8BeuPR3O5UJ0MeRuOcVWtZyMOAOycaE
 VWyLQj9vzU45mrpnS04Z0Czgf2Jt5xr0UuNpTefqq0J0tX8=
X-Google-Smtp-Source: AHgI3IYdzGGESEnOzCcb7tU5rJKvckQGtvsiEQNfTQ43mQKpOcn/sNYhobNL+BBn8gCEXuzE36ecJ5z5bMP8lEZCfpg=
X-Received: by 2002:a81:3a8d:: with SMTP id h135mr2318008ywa.391.1549969609779; 
 Tue, 12 Feb 2019 03:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20190211161754.23902-1-nava.manne@xilinx.com>
In-Reply-To: <20190211161754.23902-1-nava.manne@xilinx.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Tue, 12 Feb 2019 03:06:38 -0800
Message-ID: <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To: Nava kishore Manne <nava.manne@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_030650_982624_FB779EE3 
X-CRM114-Status: GOOD (  23.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Devicetree List <devicetree@vger.kernel.org>, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jolly Shah <jollys@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Nava,

On Sun, Feb 10, 2019 at 8:17 AM Nava kishore Manne
<nava.manne@xilinx.com> wrote:
>
> This patch adds FPGA Manager support for the Xilinx
> ZynqMP chip.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
>                 -Created patches on top of 5.0-rc5.
>                  No functional changes.
> Changes for v2:
>                 -Fixed some minor coding issues as suggested by
>                  Moritz
>
> Changes for v1:
>                 -None.
>
> Changes for RFC-V2:
>                 -Updated the Fpga Mgr registrations call's
>                  to 4.18
>
>  drivers/fpga/Kconfig       |   9 +++
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/zynqmp-fpga.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 drivers/fpga/zynqmp-fpga.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0bb7b5c..9f17203 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -204,4 +204,13 @@ config FPGA_DFL_PCI
>
>           To compile this as a module, choose M here.
>
> +config FPGA_MGR_ZYNQMP_FPGA
> +       tristate "Xilinx ZynqMP FPGA"
> +       depends on ARCH_ZYNQMP || COMPILE_TEST
> +       help
> +         FPGA manager driver support for Xilinx ZynqMP FPGAs.
> +         This driver uses the processor configuration port(PCAP)
> +         to configure the programmable logic(PL) through PS
> +         on ZynqMP SoC.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index c0dd4c8..312b937 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)  += stratix10-soc.o
>  obj-$(CONFIG_FPGA_MGR_TS73XX)          += ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)      += xilinx-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     += zynqmp-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> new file mode 100644
> index 0000000..f40c3bb
> --- /dev/null
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Xilinx, Inc.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/string.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +/* Constant Definitions */
> +#define IXR_FPGA_DONE_MASK     0X00000008U
> +
> +/**
> + * struct zynqmp_fpga_priv - Private data structure
> + * @dev:       Device data structure
> + * @flags:     flags which is used to identify the bitfile type
> + */
> +struct zynqmp_fpga_priv {
> +       struct device *dev;
> +       u32 flags;
> +};
> +
> +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
> +                                     struct fpga_image_info *info,
> +                                     const char *buf, size_t size)
> +{
> +       struct zynqmp_fpga_priv *priv;
> +
> +       priv = mgr->priv;
> +       priv->flags = info->flags;
> +
> +       return 0;
> +}
> +
> +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> +                                const char *buf, size_t size)
> +{
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +       struct zynqmp_fpga_priv *priv;
> +       dma_addr_t dma_addr;
> +       u32 eemi_flags = 0;
> +       char *kbuf;
> +       int ret;
> +
> +       if (!eemi_ops || !eemi_ops->fpga_load)
> +               return -ENXIO;
> +
> +       priv = mgr->priv;
> +
> +       kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
> +       if (!kbuf)
> +               return -ENOMEM;
> +
> +       memcpy(kbuf, buf, size);
> +
> +       wmb(); /* ensure all writes are done before initiate FW call */
> +
> +       if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
> +               eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
> +
> +       ret = eemi_ops->fpga_load(dma_addr, size, eemi_flags);
> +
> +       dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> +
> +       return ret;
> +}
> +
> +static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
> +                                         struct fpga_image_info *info)
> +{
> +       return 0;
> +}
> +
> +static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
> +{
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +       u32 status;
> +
> +       if (!eemi_ops || !eemi_ops->fpga_get_status)
> +               return FPGA_MGR_STATE_UNKNOWN;
> +
> +       eemi_ops->fpga_get_status(&status);
> +       if (status & IXR_FPGA_DONE_MASK)
> +               return FPGA_MGR_STATE_OPERATING;
> +
> +       return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static const struct fpga_manager_ops zynqmp_fpga_ops = {
> +       .state = zynqmp_fpga_ops_state,
> +       .write_init = zynqmp_fpga_ops_write_init,
> +       .write = zynqmp_fpga_ops_write,
> +       .write_complete = zynqmp_fpga_ops_write_complete,
> +};
> +
> +static int zynqmp_fpga_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct zynqmp_fpga_priv *priv;
> +       struct fpga_manager *mgr;
> +       int err, ret;

Just use err everywhere, or ret, your choice.
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = dev;
> +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
Here?
> +       if (ret < 0) {
> +               dev_err(dev, "no usable DMA configuration");
> +               return ret;
> +       }
> +
> +       mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> +                             &zynqmp_fpga_ops, priv);
> +       if (!mgr)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, mgr);
> +
> +       err = fpga_mgr_register(mgr);
vs here.
> +       if (err) {
> +               dev_err(dev, "unable to register FPGA manager");
> +               fpga_mgr_free(mgr);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int zynqmp_fpga_remove(struct platform_device *pdev)
> +{
> +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +
> +       fpga_mgr_unregister(mgr);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id zynqmp_fpga_of_match[] = {
> +       { .compatible = "xlnx,zynqmp-pcap-fpga", },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
> +
> +static struct platform_driver zynqmp_fpga_driver = {
> +       .probe = zynqmp_fpga_probe,
> +       .remove = zynqmp_fpga_remove,
> +       .driver = {
> +               .name = "zynqmp_fpga_manager",
> +               .of_match_table = of_match_ptr(zynqmp_fpga_of_match),
> +       },
> +};
> +
> +module_platform_driver(zynqmp_fpga_driver);
> +
> +MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>

Thanks,
Moritz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
