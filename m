Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB14C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:42:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79A12073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IPzLILId";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkAAaAw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79A12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rw5Y3PR8i1AgxrHLObFytXCHw0xUfux+xjrFFr8w3FI=; b=IPzLILIdZ+Lxt0
	as0oWOQCTxW15Ax0sKCA5ruzslnhooj4J99Hk24RgdQCqHJ9h9KU1oaO6WnQ2EWm2N1CAbomBUxzs
	7SMyI0j+Ai9+vZKzXWpVcm+nR1THBdG3mPYpwXwDw83D1exCsm4PK0bVQLuHp4PSRQVJyJvnPg/n7
	RlfLuzCbBTa9GKaZ+q7mVGvzJ6XeTTaQAq3R/J1TKXtkpbrT3osfisssd0BrJZtzEJaCWT09nq7Ox
	VGDdx9NCNpu2vQSK6DZugsHMwy8+LcmZp4j3wzRHu73FOWOmhGechBDiO+YuAnea/IZ9Vu7t1vDh1
	B1oZqg8sLl9dzlIrdt2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gql4B-0003mC-5W; Mon, 04 Feb 2019 20:42:07 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gql47-0003lD-B3
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:42:06 +0000
Received: by mail-pl1-x641.google.com with SMTP id 101so477002pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 12:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/9C64krJh+fZNehmvUZXQZMtN8RgARxZPkN4E0n2GIU=;
 b=fkAAaAw4sxI4dFnjebNFXdoarFA9dcqlMENlEAbWusfS7v3VlII6/5Zk6LvqvhhVGf
 86/lfBCZxD+TpN02ctEdnDkenpi+BHabYjYqulr1ngNwEUOZLoWPn8LYoG+0zZoGShZO
 IR/S2bXValMoPjBVzdTIZ+5XjAKfOF2PaeK+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/9C64krJh+fZNehmvUZXQZMtN8RgARxZPkN4E0n2GIU=;
 b=oe+dyB21yQfpvb/ARxoYHTM9pmBODfldawCi5Lw6NPrBWOHCkLHdHTyohrxp2WmbJ+
 6524R3bkKqdF954btyUjIeog2C6VYDCYYtyV8t3iw8dI/FdgKCHB62GYCC7HOe2vcUJ6
 yNiPpzhw29f0Vu8jYsdn21eK1Xh1OG86ri0NcYWC74uoHt2ky9qRi0aDBDaiITua8/du
 3ncPhPpgdkbfUyF++MQqaQQSCwrhI2r/JLC/1FmS6liql5sGMlHfvh6ToNdi8dfESjkc
 g9ZNubrcTvn9HaQuWuQ992WIWsunnhYewjyJCURBSVo0Gt4AIZtSzuAAdBs2bAEqiA/C
 497A==
X-Gm-Message-State: AHQUAuZ1EFlwZfSoQ1JEC7kTwSXK/sEkBslfsXZwxDnqsxbFRZbVFYqi
 71bitNaV8Ld/0CaeEvw/TjfeNA==
X-Google-Smtp-Source: AHgI3IZmnCFg93C2vyWTjWpyN0TH1Nou03soxx8kNazLKDY7rLCtQVDrGgsNVuDs3SZYdC+EC3FRAQ==
X-Received: by 2002:a17:902:c85:: with SMTP id 5mr1293088plt.339.1549312922705; 
 Mon, 04 Feb 2019 12:42:02 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id b9sm1112178pfi.118.2019.02.04.12.42.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 12:42:01 -0800 (PST)
Date: Mon, 4 Feb 2019 12:42:01 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH v4 3/6] rpmsg: add rpmsg support for mt8183 SCP.
Message-ID: <20190204204201.GE117604@google.com>
References: <20190131093131.245531-1-pihsun@chromium.org>
 <20190131093131.245531-4-pihsun@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131093131.245531-4-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_124203_751001_F06086F2 
