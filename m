Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2170C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18E12133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FLJsI9oc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="guo1Bhk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18E12133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g4in2gvY1/Bt9cMyuHCaTuP3WiT/EwfZt4GvMR42VGM=; b=FLJsI9ocETSwqc
	snaswKGVlx4b2uOkew71yN4kd7sfviE0DUZ3CJFwEPLM+XKzG8xTtNZIPhbeeaPlS25E2CheQSME0
	gUKKIKT0yF5vDyYpcyKKeUKmd+qKfTC+c8dlQ3kOeRdCZrufXckacqQFeiHHY5m+nPg98Xp0gsDXE
	jo/Y/RjC4b8C895YHC++05iPtxH0ZX4ZqUXWSMzlALEFoBv1862kKyOrJcZCg5mLN7CB/8+ftZRma
	nRXSY/Ac2oC9AF2yvQTx1EH0H+8QW33LabDTEkYUzvc5qOtFcHYoSGzE0eqy40wIf+gem/eoL+gBr
	wIp+UOtkmdKZ+GeO0UWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzyJ-0007mj-RW; Wed, 27 Feb 2019 14:14:07 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzyB-0007lC-1H
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 14:14:05 +0000
Received: by mail-it1-x141.google.com with SMTP id l66so10036860itg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m3PJNiDhK5CQ3cZNm7dbtVwWTqwCG6d4RZhzFvPJiWw=;
 b=guo1Bhk1VN+vpi//Fg2CUojS5GDKbLWUc790Wiw+5lhrqsYxmCqAeSpDrcuwsj/Qek
 c+RDG1c1dvWT/U1vwTcOztkhy+qTRpLm/e9InLPtxtprvOMuJ+cU5wN2twW3jApZIHEG
 8hjeKQNLzs+CXox2ZZMUwLZJ3F0KC4QyHTShw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m3PJNiDhK5CQ3cZNm7dbtVwWTqwCG6d4RZhzFvPJiWw=;
 b=aOl3s7f02lQovusYz3ePYHTYB+pwlgOKKsfaJgTQeURtKR1KR9N+OYdx7tHNIq7tED
 fmFGsw4z+hB+UgubWGL1dLdo/GXPaXoa43zQqgLt7jEkdB+zbJoUbxXLENKLCagZT/Nw
 NItddKvMKdTCnqlfGdZObhFuOBR0S0K3kvrgXnmijP1jvPLMcDfQCKHUKyRkuuJI1dc3
 SNMUGROHA49TqbsWF32o14qQfCQJal7BdBVrYJfrHIyz4SfIKALKuTiGrrY3/6d1+PY6
 T+TrZWdkkM/b0dBIQexbefii9mhlk7HcH4xgAbGp4Unn3Svtm3fguYtKmB53RABz31RE
 LVPw==
X-Gm-Message-State: AHQUAuZQcxzxFEmD5hzW0alOs+Dm67QsXeKAaxsif6GYmUrjG7F43j0m
 9MFS7VsG2zfWavnlgLoFLu/X8TqKJ3HHali3Lie71g==
X-Google-Smtp-Source: APXvYqxwvDQQHMpLkNw20WJwmaWF4a1d1wD0rmm3gzUqfEHvIoA0i2uL1yZxHDPX+c83uRAUWCcjF1abxhSMFobYJVY=
X-Received: by 2002:a24:59cf:: with SMTP id p198mr1457177itb.51.1551276837406; 
 Wed, 27 Feb 2019 06:13:57 -0800 (PST)
MIME-Version: 1.0
References: <1550953697-7288-1-git-send-email-hyun.kwon@xilinx.com>
 <1550953697-7288-2-git-send-email-hyun.kwon@xilinx.com>
 <20190226115311.GA4094@kroah.com>
 <CAKMK7uE=dSyo5vdjtQf=k1rdoegiBgSozCOotXLSW2VAkz2Ldw@mail.gmail.com>
 <20190226221817.GB10631@smtp.xilinx.com>
