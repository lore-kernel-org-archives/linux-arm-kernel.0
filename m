Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E22C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:53:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BE9217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J2/hBCWU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AszxAvyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BE9217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UxBeYh+OZyevgV4RKGj92GFcgtxVUNmFS8fC/DN+66o=; b=J2/hBCWUHMagJp
	/ovCN378yMDXRmYXeO93PHY+YqUNSBDRcbkoC2yPIBVPwP4y0evSRbMRfPqPBLDwhQ4osEFcAmgZ7
	PCvv4aaXlg6/E5pBlMsEZNc2t7cW7pTRKX2+tEx4arx6PetV1jzoKTwkGIrRt4XVSKLWXien1pB0J
	/ri4WsVnJcY2oQUSe57xkcfRmyx5bRQa1KMrHzYu3oUTWCGYqGCk3cFVcokj7YIJmTQyVQ0/HDLHw
	yg5DVIDpq0bjSihP7FBlFPvXDi3fRb9u9DADTOaJHN8e511Mx51OtRwSj+OyrOxTh82UpXZAXFC+B
	Bght1l3KV2B8WWVJ6jPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybIU-0008Ob-F5; Tue, 26 Feb 2019 11:53:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybIQ-0008OB-Rp
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:53:16 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 27183217F9;
 Tue, 26 Feb 2019 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551181993;
 bh=Q3PMcPZyYk7lXpXVRSw73aPhfioMF5rJZy36t6w1tjs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AszxAvyBBEg6OQWICDLthuF/+OmY14lAe+oil6tPiYJsDHyMXRwLNOnGYXiRpGupi
 p8IFppdfGT8N/CHAZ//mc+UQsPwFvow7s+UCb66lsKqutV8x8vDJTXnxIXBlx0WvGt
 g6XCnSfSBnM/BKS7i/93ifj5/fC6K33PuuAYnRUY=
Date: Tue, 26 Feb 2019 12:53:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hyun Kwon <hyun.kwon@xilinx.com>
Subject: Re: [PATCH RFC 1/1] uio: Add dma-buf import ioctls
Message-ID: <20190226115311.GA4094@kroah.com>
References: <1550953697-7288-1-git-send-email-hyun.kwon@xilinx.com>
 <1550953697-7288-2-git-send-email-hyun.kwon@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550953697-7288-2-git-send-email-hyun.kwon@xilinx.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_035314_935935_09390760 
X-CRM114-Status: GOOD (  19.92  )
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
Cc: Stefano Stabellini <stefanos@xilinx.com>, Sonal Santan <sonals@xilinx.com>,
 Cyril Chemparathy <cyrilc@xilinx.com>, Jiaying Liang <jliang@xilinx.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 23, 2019 at 12:28:17PM -0800, Hyun Kwon wrote:
> Add the dmabuf map / unmap interfaces. This allows the user driver
> to be able to import the external dmabuf and use it from user space.
> 
> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> ---
>  drivers/uio/Makefile         |   2 +-
>  drivers/uio/uio.c            |  43 +++++++++
>  drivers/uio/uio_dmabuf.c     | 210 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/uio/uio_dmabuf.h     |  26 ++++++
>  include/uapi/linux/uio/uio.h |  33 +++++++
>  5 files changed, 313 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/uio/uio_dmabuf.c
>  create mode 100644 drivers/uio/uio_dmabuf.h
>  create mode 100644 include/uapi/linux/uio/uio.h
> 
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2..5da16c7 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_UIO)	+= uio.o
> +obj-$(CONFIG_UIO)	+= uio.o uio_dmabuf.o
>  obj-$(CONFIG_UIO_CIF)	+= uio_cif.o
>  obj-$(CONFIG_UIO_PDRV_GENIRQ)	+= uio_pdrv_genirq.o
>  obj-$(CONFIG_UIO_DMEM_GENIRQ)	+= uio_dmem_genirq.o
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 1313422..6841f98 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -24,6 +24,12 @@
>  #include <linux/kobject.h>
>  #include <linux/cdev.h>
>  #include <linux/uio_driver.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +
> +#include <uapi/linux/uio/uio.h>
> +
> +#include "uio_dmabuf.h"
>  
>  #define UIO_MAX_DEVICES		(1U << MINORBITS)
>  
> @@ -454,6 +460,8 @@ static irqreturn_t uio_interrupt(int irq, void *dev_id)
>  struct uio_listener {
>  	struct uio_device *dev;
>  	s32 event_count;
> +	struct list_head dbufs;
> +	struct mutex dbufs_lock; /* protect @dbufs */
>  };
>  
>  static int uio_open(struct inode *inode, struct file *filep)
> @@ -500,6 +508,9 @@ static int uio_open(struct inode *inode, struct file *filep)
>  	if (ret)
>  		goto err_infoopen;
>  
> +	INIT_LIST_HEAD(&listener->dbufs);
> +	mutex_init(&listener->dbufs_lock);
> +
>  	return 0;
>  
>  err_infoopen:
> @@ -529,6 +540,10 @@ static int uio_release(struct inode *inode, struct file *filep)
>  	struct uio_listener *listener = filep->private_data;
>  	struct uio_device *idev = listener->dev;
>  
> +	ret = uio_dmabuf_cleanup(idev, &listener->dbufs, &listener->dbufs_lock);
> +	if (ret)
> +		dev_err(&idev->dev, "failed to clean up the dma bufs\n");
> +
>  	mutex_lock(&idev->info_lock);
>  	if (idev->info && idev->info->release)
>  		ret = idev->info->release(idev->info, inode);
> @@ -652,6 +667,33 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
>  	return retval ? retval : sizeof(s32);
>  }
>  
> +static long uio_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)

We have resisted adding a uio ioctl for a long time, can't you do this
through sysfs somehow?

A meta-comment about your ioctl structure:

> +#define UIO_DMABUF_DIR_BIDIR	1
> +#define UIO_DMABUF_DIR_TO_DEV	2
> +#define UIO_DMABUF_DIR_FROM_DEV	3
> +#define UIO_DMABUF_DIR_NONE	4

enumerated type?

> +
> +struct uio_dmabuf_args {
> +	__s32	dbuf_fd;
> +	__u64	dma_addr;
> +	__u64	size;
> +	__u32	dir;

Why the odd alignment?  Are you sure this is the best packing for such a
structure?

Why is dbuf_fd __s32?  dir can be __u8, right?

I don't know that dma layer very well, it would be good to get some
review from others to see if this really is even a viable thing to do.
The fd handling seems a bit "odd" here, but maybe I just do not
understand it.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
