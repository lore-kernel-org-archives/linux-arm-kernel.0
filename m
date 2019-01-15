Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:43:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A40B2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A6Cgw7hM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A40B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NJjqRBYnZtb+SnUK9r8yRBfmhYS5que1NSn454HGhkY=; b=A6Cgw7hMmR/r1y
	M1diEZPypLqjemrFjGD5Bl5wA74ktK8/ZpFZo7ePEZQATiNRRXbDafpvPaFMo25cgds/Oul7t2qsa
	lvQJV5D6tymcU08v0noR6KaOj+gVmeuz82BUcnDAjLbKmukFhbM/Q4AHtbC1x9atp4ayPRSjB9NZU
	BboE8AIxhjPn+qV/h3ZvuL0YEubq1PfrKSJwhe8nc3lfx0iTK4m9lwN4e8C6LLpFKyKG3fudOtAw1
	KOs/s1cirlR2peZ57XmbxsYESoGz7fFlRejE6/SbnKf1QOlzFHctEcJemB6ps9p6D/Ss6ZSaL/7QW
	PMQBURxc8dOUz9WWKX1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLFR-00018i-Hy; Tue, 15 Jan 2019 09:43:05 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLFN-00017V-TM
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 09:43:03 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 63C4E277A6D
Message-ID: <b02d553717a5aabf6eb3cb4281e03db84a83b60b.camel@collabora.com>
Subject: Re: [PATCH RFC 2/4] media: v4l2-mem2mem: Add an optional job_done
 operation
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@googlegroups.com
Date: Tue, 15 Jan 2019 06:42:37 -0300
In-Reply-To: <20190114133839.29967-3-paul.kocialkowski@bootlin.com>
References: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
 <20190114133839.29967-3-paul.kocialkowski@bootlin.com>
Organization: Collabora
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_014302_208530_86615A1B 
X-CRM114-Status: GOOD (  21.50  )
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
Cc: Alexandre Courbot <acourbot@chromium.org>, Pawel Osciak <pawel@osciak.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Randy Li <ayaka@soulik.info>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-01-14 at 14:38 +0100, Paul Kocialkowski wrote:
> Introduce a new optional job_done operation, which allows calling back
> to the driver when a job is done. Since the job might be completed
> from interrupt context where some operations are not available, having
> a callback from non-atomic context allows performing these operations
> upon completion of a job. This is particularly useful for releasing
> access to a reference buffer, which cannot be done in atomic context.
> 

I'm not exactly sure it makes a lot of sense to review this patch,
since the approach could change.

However, let me point out a few fundamental issues here.
 
> Use the already existing v4l2_m2m_device_run_work work queue for that
> and clear the M2M device current context after calling job_done in the
> worker thread, so that the private data can be passed to the operation.
> 
> Delaying the current context clearing should not be a problem since the
> next call to v4l2_m2m_try_run happens right after that.
> 

Careful here. It's misleading to think an event will happen
"right after". I'd say it's either synchronously, or asynchronously.

It's quite the opposite I'd say, the clearing will happen
"who-knows-when the scheduler picks the thread to run" :-)

Before this patch the curr_ctx was cleared in v4l2_m2m_job_finish,
atomically with the ctx job flags clearing and before waking up
threads waiting in v4l2_m2m_cancel_job.

You are now changing this, by clearing curr_ctx in a worker.
It's perfectly possible that v4l2_m2m_try_schedule will run
before the worker, trying to run with the old context, which
apparently would be safely refused.

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 8 ++++++--
>  include/media/v4l2-mem2mem.h           | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index 631f4e2aa942..d5bccb0192f9 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -376,6 +376,11 @@ static void v4l2_m2m_device_run_work(struct work_struct *work)
>  	struct v4l2_m2m_dev *m2m_dev =
>  		container_of(work, struct v4l2_m2m_dev, job_work);
>  
> +	if (m2m_dev->m2m_ops->job_done && m2m_dev->curr_ctx)
> +		m2m_dev->m2m_ops->job_done(m2m_dev->curr_ctx->priv);
> +
> +	m2m_dev->curr_ctx = NULL;
> +

I don't think you can access this without taking the job spinlock.

>  	v4l2_m2m_try_run(m2m_dev);
>  }
> 

Aside from this, it seems we might need this hook sooner or later.

Thanks,
Eze


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
