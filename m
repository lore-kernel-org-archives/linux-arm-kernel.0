Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C8C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:27:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455DE218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kvlmln0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455DE218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BpITwwieVWGfXcUsonRsz3Q6hoImlnoMY9fIV9TRVgA=; b=Kvlmln0p93IcEz
	WX+U0J6qjusPAMZWtHG6EOdl+cpd+1mZZq9pseHmEauwnAIeY72Nwe9R/cjb0ykSF7qlttELVomG5
	S7BbdCONZewqhursK3np5ln564jq/OQ2wrVL8/GDKDtyhkbUOMN+qGTGBRu4Yd1H/WP8kiTOvc705
	uza3XdkxyQ2XmSGkmnIN5Tgl3x/dO8wSkokQOUg+bls/KAR+DvVMWRHxah42nPFdkzk4+WAugVKHM
	HIQaSZ8QFJfnWyNYFqNj3irpC70A/WzT8IM1MobrT99g5o6JLW7Ti70ybsJ1KEXoQYF+0JUT2e6E7
	S8gQO83zRy3dh9nZF5IQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkee-0002Hb-Gk; Thu, 07 Feb 2019 14:27:52 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkea-0002G9-Uc
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:27:51 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C6759E000A;
 Thu,  7 Feb 2019 14:27:32 +0000 (UTC)
Date: Thu, 7 Feb 2019 15:27:32 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 3/4] drm/sun4i: dsi: Add burst support
Message-ID: <20190207142732.skae6ux6dyvjptyf@flea>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <1416f6a45cf6da7ea28e17becd5f257a49746e04.1548236066.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64hXpS3-QZDMjcmkR9HsNBf1E-S5AVjWBjNbCPs7nt1Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGb2v64hXpS3-QZDMjcmkR9HsNBf1E-S5AVjWBjNbCPs7nt1Pg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_062749_289834_55E9EF31 
X-CRM114-Status: GOOD (  26.16  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Feb 06, 2019 at 02:28:39AM +0800, Chen-Yu Tsai wrote:
> > +static u16 sun6i_dsi_get_drq_edge1(struct sun6i_dsi *dsi,
> > +                                  struct drm_display_mode *mode,
> > +                                  u16 line_num)
> > +{
> > +       struct mipi_dsi_device *device = dsi->device;
> > +       unsigned Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> > +       unsigned hbp = mode->htotal - mode->hsync_end;
> 
> Allwinner's hbp is actually horizontal back porch plus sync pulse.
> So this should be
> 
>     hbp = mode->htotal - mode->hsync_start;

So I've tested this and it actually adds a margin on the left side of
the panel, which seems to indicate that one of the porches isn't
right. I've applied Jagan's patches to fix the backporch and front
porch inversions, and it doesn't fix anything, so even though I don't
really know why, this seems to be the actual backporch.

It's really hard to tell without a DSI analyzer though, but that's not
really affordable...

> > +       u16 edge1;
> > +
> > +
> > +       edge1 = SUN6I_DSI_SYNC_POINT;
> > +       edge1 += mode->hdisplay + hbp + 20;
> > +       edge1 = edge1 * Bpp / device->lanes;
> 
> Compared to the A64 BSP, this seems to be incorrect. The original code was
> 
>     edge1 = sync_point +
>                 (panel->lcd_x + panel->lcd_hbp + 20) *
>                 dsi_pixel_bits[panel->lcd_dsi_format] /
>                 (8 * panel->lcd_dsi_lane);
> 
> Note that sync_point is outside of the parentheses and should not be
> multiplied and divided.
> 
> This would make sense if sync_point is a fixed delay that is needed
> regardless of the timings.

Good catch, thanks!

> > -       if ((mode->hsync_end - mode->hdisplay) > 20) {
> > +               regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
> > +                            SUN6I_DSI_BURST_DRQ_EDGE0(edge0) |
> > +                            SUN6I_DSI_BURST_DRQ_EDGE1(edge1));
> > +
> > +               regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
> > +                            SUN6I_DSI_BURST_LINE_NUM(line_num) |
> > +                            SUN6I_DSI_BURST_LINE_SYNC_POINT(SUN6I_DSI_SYNC_POINT));
> > +
> > +               tcon0_drq = SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
> > +       } else if ((mode->hsync_end - mode->hdisplay) > 20) {
> >                 /* Maaaaaagic */
> >                 u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
> 
> This and the above if clause should use hsync_start instead of hsync_end.
> 
> The A64 BSP specifies drq = vfp - 20.

Indeed, I'll fix it.

> >  #define HSA_PACKET_OVERHEAD    10
> > -       hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> > -                 (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
> > -
> > -       /*
> > -        * The backporch is set using a blanking packet (4 bytes +
> > -        * payload + 2 bytes). Its minimal size is therefore 6 bytes
> > -        */
> > +               hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> > +                         (mode->hsync_end - mode->hsync_start) * Bpp -
> > +                         HSA_PACKET_OVERHEAD);
> 
> I believe for all these packets, that minimum value is not needed. The
> WC field of the long command packet refers to the length of the payload
> only. The payload is used to pad the packet to the desired length, but
> is otherwise useless. Likewise, the CRC value is only calculated against
> the payload.
> 
> Specifying a minimum means you are likely skewing the timings.

This code was here already, but it's a valid point. I'm not sure what
the DSI spec tells in that case. I'll have a look.

> >  #define HFP_PACKET_OVERHEAD    6
> > -       hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> > -                 (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
> > -
> > -       /*
> > -        * hblk seems to be the line + porches length.
> > -        */
> > -       hblk = mode->htotal * Bpp - hsa;
> > -
> > -       /*
> > -        * And I'm not entirely sure what vblk is about. The driver in
> > -        * Allwinner BSP is using a rather convoluted calculation
> > -        * there only for 4 lanes. However, using 0 (the !4 lanes
> > -        * case) even with a 4 lanes screen seems to work...
> > -        */
> > -       vblk = 0;
> > +               hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> > +                         (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
> > +
> > +               /*
> > +                * hblk seems to be the line + porches length.
> > +                */
> > +               hblk = mode->htotal * Bpp - hsa;
> 
> Based on the timing diagram in section 8.11 of the MIPI DSI spec, hblk is
> supposed to take up the remainder of the scan line after the sync event or
> sync pulse during the vertical inactive period. It is the BLLP portion.
> This seems like the correct value, though it is somewhat simplified.
> The packet overhead is gone (cancelled out with the one from hsa).

I actually found out that Allwinner tells that it's the total - the
sync pulse - the blank overhead (so 10 bytes).

I'll update it.

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