X-CRM114-Status: GOOD (  33.18  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Pi-Hsun,

On Thu, Jan 31, 2019 at 05:31:28PM +0800, Pi-Hsun Shih wrote:
> Add a simple rpmsg support for mt8183 SCP, that use IPI / IPC directly.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v3:
>  - Change from unprepare to stop, to stop the rpmsg driver before the
>    rproc is stopped, avoiding problem that some rpmsg would fail after
>    rproc is stopped.
>  - Add missing spin_lock_init, and use destroy_ept instead of kref_put.
> 
> Changes from v2:
>  - Unregiser IPI handler on unprepare.
>  - Lock the channel list on operations.
>  - Move SCP_IPI_NS_SERVICE to 0xFF.
> 
> Changes from v1:
>  - Do cleanup properly in mtk_rpmsg.c, which also removes the problem of
>    short-lived work items.
>  - Fix several issues checkpatch found.
> ---
>  drivers/remoteproc/mtk_common.h       |   3 +
>  drivers/remoteproc/mtk_scp.c          |  29 +-
>  drivers/remoteproc/mtk_scp_ipi.c      |   5 +-
>  drivers/rpmsg/Kconfig                 |  10 +
>  drivers/rpmsg/Makefile                |   1 +
>  drivers/rpmsg/mtk_rpmsg.c             | 384 ++++++++++++++++++++++++++
>  include/linux/platform_data/mtk_scp.h |   6 +-
>  include/linux/rpmsg/mtk_rpmsg.h       |  35 +++
>  8 files changed, 466 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/rpmsg/mtk_rpmsg.c
>  create mode 100644 include/linux/rpmsg/mtk_rpmsg.h
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 162798c44ad7f1..7efe2e7374e5ec 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -54,6 +54,9 @@ struct mtk_scp {
>  	void __iomem *cpu_addr;
>  	phys_addr_t phys_addr;
>  	size_t dram_size;
> +
> +	struct platform_device *pdev;
> +	struct rproc_subdev *rpmsg_subdev;
>  };
>  
>  /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 920c81c3525c2a..c0375119c53289 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_data/mtk_scp.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
> +#include <linux/rpmsg/mtk_rpmsg.h>
>  
>  #include "mtk_common.h"
>  #include "remoteproc_internal.h"
> @@ -303,6 +304,23 @@ static int scp_map_memory_region(struct mtk_scp *scp)
>  	return 0;
>  }
>  
> +static void scp_add_rpmsg_subdev(struct mtk_scp *scp)
> +{
> +	scp->rpmsg_subdev =
> +		mtk_rpmsg_create_rproc_subdev(scp->pdev, scp->rproc);
> +	if (scp->rpmsg_subdev)
> +		rproc_add_subdev(scp->rproc, scp->rpmsg_subdev);
> +}
> +
> +static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
> +{
> +	if (scp->rpmsg_subdev) {
> +		rproc_remove_subdev(scp->rproc, scp->rpmsg_subdev);
> +		mtk_rpmsg_destroy_rproc_subdev(scp->rpmsg_subdev);
> +		scp->rpmsg_subdev = NULL;
> +	}
> +}
> +
>  static int mtk_scp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -326,6 +344,7 @@ static int mtk_scp_probe(struct platform_device *pdev)
>  	scp = (struct mtk_scp *)rproc->priv;
>  	scp->rproc = rproc;
>  	scp->dev = dev;
> +	scp->pdev = pdev;

The field shouldn't be needed since you already have ->dev.
to_platform_device(scp->dev) could be used in scp_add_rpmsg_subdev().

