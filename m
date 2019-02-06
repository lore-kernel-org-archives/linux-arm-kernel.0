Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE4DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D17218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nv2UMJc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D17218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ARyR7W78Y5g4qlMs+JsqTEUQsk237KQOkN9M6tBduZg=; b=Nv2UMJc3V3pEZ5
	aQKuvpAn4yLYkaN2RgO/QVQtIF5YUVNM6poqGlQQ0dcHrDxSe513hFAQOQ7Yy4jKKdvm4oSYltC11
	cI/9OglTBZCVux+usx0gpfFt74cyCf3S3ULz2OfOWD+FqRLIUDn/YHkagilQmzcgmhPUW7alPRl8c
	TlSX30UIwc2FTCdR4nEryuHN7WXmQjOetmKYGIg6Oeek+saqCJkxcqylJja7UW5qYAs00A0D7FDPI
	rV0PiwhYCBYS7hjgaF2UPqFjdm+nY3dN02BPRDh7gSejeZKqaTLXQsrrTlKrkbkk20T3uC1mogXmq
	vLz27eaTMYymhsT80rSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grUYQ-0004LP-OJ; Wed, 06 Feb 2019 21:16:22 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grUYM-00044q-5X
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 21:16:20 +0000
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1E9AE240007;
 Wed,  6 Feb 2019 21:16:05 +0000 (UTC)
Date: Wed, 6 Feb 2019 22:16:05 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 3/5] media: sunxi: Add A10 CSI driver
Message-ID: <20190206211605.27cq2lxuv3gtyyux@flea>
References: <cover.ba7411f0c7155d0292b38d3dec698e26b5cc813b.1548687041.git-series.maxime.ripard@bootlin.com>
 <c1a7d46f8504decb58ff224b0b5f2f0733282cc6.1548687041.git-series.maxime.ripard@bootlin.com>
 <20190129123949.qdmqnfaym3y42dvj@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129123949.qdmqnfaym3y42dvj@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_131618_517464_E7E6180A 
X-CRM114-Status: GOOD (  21.77  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sakari,

Thanks for your review, I have a few questions though, and the rest
will be addressed in the next version.

On Tue, Jan 29, 2019 at 02:39:49PM +0200, Sakari Ailus wrote:
> > +static int csi_notify_complete(struct v4l2_async_notifier *notifier)
> > +{
> > +	struct sun4i_csi *csi = container_of(notifier, struct sun4i_csi,
> > +					     notifier);
> > +	int ret;
> > +
> > +	ret = v4l2_device_register_subdev_nodes(&csi->v4l);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = sun4i_csi_v4l2_register(csi);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return media_create_pad_link(&csi->src_subdev->entity, csi->src_pad,
> > +				     &csi->vdev.entity, 0,
> > +				     MEDIA_LNK_FL_ENABLED |
> > +				     MEDIA_LNK_FL_IMMUTABLE);
> 
> This appears to create a link directly from the sensor entity to the video
> device entity. Is that intentional? I'd expect to see a CSI-2 receiver
> sub-device as well, which I don't see being created by the driver.
> 
> This is indeed a novel proposal. I have some concerns though.
> 
> The user doesn't have access to the configured media bus format (reflecting
> the format on the CSI-2 bus on receiver's side). It's thus difficult to
> figure out whether the V4L2 pixel format configured on the video node
> matches what the sensor outputs. Admittedly, we don't have a perfect
> solution to that whenever the DMA hardware supports multiple V4L2 pixel
> formats on a single media bus format. We might need to have a different
> solution for this one, should it be without that receiver sub-device.
> 
> Could you add the CSI-2 receiver sub-device, please?

Even though the name of the controller is *very* confusing, this isn't
a MIPI-CSI receiver, but a parallel one that supports RGB and BT656
buses.

> > +	csi->pad.flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
> 
> Could you make it IMMUTABLE and ENABLED? If there is no need to disable it,
> that is.

The link is already created with those flags, and as far as I know it
doesn't exist for the pads

> > +static int csi_release(struct file *file)
> > +{
> > +	struct sun4i_csi *csi = video_drvdata(file);
> > +	int ret;
> > +
> > +	mutex_lock(&csi->lock);
> > +
> > +	ret = v4l2_fh_release(file);
> 
> v4l2_fh_release() always returns 0. I guess it could be changed to return
> void. The reason it has int is that it could be used as the release
> callback as such.
> 
> > +	v4l2_pipeline_pm_use(&csi->vdev.entity, 0);
> > +	pm_runtime_put(csi->dev);
> > +
> > +	mutex_unlock(&csi->lock);
> > +
> > +	return ret;
> > +}

Do you want me to change the construct then?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
