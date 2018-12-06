Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:22:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201172081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SdzFhTL3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnGmv73y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201172081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vHSs44dX4DY3YipJSViq4Dqaf73+kGo1kUDjb7+ogxY=; b=SdzFhTL3D+UM2x
	0XImpLTJjKO7Fc2B88zHuUxEj40IijIKG4CP30pajBzX85/qmbKR3skei1TFXM1WfYEOpfIRSO9EF
	R5wsNHkxn8bvHUPD19/L4x1UAzvu0emygUYaMGKVLPlknQhQuRJmq7gF/iYmjOm5E245tRlKVOiyo
	dJxcuEm2UIeHE1euj+AWJ5O4gs0RwrM28wl4SPnjUSAvutaJ+JU9ltR/z7EeBfYtAH/AWyokYcPU0
	zOnAHEPg5B8hRQwRDi+E0KsKDhw7ebi/iYT3WwTb4SDQqvDeDqHp3g8zdQsZBYvg3uJ0+2SrhCiWn
	xHPAkCzqdebeCjQ+f3gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV16M-0001c0-6O; Thu, 06 Dec 2018 21:22:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV16H-0001aa-Io; Thu, 06 Dec 2018 21:22:27 +0000
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 181112146F;
 Thu,  6 Dec 2018 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544131334;
 bh=cZ6tmMowWci0xd5MI0B7S0zbMLSctTiSpwTaxd56MIY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hnGmv73ym9UfYGzNpNXSp0r+1tNkKv14olV6qIbPQ/QzjR6USdU7ebdaF4nLDwYnI
 ZDGQKK3OUYpc1lO8oFwx0nQSG6sAxdeFB8/ZcHXcisHbiJ4e7LkTND2rH+jAhuI+Ba
 nlrHGVlF+5ZJZis+jfcM93T92EA6m5lEdwpTh4yY=
Received: by mail-wm1-f42.google.com with SMTP id y139so2379206wmc.5;
 Thu, 06 Dec 2018 13:22:14 -0800 (PST)
X-Gm-Message-State: AA+aEWbYtpu7gNUqzs3QLhCwPSbEHEIiD+1gklUtSHjrleQphi3PU6dX
 JmcJWuqTj9sUoJkrUlYedjquSlhdtIdENZ6sB/M=
X-Google-Smtp-Source: AFSGD/WP6Kzo60zzqx9RuG8XhXZcgEWgfrN5aWBWsygE0wiFJ0WE2AckmvlCijH5iBzp0beqGctYRtOXojmbKFNRx1c=
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr10063wmg.48.1544131332512;
 Thu, 06 Dec 2018 13:22:12 -0800 (PST)
MIME-Version: 1.0
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
 <1543999380-7946-3-git-send-email-long.cheng@mediatek.com>
 <CAGp9LzqkOHPqVmAOR+YRotOb511BEDOpUWHc-YSjphF3Gpar=w@mail.gmail.com>
 <1544090140.28871.11.camel@mhfsdcap03>
In-Reply-To: <1544090140.28871.11.camel@mhfsdcap03>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 6 Dec 2018 13:22:01 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpVuhWHBgL3qoXQKqoGAhCWY8FS7b_xVi2V=JeDAOz+8g@mail.gmail.com>
Message-ID: <CAGp9LzpVuhWHBgL3qoXQKqoGAhCWY8FS7b_xVi2V=JeDAOz+8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dmaengine: mtk_uart_dma: add Mediatek uart DMA
 support