>  	platform_set_drvdata(pdev, scp);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> @@ -396,13 +415,16 @@ static int mtk_scp_probe(struct platform_device *pdev)
>  	init_waitqueue_head(&scp->run.wq);
>  	init_waitqueue_head(&scp->ack_wq);
>  
> +	scp_add_rpmsg_subdev(scp);
> +
>  	ret = rproc_add(rproc);
>  	if (ret)
> -		goto destroy_mutex;
> +		goto remove_subdev;
>  
> -	return ret;
> +	return 0;
>  
> -destroy_mutex:
> +remove_subdev:
> +	scp_remove_rpmsg_subdev(scp);
>  	mutex_destroy(&scp->scp_mutex);
>  free_rproc:
>  	rproc_free(rproc);
> @@ -414,6 +436,7 @@ static int mtk_scp_remove(struct platform_device *pdev)
>  {
>  	struct mtk_scp *scp = platform_get_drvdata(pdev);
>  
> +	scp_remove_rpmsg_subdev(scp);
>  	rproc_del(scp->rproc);
>  	rproc_free(scp->rproc);
>  
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> index 51b8449a692970..1026089335a5c3 100644
> --- a/drivers/remoteproc/mtk_scp_ipi.c
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -93,8 +93,9 @@ int scp_ipi_send(struct platform_device *pdev,
>  	int ret;
>  
>  	if (WARN(id <= SCP_IPI_INIT || id >= SCP_IPI_MAX ||
> -	    len > sizeof(send_obj->share_buf) || !buf,
> -	    "failed to send ipi message\n"))
> +			 id == SCP_IPI_NS_SERVICE ||
> +			 len > sizeof(send_obj->share_buf) || !buf,
> +		 "failed to send ipi message\n"))
>  		return -EINVAL;
>  
>  	ret = clk_prepare_enable(scp->clk);
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index d0322b41eca54c..270eca663fb8c0 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -15,6 +15,16 @@ config RPMSG_CHAR
>  	  in /dev. They make it possible for user-space programs to send and
>  	  receive rpmsg packets.
>  
> +config RPMSG_MTK_SCP
> +	tristate "MediaTek SCP"
> +	depends on MTK_SCP
> +	select RPMSG
> +	help
> +	  Say y here to enable support providing communication channels to
> +	  remote processors in MediaTek platforms.
> +	  This use IPI and IPC to communicate with remote processors, with a
> +	  send and receive buffer of size 1.

is the buffer size really relevant in this context?

