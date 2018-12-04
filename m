Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E35C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:31:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377E02081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOESdsVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377E02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fouX5/0d9kY90piw0DtXOq9S26DeEAUIzf9aBJ4LV+o=; b=jOESdsVcCNOkS8
	gHt3LP5VfJNVGDuaV5FmKOGtMC2g+vRxWWqUU0KyxH90efo2CK7i0BFWH+yoCwpV//Ef8tYKIfH1M
	er1oQyfRMX/BASlFFpf+WLAifynXN+xBJYS8whmFSEmyZbbXfIPXcsqZ3lyw3+YBKBXyRVFna23nK
	uV4T8dlTLmdnhpbXYLkGrxhyKJl/L7X17Cx2/xyFa10Q/zYTPPAImzQuUYgLM6Q8x57yVfwQvP3XS
	OEvBu69exDBUTeYQb2DAi2eyu3By/nPvBv9fCy4EcfWLrvYiez17/EeODNINphlC7ts/KABLiiolH
	8Tnnz9TeDZe72oX+fI6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAnP-00009A-DB; Tue, 04 Dec 2018 13:31:27 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAnL-00007s-0Z
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:31:25 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E277420711; Tue,  4 Dec 2018 14:31:09 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9ACEC207AD;
 Tue,  4 Dec 2018 14:30:59 +0100 (CET)
Message-ID: <673fa8ed8e43943c29f050fd21954e77789134c3.camel@bootlin.com>
Subject: Re: [PATCH v2 34/43] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Tue, 04 Dec 2018 14:30:59 +0100
In-Reply-To: <20181127092428.z7p4mxnf3jxuqcv7@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-35-paul.kocialkowski@bootlin.com>
 <20181127092428.z7p4mxnf3jxuqcv7@flea>
Organization: Bootlin
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_053123_328454_A8B7D2F5 
X-CRM114-Status: GOOD (  23.55  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 linux-sunxi@googlegroups.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, 2018-11-27 at 10:24 +0100, Maxime Ripard wrote:
> On Fri, Nov 23, 2018 at 10:25:06AM +0100, Paul Kocialkowski wrote:
> > This introduces stride and offset configuration for the VPU tiling mode.
> > Stride is calculated differently than it is for linear formats and an
> > offset is calculated, for which new register definitions are introduced.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 54 ++++++++++++++++++++++++--
> >  drivers/gpu/drm/sun4i/sun4i_frontend.h |  7 ++++
> >  2 files changed, 58 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > index efa1ff0802bd..3f76a5572449 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > @@ -125,21 +125,69 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
> >  {
> >  	struct drm_plane_state *state = plane->state;
> >  	struct drm_framebuffer *fb = state->fb;
> > +	unsigned int strides[3] = {};
> > +
> >  	dma_addr_t paddr;
> >  	bool swap;
> >  
> > +	if (fb->modifier == DRM_FORMAT_MOD_ALLWINNER_TILED) {
> > +		unsigned int width = state->src_w >> 16;
> > +		unsigned int offset;
> > +
> > +		/*
> > +		 * In MB32 tiled mode, the stride is defined as the distance
> > +		 * between the start of the end line of the current tile and
> > +		 * the start of the first line in the next vertical tile.
> > +		 *
> > +		 * Tiles are represented in row-major order, thus the end line
> > +		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
> > +		 * the next vertical tile starts at: 32-bit-aligned-width * 32
> > +		 * and the distance is: 32 * (32-bit-aligned-width - 31).
> > +		 */
> > +
> > +		strides[0] = (fb->pitches[0] - 31) * 32;
> > +
> > +		/* Offset of the bottom-right point in the end tile. */
> > +		offset = (width + (32 - 1)) & (32 - 1);
> 
> Those computations are a bit obscure. I guess adding a bunch of
> defines, and using the round_up / _down and ALIGN macros would help

Fair enough, I will add a more explicit comment and a macro in v3.

> > +		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
> > +			     SUN4I_FRONTEND_TB_OFF_X1(offset));
> > +
> > +		if (fb->format->num_planes > 1) {
> > +			strides[1] = (fb->pitches[1] - 31) * 32;
> > +
> > +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
> > +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> > +		}
> > +
> > +		if (fb->format->num_planes > 2) {
> > +			strides[2] = (fb->pitches[2] - 31) * 32;
> > +
> > +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
> > +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> > +		}
> 
> I guess we could fall in a situation where this is not cleared when
> moving from a format with 3 planes to one with 2 for example. Would
> that break anything?

I have tested this case and nothing breaks so we're good!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
