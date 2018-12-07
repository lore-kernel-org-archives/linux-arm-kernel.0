Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1619EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:42:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC70E208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="edSnSLx8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TNNk0N6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC70E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QIds5XKhzwpT54E+g8xdj/swxA7cVa/kt+p+RBoKPaU=; b=edSnSLx8mNDi65
	8t2SbVyx/RWaF4Y8hcy7xcr3LNJSKUtZ1RtfJpbieRobt29O169Gf5Tys1ThumncWw7XoqTa50iN0
	Md8dz78rs7QZfeStboBXuykqaSlNejXQgOuCoObF2+ZuL/tCyQJ2ArY7JlE5358cymuJ8+h74LPDf
	kMeh9v+PX4gVSwIFBa9z/wQFhLv8F7dFOg+qWGCVeMzbgqSo7z84EcTseZdoANdOUpIy9hL2GY98d
	lGPw9cm7c7Oq6qhy73Ynx8iIMmkl/RksNhPmX0YVJT8Y37tUS+WqcBG2pae7VwPdLIlhUIlgT0rog
	et2vldHMbgeXPbbYtP5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGOF-0007qM-W5; Fri, 07 Dec 2018 13:42:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGOE-0007pv-EW
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 13:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4tMBBj+0C+iJd2F6ACxvnEgAwII0WaYiOyCUwY8ub5U=; b=TNNk0N6H80YctNJDGeaUH+Qyk/
 j3Yj6H5Tnpldcy1Ck6KtIHE2i9jdN5RTYFFD7xKYLKFB3o7H/M+VP6UhBc5fofoTFNImGhQNPToj6
 WfBYdUfjjrb5xSRvIYYWw+S+yCExBLxsvaBakXPYEkSMQ4UWfJwF5bU6YDUGqYglFdysNgz64uyXo
 /8GDIyw87mhdkW2YSrQRTVpCpf3krYJbKRWH8F9LterzHL+EDJduS1ujU5hYN66djZOXlapE8rCbj
 ief8Dd22vHwE0+tVdQu8IuYwlQHULsdJFARmusS+icwNs4uCvszP8yTI01Fo/jXpeTZnFAlpShm5K
 Bvl3areQ==;
Received: from [179.95.33.236] (helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGOC-0002Oy-2z; Fri, 07 Dec 2018 13:41:56 +0000
Date: Fri, 7 Dec 2018 11:41:50 -0200
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2] media: cedrus: don't initialize pointers with zero
Message-ID: <20181207114150.2dc93fb6@coco.lan>
In-Reply-To: <c426c7ea8159349f3cc23bf7d65d2c24f2ade00e.camel@bootlin.com>
References: <9db60f061d1c577f14136f81af641f58bccbead3.1544187795.git.mchehab+samsung@kernel.org>
 <c426c7ea8159349f3cc23bf7d65d2c24f2ade00e.camel@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Fri, 07 Dec 2018 14:21:44 +0100
Paul Kocialkowski <paul.kocialkowski@bootlin.com> escreveu:

> Hi,
> 
> On Fri, 2018-12-07 at 08:03 -0500, Mauro Carvalho Chehab wrote:
> > A common mistake is to assume that initializing a var with:
> > 	struct foo f = { 0 };
> > 
> > Would initialize a zeroed struct. Actually, what this does is
> > to initialize the first element of the struct to zero.
> > 
> > According to C99 Standard 6.7.8.21:
> > 
> >     "If there are fewer initializers in a brace-enclosed
> >      list than there are elements or members of an aggregate,
> >      or fewer characters in a string literal used to initialize
> >      an array of known size than there are elements in the array,
> >      the remainder of the aggregate shall be initialized implicitly
> >      the same as objects that have static storage duration."
> > 
> > So, in practice, it could zero the entire struct, but, if the
> > first element is not an integer, it will produce warnings:
> > 
> > 	drivers/staging/media/sunxi/cedrus/cedrus.c:drivers/staging/media/sunxi/cedrus/cedrus.c:78:49:  warning: Using plain integer as NULL pointer
> > 	drivers/staging/media/sunxi/cedrus/cedrus_dec.c:drivers/staging/media/sunxi/cedrus/cedrus_dec.c:29:35:  warning: Using plain integer as NULL pointer
> > 
> > As the right initialization would be, instead:
> > 
> > 	struct foo f = { NULL };  
> 
> Thanks for sharing these details, it's definitely interesting and good
> to know :)

Yeah, that's something that was bothering for quite a while, as I've
seen patches using either one of the ways. It took me a while to
do some research, and having it documented at the patch helps, as
we should now handle it the same way for similar stuff :-)

> 
> > Another way to initialize it with gcc is to use:
> > 
> > 	struct foo f = {};
> > 
> > That seems to be a gcc extension, but clang also does the right thing,
> > and that's a clean way for doing it.
> > 
> > Anyway, I decided to check upstream what's the most commonly pattern.
> > The "= {}" pattern has about 2000 entries:
> > 
> > 	$ git grep -E "=\s*\{\s*\}"|wc -l
> > 	1951
> > 
> > The standard-C compliant pattern has about 2500 entries:
> > 
> > 	$ git grep -E "=\s*\{\s*NULL\s*\}"|wc -l
> > 	137
> > 	$ git grep -E "=\s*\{\s*0\s*\}"|wc -l
> > 	2323
> > 
> > Meaning that developers have split options on that.
> > 
> > So, let's opt to the simpler form.  
> 
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!

> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  drivers/staging/media/sunxi/cedrus/cedrus.c     | 2 +-
> >  drivers/staging/media/sunxi/cedrus/cedrus_dec.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> > index b538eb0321d8..b7c918fa5fd1 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> > @@ -75,7 +75,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
> >  	memset(ctx->ctrls, 0, ctrl_size);
> >  
> >  	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
> > -		struct v4l2_ctrl_config cfg = { 0 };
> > +		struct v4l2_ctrl_config cfg = {};
> >  
> >  		cfg.elem_size = cedrus_controls[i].elem_size;
> >  		cfg.id = cedrus_controls[i].id;
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > index e40180a33951..f10c25f5460e 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > @@ -26,7 +26,7 @@ void cedrus_device_run(void *priv)
> >  {
> >  	struct cedrus_ctx *ctx = priv;
> >  	struct cedrus_dev *dev = ctx->dev;
> > -	struct cedrus_run run = { 0 };
> > +	struct cedrus_run run = {};
> >  	struct media_request *src_req;
> >  	unsigned long flags;
> >    



Thanks,
Mauro

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