> +
>  config RPMSG_QCOM_GLINK_NATIVE
>  	tristate
>  	select RPMSG
> diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
> index 9aa859502d2752..ae92a7fb08f623 100644
> --- a/drivers/rpmsg/Makefile
> +++ b/drivers/rpmsg/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
>  obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
> +obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
> new file mode 100644
> index 00000000000000..55498ff0a3497d
> --- /dev/null
> +++ b/drivers/rpmsg/mtk_rpmsg.c
> @@ -0,0 +1,384 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright 2018 Google LLC.
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/mtk_scp.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/rpmsg/mtk_rpmsg.h>
> +#include <linux/workqueue.h>
> +
> +#include "rpmsg_internal.h"
> +
> +struct mtk_rpmsg_device {
> +	struct rpmsg_device rpdev;
> +	struct platform_device *scp_pdev;
> +};
> +
> +struct mtk_rpmsg_endpoint {
> +	struct rpmsg_endpoint ept;
> +	struct platform_device *scp_pdev;
> +};
> +
> +struct mtk_rpmsg_rproc_subdev {
> +	struct rproc *scp_rproc;
> +	struct platform_device *scp_pdev;
> +	struct rpmsg_endpoint *ns_ept;
> +	struct rproc_subdev subdev;
> +
> +	struct work_struct register_work;
> +	struct list_head channels;
> +	spinlock_t channels_lock;
> +};
> +
> +#define to_mtk_subdev(d) container_of(d, struct mtk_rpmsg_rproc_subdev, subdev)
> +
> +struct mtk_rpmsg_channel_info {
> +	struct rpmsg_channel_info info;
> +	bool registered;
> +	struct list_head list;
> +};
> +
> +/**
> + * struct rpmsg_ns_msg - dynamic name service announcement message
> + * @name: name of remote service that is published
> + * @addr: address of remote service that is published
> + *
> + * This message is sent across to publish a new service. When we receive these
> + * messages, an appropriate rpmsg channel (i.e device) is created. In turn, the
> + * ->probe() or ->remove() handler of the appropriate rpmsg driver will be
> + *  invoked (if/as-soon-as one is registered).
> + */
> +struct rpmsg_ns_msg {
> +	char name[RPMSG_NAME_SIZE];
> +	u32 addr;
> +} __packed;
> +
> +#define to_scp_device(r)	container_of(r, struct mtk_rpmsg_device, rpdev)
> +#define to_scp_endpoint(r)	container_of(r, struct mtk_rpmsg_endpoint, ept)
> +
> +static const struct rpmsg_endpoint_ops mtk_rpmsg_endpoint_ops;
> +
> +static void __ept_release(struct kref *kref)
> +{
> +	struct rpmsg_endpoint *ept = container_of(kref, struct rpmsg_endpoint,
> +						  refcount);
> +	kfree(to_scp_endpoint(ept));
> +}
> +
> +static void mtk_rpmsg_ipi_handler(void *data, unsigned int len, void *priv)
> +{
> +	struct mtk_rpmsg_endpoint *mept = priv;
> +	struct rpmsg_endpoint *ept = &mept->ept;
> +	int ret;
> +
> +	ret = (*ept->cb)(ept->rpdev, data, len, ept->priv, ept->addr);
> +	if (ret)
> +		dev_warn(&ept->rpdev->dev, "rpmsg handler return error = %d",
> +			 ret);
> +}
> +
> +static struct rpmsg_endpoint *
> +__rpmsg_create_ept(struct platform_device *scp_pdev, struct rpmsg_device *rpdev,
> +		   rpmsg_rx_cb_t cb, void *priv,
> +		   u32 id)
> +{
> +	struct mtk_rpmsg_endpoint *mept;
> +	struct rpmsg_endpoint *ept;
> +

delete empty line

> +	int ret;
> +
> +	mept = kzalloc(sizeof(*mept), GFP_KERNEL);
> +	if (!mept)
> +		return NULL;
> +	mept->scp_pdev = scp_pdev;
> +
> +	ept = &mept->ept;
> +	kref_init(&ept->refcount);
> +
> +	ept->rpdev = rpdev;
> +	ept->cb = cb;
> +	ept->priv = priv;
> +	ept->ops = &mtk_rpmsg_endpoint_ops;
> +	ept->addr = id;
> +
> +	ret = scp_ipi_register(scp_pdev, id, mtk_rpmsg_ipi_handler, mept);
> +	if (ret) {
> +		dev_err(&scp_pdev->dev, "ipi register failed, id = %d", id);
> +		kref_put(&ept->refcount, __ept_release);
> +		return NULL;
> +	}
> +
> +	return ept;
> +}
> +
> +static struct rpmsg_endpoint *
> +mtk_rpmsg_create_ept(struct rpmsg_device *rpdev, rpmsg_rx_cb_t cb, void *priv,
> +		     struct rpmsg_channel_info chinfo)
> +{
> +	struct platform_device *scp_pdev = to_scp_device(rpdev)->scp_pdev;
> +
> +	return __rpmsg_create_ept(scp_pdev, rpdev, cb, priv, chinfo.src);
> +}
> +
> +static const struct rpmsg_device_ops mtk_rpmsg_device_ops = {
> +	.create_ept = mtk_rpmsg_create_ept,
> +};

declare this closer to where it is used (i.e. before
mtk_rpmsg_register_device())?

> +
> +static void mtk_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
> +{
> +	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
> +
> +	scp_ipi_unregister(mept->scp_pdev, ept->addr);
> +	kref_put(&ept->refcount, __ept_release);
> +}
> +
> +static int __mtk_rpmsg_send(struct mtk_rpmsg_endpoint *mept, void *data,
> +			    int len, bool wait)
> +{
> +	/*
> +	 * TODO: This currently ignore the "wait" argument, and always wait
> +	 * until SCP receive the last command.
> +	 */
> +	return scp_ipi_send(mept->scp_pdev, mept->ept.addr, data, len, 0);
> +}

