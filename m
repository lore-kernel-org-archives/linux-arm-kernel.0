Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05278C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:18:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F4D218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K4hmQ7UC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F4D218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2AC4p0gRoq1V0D6Dg7lkc15cfTeJ/98rPsFcOI0Oy0M=; b=K4hmQ7UCr776QP
	xh8eesfSr5qkIiAbSxxnXpSMxhbyeM5oiLRKbe9vP8rRD9DEb0Mnsi4Wu9WSspMZRxNFTjItlN199
	/eDnG13rWY1E/zneqCqu7Ad1ACuGiluAiCNqzhmYQeChYpbs+aBkRsz9b3gMjYvEtg1MUvBLke0zo
	+5nwJ2p0v+0Yopl8N4SbFhkuUQtHNjItVpifv9glO+ZFReZaqWWEuba852ppQQMB7tpbA9qdT51ZY
	EoH6KTd6TcZ390XI/TlcxP6FMYRFqUpddUnvtgjooy7bk/2QmrAZlEW61wt9X+DPoeGNJNS1gRDYB
	6sgN+R3jFcxouEeIdegg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsFPF-00067o-Jw; Fri, 08 Feb 2019 23:18:01 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsFPB-00066w-Po
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 23:17:59 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Feb 2019 15:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; d="scan'208";a="318829222"
Received: from sshumihi-mobl.ccr.corp.intel.com (HELO mara.localdomain)
 ([10.252.20.76])
 by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2019 15:17:51 -0800
Received: from sailus by mara.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@linux.intel.com>)
 id 1gsFP2-0005a0-DG; Sat, 09 Feb 2019 01:17:49 +0200
Date: Sat, 9 Feb 2019 01:17:47 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 3/5] media: sunxi: Add A10 CSI driver
Message-ID: <20190208231746.sjgb7im6xqsawhwz@mara.localdomain>
References: <cover.ba7411f0c7155d0292b38d3dec698e26b5cc813b.1548687041.git-series.maxime.ripard@bootlin.com>
 <c1a7d46f8504decb58ff224b0b5f2f0733282cc6.1548687041.git-series.maxime.ripard@bootlin.com>
 <20190129123949.qdmqnfaym3y42dvj@paasikivi.fi.intel.com>
 <20190206211605.27cq2lxuv3gtyyux@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206211605.27cq2lxuv3gtyyux@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_151757_853062_CAEC50EF 
X-CRM114-Status: GOOD (  27.02  )
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

Hi Maxime,

On Wed, Feb 06, 2019 at 10:16:05PM +0100, Maxime Ripard wrote:
> Hi Sakari,
> 
> Thanks for your review, I have a few questions though, and the rest
> will be addressed in the next version.
> 
> On Tue, Jan 29, 2019 at 02:39:49PM +0200, Sakari Ailus wrote:
> > > +static int csi_notify_complete(struct v4l2_async_notifier *notifier)
> > > +{
> > > +	struct sun4i_csi *csi = container_of(notifier, struct sun4i_csi,
> > > +					     notifier);
> > > +	int ret;
> > > +
> > > +	ret = v4l2_device_register_subdev_nodes(&csi->v4l);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = sun4i_csi_v4l2_register(csi);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return media_create_pad_link(&csi->src_subdev->entity, csi->src_pad,
> > > +				     &csi->vdev.entity, 0,
> > > +				     MEDIA_LNK_FL_ENABLED |
> > > +				     MEDIA_LNK_FL_IMMUTABLE);
> > 
> > This appears to create a link directly from the sensor entity to the video
> > device entity. Is that intentional? I'd expect to see a CSI-2 receiver
> > sub-device as well, which I don't see being created by the driver.
> > 
> > This is indeed a novel proposal. I have some concerns though.
> > 
> > The user doesn't have access to the configured media bus format (reflecting
> > the format on the CSI-2 bus on receiver's side). It's thus difficult to
> > figure out whether the V4L2 pixel format configured on the video node
> > matches what the sensor outputs. Admittedly, we don't have a perfect
> > solution to that whenever the DMA hardware supports multiple V4L2 pixel
> > formats on a single media bus format. We might need to have a different
> > solution for this one, should it be without that receiver sub-device.
> > 
> > Could you add the CSI-2 receiver sub-device, please?
> 
> Even though the name of the controller is *very* confusing, this isn't
> a MIPI-CSI receiver, but a parallel one that supports RGB and BT656
> buses.

Right.

> 
> > > +	csi->pad.flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
> > 
> > Could you make it IMMUTABLE and ENABLED? If there is no need to disable it,
> > that is.
> 
> The link is already created with those flags, and as far as I know it
> doesn't exist for the pads

Oops. And it wasn't even late when I reviewed the patch. :-P Please ignore
the comment --- I agree on the pad flags and the link flags (some lines up)
appear fine, too.

> 
> > > +static int csi_release(struct file *file)
> > > +{
> > > +	struct sun4i_csi *csi = video_drvdata(file);
> > > +	int ret;
> > > +
> > > +	mutex_lock(&csi->lock);
> > > +
> > > +	ret = v4l2_fh_release(file);
> > 
> > v4l2_fh_release() always returns 0. I guess it could be changed to return
> > void. The reason it has int is that it could be used as the release
> > callback as such.
> > 
> > > +	v4l2_pipeline_pm_use(&csi->vdev.entity, 0);
> > > +	pm_runtime_put(csi->dev);
> > > +
> > > +	mutex_unlock(&csi->lock);
> > > +
> > > +	return ret;
> > > +}
> 
> Do you want me to change the construct then?

Please.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