In-Reply-To: <20190226221817.GB10631@smtp.xilinx.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Feb 2019 15:13:45 +0100
Message-ID: <CAKMK7uFay0mjHFhQqmQ7fneS2B0xNW_Nv4AWqp-FK1NnHVe5uw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] uio: Add dma-buf import ioctls
To: Hyun Kwon <hyun.kwon@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_061404_013752_EB9810E2 
X-CRM114-Status: GOOD (  40.15  )
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
Cc: Stefano Stabellini <stefanos@xilinx.com>, Hyun Kwon <hyunk@xilinx.com>,
 Sonal Santan <sonals@xilinx.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cyril Chemparathy <cyrilc@xilinx.com>, Jiaying Liang <jliang@xilinx.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Michal Simek <michals@xilinx.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 11:20 PM Hyun Kwon <hyun.kwon@xilinx.com> wrote:
>
> Hi Daniel,
>
> Thanks for the comment.
>
> On Tue, 2019-02-26 at 04:06:13 -0800, Daniel Vetter wrote:
> > On Tue, Feb 26, 2019 at 12:53 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Feb 23, 2019 at 12:28:17PM -0800, Hyun Kwon wrote:
> > > > Add the dmabuf map / unmap interfaces. This allows the user driver
> > > > to be able to import the external dmabuf and use it from user space.
> > > >
> > > > Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> > > > ---
> > > >  drivers/uio/Makefile         |   2 +-
> > > >  drivers/uio/uio.c            |  43 +++++++++
> > > >  drivers/uio/uio_dmabuf.c     | 210 +++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/uio/uio_dmabuf.h     |  26 ++++++
> > > >  include/uapi/linux/uio/uio.h |  33 +++++++
> > > >  5 files changed, 313 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/uio/uio_dmabuf.c
> > > >  create mode 100644 drivers/uio/uio_dmabuf.h
> > > >  create mode 100644 include/uapi/linux/uio/uio.h
> > > >
> > > > diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> > > > index c285dd2..5da16c7 100644
> > > > --- a/drivers/uio/Makefile
> > > > +++ b/drivers/uio/Makefile
> > > > @@ -1,5 +1,5 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > > -obj-$(CONFIG_UIO)    += uio.o
> > > > +obj-$(CONFIG_UIO)    += uio.o uio_dmabuf.o
> > > >  obj-$(CONFIG_UIO_CIF)        += uio_cif.o
> > > >  obj-$(CONFIG_UIO_PDRV_GENIRQ)        += uio_pdrv_genirq.o
> > > >  obj-$(CONFIG_UIO_DMEM_GENIRQ)        += uio_dmem_genirq.o
> > > > diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> > > > index 1313422..6841f98 100644
> > > > --- a/drivers/uio/uio.c
> > > > +++ b/drivers/uio/uio.c
> > > > @@ -24,6 +24,12 @@
> > > >  #include <linux/kobject.h>
> > > >  #include <linux/cdev.h>
> > > >  #include <linux/uio_driver.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/mutex.h>
> > > > +
> > > > +#include <uapi/linux/uio/uio.h>
> > > > +
> > > > +#include "uio_dmabuf.h"
> > > >
> > > >  #define UIO_MAX_DEVICES              (1U << MINORBITS)
> > > >
> > > > @@ -454,6 +460,8 @@ static irqreturn_t uio_interrupt(int irq, void *dev_id)
> > > >  struct uio_listener {
> > > >       struct uio_device *dev;
> > > >       s32 event_count;
> > > > +     struct list_head dbufs;
> > > > +     struct mutex dbufs_lock; /* protect @dbufs */
> > > >  };
> > > >
> > > >  static int uio_open(struct inode *inode, struct file *filep)
> > > > @@ -500,6 +508,9 @@ static int uio_open(struct inode *inode, struct file *filep)
> > > >       if (ret)
> > > >               goto err_infoopen;
> > > >
> > > > +     INIT_LIST_HEAD(&listener->dbufs);
> > > > +     mutex_init(&listener->dbufs_lock);
> > > > +
> > > >       return 0;
> > > >
> > > >  err_infoopen:
> > > > @@ -529,6 +540,10 @@ static int uio_release(struct inode *inode, struct file *filep)
> > > >       struct uio_listener *listener = filep->private_data;
> > > >       struct uio_device *idev = listener->dev;
> > > >
> > > > +     ret = uio_dmabuf_cleanup(idev, &listener->dbufs, &listener->dbufs_lock);
> > > > +     if (ret)
> > > > +             dev_err(&idev->dev, "failed to clean up the dma bufs\n");
> > > > +
> > > >       mutex_lock(&idev->info_lock);
> > > >       if (idev->info && idev->info->release)
> > > >               ret = idev->info->release(idev->info, inode);
> > > > @@ -652,6 +667,33 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
> > > >       return retval ? retval : sizeof(s32);
> > > >  }
> > > >
> > > > +static long uio_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> > >
> > > We have resisted adding a uio ioctl for a long time, can't you do this
> > > through sysfs somehow?
> > >
> > > A meta-comment about your ioctl structure:
> > >
> > > > +#define UIO_DMABUF_DIR_BIDIR 1
> > > > +#define UIO_DMABUF_DIR_TO_DEV        2
> > > > +#define UIO_DMABUF_DIR_FROM_DEV      3
> > > > +#define UIO_DMABUF_DIR_NONE  4
> > >
> > > enumerated type?
> > >
> > > > +
> > > > +struct uio_dmabuf_args {
> > > > +     __s32   dbuf_fd;
> > > > +     __u64   dma_addr;
> > > > +     __u64   size;
> > > > +     __u32   dir;
> > >
> > > Why the odd alignment?  Are you sure this is the best packing for such a
> > > structure?
> > >
> > > Why is dbuf_fd __s32?  dir can be __u8, right?
> > >
> > > I don't know that dma layer very well, it would be good to get some
> > > review from others to see if this really is even a viable thing to do.
> > > The fd handling seems a bit "odd" here, but maybe I just do not
> > > understand it.
> >
> > Frankly looks like a ploy to sidestep review by graphics folks. We'd
> > ask for the userspace first :-)
>
> Please refer to pull request [1].
>
> For any interest in more details, the libmetal is the abstraction layer
> which provides platform independent APIs. The backend implementation
> can be selected per different platforms: ex, rtos, linux,
> standalone (xilinx),,,. For Linux, it supports UIO / vfio as of now.
> The actual user space drivers sit on top of libmetal. Such drivers can be
> found in [2]. This is why I try to avoid any device specific code in
> Linux kernel.
>
> >
> > Also, exporting dma_addr to userspace is considered a very bad idea.
>
> I agree, hence the RFC to pick some brains. :-) Would it make sense
> if this call doesn't export the physicall address, but instead takes
> only the dmabuf fd and register offsets to be programmed?
>
> > If you want to do this properly, you need a minimal in-kernel memory
> > manager, and those tend to be based on top of drm_gem.c and merged
> > through the gpu tree. The last place where we accidentally leaked a
> > dma addr for gpu buffers was in the fbdev code, and we plugged that
> > one with
>
> Could you please help me understand how having a in-kernel memory manager
> helps? Isn't it just moving same dmabuf import / paddr export functionality
> in different modules: kernel memory manager vs uio. In fact, Xilinx does have
> such memory manager based on drm gem in downstream. But for this time we took
> the approach of implementing this through generic dmabuf allocator, ION, and
> enabling the import capability in the UIO infrastructure instead.

There's a group of people working on upstreaming a xilinx drm driver
already. Which driver are we talking about? Can you pls provide a link
to that xilinx drm driver?

Thanks, Daniel

> Thanks,
> -hyun
>
> [1] https://github.com/OpenAMP/libmetal/pull/82/commits/951e2762bd487c98919ad12f2aa81773d8fe7859
> [2] https://github.com/Xilinx/embeddedsw/tree/master/XilinxProcessorIPLib/drivers
>
> >
> > commit 4be9bd10e22dfc7fc101c5cf5969ef2d3a042d8a (tag:
> > drm-misc-next-fixes-2018-10-03)
> > Author: Neil Armstrong <narmstrong@baylibre.com>
> > Date:   Fri Sep 28 14:05:55 2018 +0200
> >
> >     drm/fb_helper: Allow leaking fbdev smem_start
> >
> > Together with cuse the above patch should be enough to implement a drm
> > driver entirely in userspace at least.
> >
> > Cheers, Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