To: long.cheng@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_132225_660399_0B5130FC 
X-CRM114-Status: GOOD (  25.19  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, yt.shen@mediatek.com,
 srv_heupstream@mediatek.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 vkoul@kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, dmaengine@vger.kernel.org,
 yingjoe.chen@mediatek.com, dan.j.williams@intel.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 1:55 AM Long Cheng <long.cheng@mediatek.com> wrote:
>
> On Wed, 2018-12-05 at 13:07 -0800, Sean Wang wrote:
> > .
> > On Wed, Dec 5, 2018 at 1:31 AM Long Cheng <long.cheng@mediatek.com> wrote:
> > >
> > > In DMA engine framework, add 8250 mtk dma to support it.
> > >
> > > Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> > > ---
> > >  drivers/dma/mediatek/8250_mtk_dma.c |  894 +++++++++++++++++++++++++++++++++++
> > >  drivers/dma/mediatek/Kconfig        |   11 +
> > >  drivers/dma/mediatek/Makefile       |    1 +
> > >  3 files changed, 906 insertions(+)
> > >  create mode 100644 drivers/dma/mediatek/8250_mtk_dma.c
> > >
> > > diff --git a/drivers/dma/mediatek/8250_mtk_dma.c b/drivers/dma/mediatek/8250_mtk_dma.c
> > > new file mode 100644
> > > index 0000000..3454679
> > > --- /dev/null
> > > +++ b/drivers/dma/mediatek/8250_mtk_dma.c
> > > @@ -0,0 +1,894 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Mediatek 8250 DMA driver.
> > > + *
> > > + * Copyright (c) 2018 MediaTek Inc.
> > > + * Author: Long Cheng <long.cheng@mediatek.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/dmaengine.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/err.h>
> > > +#include <linux/init.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/list.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_dma.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/iopoll.h>
> > > +
> > > +#include "../virt-dma.h"
> > > +
> > > +#define MTK_APDMA_DEFAULT_REQUESTS     127
> > > +#define MTK_APDMA_CHANNELS             (CONFIG_SERIAL_8250_NR_UARTS * 2)
> > > +
> > > +#define VFF_EN_B               BIT(0)
> > > +#define VFF_STOP_B             BIT(0)
> > > +#define VFF_FLUSH_B            BIT(0)
> > > +#define VFF_4G_SUPPORT_B       BIT(0)
> > > +#define VFF_RX_INT_EN0_B       BIT(0)  /*rx valid size >=  vff thre*/
> > > +#define VFF_RX_INT_EN1_B       BIT(1)
> > > +#define VFF_TX_INT_EN_B                BIT(0)  /*tx left size >= vff thre*/
> > > +#define VFF_WARM_RST_B         BIT(0)
> > > +#define VFF_RX_INT_FLAG_CLR_B  (BIT(0) | BIT(1))
> > > +#define VFF_TX_INT_FLAG_CLR_B  0
> > > +#define VFF_STOP_CLR_B         0
> > > +#define VFF_FLUSH_CLR_B                0
> > > +#define VFF_INT_EN_CLR_B       0
> > > +#define VFF_4G_SUPPORT_CLR_B   0
> > > +
> > > +/* interrupt trigger level for tx */
> > > +#define VFF_TX_THRE(n)         ((n) * 7 / 8)
> > > +/* interrupt trigger level for rx */
> > > +#define VFF_RX_THRE(n)         ((n) * 3 / 4)
> > > +
> > > +#define MTK_DMA_RING_SIZE      0xffffU
> > > +/* invert this bit when wrap ring head again*/
> > > +#define MTK_DMA_RING_WRAP      0x10000U
> > > +
> > > +#define VFF_INT_FLAG           0x00
> > > +#define VFF_INT_EN             0x04
> > > +#define VFF_EN                 0x08
> > > +#define VFF_RST                        0x0c
> > > +#define VFF_STOP               0x10
> > > +#define VFF_FLUSH              0x14
> > > +#define VFF_ADDR               0x1c
> > > +#define VFF_LEN                        0x24
> > > +#define VFF_THRE               0x28
> > > +#define VFF_WPT                        0x2c
> > > +#define VFF_RPT                        0x30
> > > +/*TX: the buffer size HW can read. RX: the buffer size SW can read.*/
> > > +#define VFF_VALID_SIZE         0x3c
> > > +/*TX: the buffer size SW can write. RX: the buffer size HW can write.*/
> > > +#define VFF_LEFT_SIZE          0x40
> > > +#define VFF_DEBUG_STATUS       0x50
> > > +#define VFF_4G_SUPPORT         0x54
> > > +
> > > +struct mtk_dmadev {
> > > +       struct dma_device ddev;
> > > +       void __iomem *mem_base[MTK_APDMA_CHANNELS];
> > > +       spinlock_t lock; /* dma dev lock */
> > > +       struct tasklet_struct task;
> > > +       struct list_head pending;
> > > +       struct clk *clk;
> > > +       unsigned int dma_requests;
> > > +       bool support_33bits;
> > > +       unsigned int dma_irq[MTK_APDMA_CHANNELS];
> > > +       struct mtk_chan *ch[MTK_APDMA_CHANNELS];
> > > +};
> > > +
> > > +struct mtk_chan {
> > > +       struct virt_dma_chan vc;
> > > +       struct list_head node;
> > > +       struct dma_slave_config cfg;
> > > +       void __iomem *base;
> > > +       struct mtk_dma_desc *desc;
> > > +
> > > +       bool stop;
> > > +       bool requested;
> > > +
> > > +       unsigned int dma_sig;
> >
> > the member can be removed as no real user would refer to it
> >
>
> Ok, i will remove it at next patch
>
> > > +       unsigned int dma_ch;
> >
> > a chan_id is already included in struct dma_chan, we can reuse it
> >
>
> chan_id is start from 0. but in this driver, dma info is stored to list.
> if use port1, in filter_fn function, will set dma_ch to 2, 3(tx, rx). So
> can't using chan_id
>

if you use of_dma_xlate_by_chan_id in of_dma_controller_register, the
client device still can get the right channel with the appropriate
chan_id expressed in dmas property in dts.

> > > +       unsigned int sgidx;
> >

[ ... ]

> ok, i will modify it
> > > +               wpt = mtk_dma_chan_read(c, VFF_WPT);
> > > +               wrap = wpt & MTK_DMA_RING_WRAP ? 0U : MTK_DMA_RING_WRAP;
> > > +
> > > +               if ((wpt & (len - 1U)) + send < len)
> > > +                       mtk_dma_chan_write(c, VFF_WPT, wpt + send);
> > > +               else
> > > +                       mtk_dma_chan_write(c, VFF_WPT,
> > > +                                          ((wpt + send) & (len - 1U))
> > > +                                          | wrap);
> > > +
> > > +               c->remain_size -= send;
> >
> > I'm curious why you don't need to set up the hardware from the
> > descriptor information
> >
>
> mtk_dma_chan_write is update the hardware. remain_size is length of TX
> data.

I thought it is not enough to be a full dmaengine. if the driver only
supports single continuous data moving for device_prep_slave_sg
callback.

We could try to turn each sg item information such as source or
destination address and data length to be one part of the descriptor.
When a descriptor is being issued, and then program VFF_ADDR/LEN and
issue the data move by other VFF_* registers rather than assuming the
data portion is always the fixed as the user assignment at
mtk_dma_slave_config.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