I don't think this wrapper adds much value, there is little gain from
eliminating the access to the struct members in the call and it comes
at the expense of another level of function call nesting.

> +
> +static int mtk_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
> +{
> +	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
> +
> +	return __mtk_rpmsg_send(mept, data, len, true);
> +}
> +
> +static int mtk_rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
> +{
> +	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
> +
> +	return __mtk_rpmsg_send(mept, data, len, false);
> +}
> +
> +static const struct rpmsg_endpoint_ops mtk_rpmsg_endpoint_ops = {
> +	.destroy_ept = mtk_rpmsg_destroy_ept,
> +	.send = mtk_rpmsg_send,
> +	.trysend = mtk_rpmsg_trysend,
> +};
> +
> +static void mtk_rpmsg_release_device(struct device *dev)
> +{
> +	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> +	struct mtk_rpmsg_device *mdev = to_scp_device(rpdev);
> +
> +	kfree(mdev);
> +}
> +
> +static int mtk_rpmsg_register_device(struct platform_device *scp_pdev,
> +				     struct rpmsg_channel_info *info)
> +{
> +	struct rpmsg_device *rpdev;
> +	struct mtk_rpmsg_device *mdev;
> +	int ret;
> +
> +	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
> +	if (!mdev)
> +		return -ENOMEM;
> +
> +	mdev->scp_pdev = scp_pdev;
> +
> +	rpdev = &mdev->rpdev;
> +	rpdev->ops = &mtk_rpmsg_device_ops;
> +	rpdev->src = info->src;
> +	rpdev->dst = info->dst;
> +	strncpy(rpdev->id.name, info->name, RPMSG_NAME_SIZE);
> +
> +	rpdev->dev.parent = &scp_pdev->dev;
> +	rpdev->dev.release = mtk_rpmsg_release_device;
> +
> +	ret = rpmsg_register_device(rpdev);
> +	if (ret)

		kfree(mdev);

> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void mtk_register_device_work_function(struct work_struct *register_work)
> +{
> +	struct mtk_rpmsg_rproc_subdev *mtk_subdev = container_of(
> +		register_work, struct mtk_rpmsg_rproc_subdev, register_work);
> +	struct platform_device *scp_pdev = mtk_subdev->scp_pdev;
> +	struct mtk_rpmsg_channel_info *info;
> +

delete empty line

> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mtk_subdev->channels_lock, flags);
> +	list_for_each_entry(info, &mtk_subdev->channels, list) {
> +		if (info->registered)
> +			continue;
> +
> +		spin_unlock_irqrestore(&mtk_subdev->channels_lock, flags);

I wonder if it would make sense to use a threaded interrupt handler
for the IPI, which would allow to use a mutex and avoid the need to
unlock/relock when calling potentially blocking functions (same pattern
below in mtk_rpmsg_stop()).

> +		ret = mtk_rpmsg_register_device(scp_pdev, &info->info);
> +		spin_lock_irqsave(&mtk_subdev->channels_lock, flags);
> +
> +		if (ret) {
> +			dev_err(&scp_pdev->dev, "Can't create rpmsg_device\n");
> +			continue;
> +		}
> +
> +		info->registered = true;
> +	}
> +	spin_unlock_irqrestore(&mtk_subdev->channels_lock, flags);
> +}
> +
> +static int mtk_rpmsg_create_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
> +				   char *name, u32 addr)
> +{
> +	struct mtk_rpmsg_channel_info *info;
> +	unsigned long flags;
> +
> +	/* This is called in interrupt context from name service callback. */
> +	info = kzalloc(sizeof(*info), GFP_ATOMIC);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	strncpy(info->info.name, name, RPMSG_NAME_SIZE);
> +	info->info.src = addr;
> +	info->info.dst = RPMSG_ADDR_ANY;
> +	spin_lock_irqsave(&mtk_subdev->channels_lock, flags);
> +	list_add(&info->list, &mtk_subdev->channels);
> +	spin_unlock_irqrestore(&mtk_subdev->channels_lock, flags);
> +
> +	schedule_work(&mtk_subdev->register_work);
> +	return 0;
> +}
> +
> +static int mtk_rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> +			   void *priv, u32 src)
> +{
> +	struct rpmsg_ns_msg *msg = data;
> +	struct mtk_rpmsg_rproc_subdev *mtk_subdev = priv;
> +	struct device *dev = &mtk_subdev->scp_pdev->dev;
> +
> +	int ret;
> +
> +	if (len != sizeof(*msg)) {
> +		dev_err(dev, "malformed ns msg (%d)\n", len);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * the name service ept does _not_ belong to a real rpmsg channel,
> +	 * and is handled by the rpmsg bus itself.
> +	 * for sanity reasons, make sure a valid rpdev has _not_ sneaked
> +	 * in somehow.
> +	 */
> +	if (rpdev) {
> +		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
> +		return -EINVAL;
> +	}
> +
> +	/* don't trust the remote processor for null terminating the name */
> +	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> +
> +	dev_info(dev, "creating channel %s addr 0x%x\n", msg->name, msg->addr);
> +
> +	ret = mtk_rpmsg_create_device(mtk_subdev, msg->name, msg->addr);
> +	if (ret) {
> +		dev_err(dev, "create rpmsg device failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int mtk_rpmsg_prepare(struct rproc_subdev *subdev)
> +{
> +	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
> +	struct platform_device *scp_pdev;
> +
> +	mtk_subdev = to_mtk_subdev(subdev);
> +	scp_pdev = mtk_subdev->scp_pdev;

initialization could be done together with declaration.

> +
> +	/* a dedicated endpoint handles the name service msgs */
> +	mtk_subdev->ns_ept =
> +		__rpmsg_create_ept(scp_pdev, NULL, mtk_rpmsg_ns_cb, mtk_subdev,
> +				   SCP_IPI_NS_SERVICE);
> +	if (!mtk_subdev->ns_ept) {
> +		dev_err(&scp_pdev->dev,
> +			"failed to create name service endpoint\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +void mtk_rpmsg_stop(struct rproc_subdev *subdev, bool crashed)
> +{
> +	struct mtk_rpmsg_channel_info *info, *next;
> +	struct device *dev;
> +	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
> +	unsigned long flags;
> +
> +	dev = &mtk_subdev->scp_pdev->dev;

this could be done above if the declaration order of dev and
mtk_subdev is swapped.

> +
> +	mtk_rpmsg_destroy_ept(mtk_subdev->ns_ept);
> +	cancel_work_sync(&mtk_subdev->register_work);
> +
> +	spin_lock_irqsave(&mtk_subdev->channels_lock, flags);
> +	list_for_each_entry(info, &mtk_subdev->channels, list) {
> +		if (!info->registered)
> +			continue;
> +		spin_unlock_irqrestore(&mtk_subdev->channels_lock, flags);
> +		if (rpmsg_unregister_device(dev, &info->info)) {
> +			dev_warn(
> +				dev,
> +				"rpmsg_unregister_device failed for %s.%d.%d\n",
> +				info->info.name, info->info.src,
> +				info->info.dst);
> +		}
> +		spin_lock_irqsave(&mtk_subdev->channels_lock, flags);
> +	}
> +
> +	list_for_each_entry_safe(info, next,
> +				 &mtk_subdev->channels, list) {
> +		list_del(&info->list);
> +		kfree(info);
> +	}
> +	spin_unlock_irqrestore(&mtk_subdev->channels_lock, flags);
> +}
> +
> +struct rproc_subdev *
> +mtk_rpmsg_create_rproc_subdev(struct platform_device *scp_pdev,
> +			      struct rproc *scp_rproc)
> +{
> +	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
> +
> +	mtk_subdev = kzalloc(sizeof(*mtk_subdev), GFP_KERNEL);
> +	if (!mtk_subdev)
> +		return NULL;
> +
> +	mtk_subdev->scp_pdev = scp_pdev;
> +	mtk_subdev->scp_rproc = scp_rproc;
> +	mtk_subdev->subdev.prepare = mtk_rpmsg_prepare;
> +	mtk_subdev->subdev.stop = mtk_rpmsg_stop;
> +	INIT_LIST_HEAD(&mtk_subdev->channels);
> +	INIT_WORK(&mtk_subdev->register_work,
> +		  mtk_register_device_work_function);
> +	spin_lock_init(&mtk_subdev->channels_lock);
> +
> +	return &mtk_subdev->subdev;
> +}
> +EXPORT_SYMBOL_GPL(mtk_rpmsg_create_rproc_subdev);
> +
> +void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev)
> +{
> +	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
> +
> +	kfree(mtk_subdev);
> +}
> +EXPORT_SYMBOL_GPL(mtk_rpmsg_destroy_rproc_subdev);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MediaTek scp rpmsg driver");
> diff --git a/include/linux/platform_data/mtk_scp.h b/include/linux/platform_data/mtk_scp.h
> index 0e999ec319446b..643ef305a9e88d 100644
> --- a/include/linux/platform_data/mtk_scp.h
> +++ b/include/linux/platform_data/mtk_scp.h
> @@ -22,7 +22,7 @@ typedef void (*scp_ipi_handler_t) (void *data,
>   *			 command to SCP.
>   *			 For other IPI below, AP should send the request
>   *			 to SCP to trigger the interrupt.
> - * @IPI_MAX:		 The maximum IPI number
> + * @SCP_IPI_MAX:	 The maximum IPI number

fix in "[2/6] remoteproc/mediatek: add SCP support for mt8183"?

>   */
>  
>  enum scp_ipi_id {
> @@ -34,9 +34,11 @@ enum scp_ipi_id {
>  	SCP_IPI_VENC_VP8,
>  	SCP_IPI_MDP,
>  	SCP_IPI_CROS_HOST_CMD,
> -	SCP_IPI_MAX,
>  };
>  
> +#define SCP_IPI_NS_SERVICE 0xFF
> +#define SCP_IPI_MAX 0x100

shouldn't these (still) be part of enum scp_ipi_id?

> +
>  /**
>   * scp_ipi_register - register an ipi function
>   *
> diff --git a/include/linux/rpmsg/mtk_rpmsg.h b/include/linux/rpmsg/mtk_rpmsg.h
> new file mode 100644
> index 00000000000000..8d21cd3d35b012
> --- /dev/null
> +++ b/include/linux/rpmsg/mtk_rpmsg.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2018 Google LLC.
> + */
> +
> +#ifndef __LINUX_RPMSG_MTK_RPMSG_H
> +#define __LINUX_RPMSG_MTK_RPMSG_H
> +
> +#include <linux/device.h>
> +#include <linux/remoteproc.h>
> +
> +#if IS_ENABLED(CONFIG_RPMSG_MTK_SCP)
> +
> +struct rproc_subdev *
> +mtk_rpmsg_create_rproc_subdev(struct platform_device *scp_pdev,
> +			      struct rproc *scp_rproc);
> +
> +void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev);
> +
> +#else
> +
> +static inline struct rproc_subdev *
> +mtk_rpmsg_create_rproc_subdev(struct platform_device *scp_pdev,
> +			      struct rproc *scp_rproc)
> +{
> +	return NULL;
> +}
> +
> +static inline void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev)
> +{
> +}
> +
> +#endif
> +
> +#endif

Cheers

Matthias

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
