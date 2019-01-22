Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87D4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7852420844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bMXsXtXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7852420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2vLL7VNZsY71FCb5EpvOejCGi5PGNuw1PaRJLnquYJg=; b=bMXsXtXVv3/dJ0
	yxmmXrCzw6jH8J3uRkEh80V7ZeJ41aSmGY2k2rA8ix5IH+dpQX16lizp0/+vFEq54vMXuslIchQux
	l0+2tOyh0ijCUOCa90RmwWNBps6dQMbhmWNnf2rtnJA0moxM38cU/2JBMbX8hJa05mkvvcb6jYPwF
	M/hNr+UmdnDtiOJlJrYOTvSz+aGbUKFtFEUOmh2frGVxF8j4bgqG+EgeyGSwtahlPUjIbdro8PtnX
	SRI79MxeeeX6H0L+IKMVBXxuv1faKb4eH7KaQTj61PjV3FiYUHGReaz2ctOzq1G1PYFv7aItbU2C2
	0l1H3/EX6E4C4hjpFciQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glt0M-0006OT-BD; Tue, 22 Jan 2019 10:10:02 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glt0I-0006O6-Ke
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 10:10:00 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4B4E9206DC; Tue, 22 Jan 2019 11:09:57 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5E92E20AA4;
 Tue, 22 Jan 2019 11:09:23 +0100 (CET)
Message-ID: <d0729355a4e5e33adae8bacfd67d6623cb2147ce.camel@bootlin.com>
Subject: Re: [PATCH RESEND v5 00/23] drm/sun4i: Support for linear and tiled
 YUV formats with the frontend
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Tue, 22 Jan 2019 11:09:23 +0100
In-Reply-To: <20190118182057.uqohb7nkffgavezi@flea>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
 <20190118182057.uqohb7nkffgavezi@flea>
Organization: Bootlin
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_020958_861964_E663ADE1 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 2019-01-18 at 19:20 +0100, Maxime Ripard wrote:
> On Fri, Jan 18, 2019 at 03:51:10PM +0100, Paul Kocialkowski wrote:
> > This series implements support for YUV formats using the display engine
> > frontend in the sun4i DRM driver, with various fixes along the way.
> > Scaling is supported for every format handled by the frontend.
> > 
> > The tiling mode used by the VPU on Allwinner platforms is also supported
> > by this series and a dedicated fourcc modifier is introduced, along with
> > a specific ioctl for allocating tiled buffers.
> > 
> > New common fourcc helpers are also introduced in this series, especially
> > related to YUV formats.
> > 
> > This was tested on the A33, A20 and A10 platforms and all supported
> > features work properly on them. Framebuffer offsets and source
> > positions are not supported at this point.
> 
> I've applied everything, however I can't see the ioctl you mentionned
> anywhere?

Thanks for the merge! Oops, I should have updated the cover letter more
carefully: this was removed from the series and I didn't come up with
an implementation of the generic ioctl yet.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
