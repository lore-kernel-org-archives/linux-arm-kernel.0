Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C872BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:31:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC320818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pX94RSaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=04sb1f+VaBbeBhvja2l34wpMy5ZcV3dPQyels8/An3E=; b=pX94RSaXPnm0Yp
	nKfxPsk7zmkftTTC5ANQTUoLRq8Mh//Sh/H7+bdE6/Wtd+a/kvFK/nAGJl9hAUMkYu5i2ox0mvElr
	uccQ7NVaESMzQ171wKIurqdZfXcPh7Rf/SR5S9ecv/S+ii3/z7R3q79ZjH9lXPm/46LiiCVSZRH3O
	swuRVT1hXTKnAvZLGar5J4i/Jpfa9YONpsd0/xnu1uAKek5nDHnzvTIBiZcAbnTsyU00MUWgW3yqb
	/0sFrdO66yCizZLWean6NEo++SdW/ASaPK+AKwBVKFZmCUTOQUsNaWuYt0ZvAwlOeudy8TRfN+fOv
	pTlaaam2QAz152qsXqvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDAP-0004At-Ji; Thu, 14 Feb 2019 09:18:49 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDAL-00049l-EX
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:18:47 +0000
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7751024000F;
 Thu, 14 Feb 2019 09:18:38 +0000 (UTC)
Message-ID: <0b6bd0f8f1ad67e85e00127dbf1b2c7e78efbfd0.camel@bootlin.com>
Subject: Re: [PATCH] media: cedrus: Forbid setting new formats on busy queues
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@googlegroups.com
Date: Thu, 14 Feb 2019 10:18:38 +0100
In-Reply-To: <3b24ac73-f891-533f-8563-fe38ba4a83ca@xs4all.nl>
References: <20190214083731.16230-1-paul.kocialkowski@bootlin.com>
 <3b24ac73-f891-533f-8563-fe38ba4a83ca@xs4all.nl>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_011845_665464_1A6A20AD 
X-CRM114-Status: GOOD (  15.55  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Thu, 2019-02-14 at 09:59 +0100, Hans Verkuil wrote:
> On 2/14/19 9:37 AM, Paul Kocialkowski wrote:
> > Check that our queues are not busy before setting the format or return
> > EBUSY if that's the case. This ensures that our format can't change
> > once buffers are allocated for the queue.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/staging/media/sunxi/cedrus/cedrus_video.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> > index b5cc79389d67..3420a938a613 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> > @@ -282,8 +282,15 @@ static int cedrus_s_fmt_vid_cap(struct file *file, void *priv,
> >  {
> >  	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
> >  	struct cedrus_dev *dev = ctx->dev;
> > +	struct vb2_queue *vq;
> >  	int ret;
> >  
> > +	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> > +	if (!vq)
> > +		return -EINVAL;
> 
> Can this ever happen?

I guess not, or something would be very wrong.
I have seen this check around when looking at how other drivers
implement this, but it does seem overkill.

Should I get rid of it in v2?

Cheers,

Paul

> Regards,
> 
> 	Hans
> 
> > +	else if (vb2_is_busy(vq))
> > +		return -EBUSY;
> > +
> >  	ret = cedrus_try_fmt_vid_cap(file, priv, f);
> >  	if (ret)
> >  		return ret;
> > @@ -299,8 +306,15 @@ static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
> >  				struct v4l2_format *f)
> >  {
> >  	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
> > +	struct vb2_queue *vq;
> >  	int ret;
> >  
> > +	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> > +	if (!vq)
> > +		return -EINVAL;
> > +	else if (vb2_is_busy(vq))
> > +		return -EBUSY;
> > +
> >  	ret = cedrus_try_fmt_vid_out(file, priv, f);
> >  	if (ret)
> >  		return ret;
> > 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
