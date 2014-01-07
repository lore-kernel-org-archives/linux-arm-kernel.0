From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 07 Jan 2014 10:18:05 +0100
Subject: [PATCH 4/5] fb: Add DCU framebuffer driver for Vybrid VF610
 platform
In-Reply-To: <87eh4laqse.fsf@nbsps.com>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
 <1373609276-14566-5-git-send-email-b18965@freescale.com>
 <20130729111457.GB3029@pengutronix.de> <87eh4laqse.fsf@nbsps.com>
Message-ID: <1389086285.4244.3.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 06.01.2014, 13:50 -0500 schrieb Bill Pringlemeir:
> > On Fri, Jul 12, 2013 at 02:07:55PM +0800, Alison Wang wrote:
> >> The Display Controller Unit (DCU) module is a system master that
> >> fetches graphics stored in internal or external memory and displays
> >> them on a TFT LCD panel. A wide range of panel sizes is supported
> >> and the timing of the interface signals is highly configurable.
> >> Graphics are read directly from memory and then blended in real-time,
> >> which allows for dynamic content creation with minimal CPU intervention.
> 
> On 29 Jul 2013, s.hauer at pengutronix.de wrote:
> 
> > Maybe the real question is whether we want to introduce another
> > framebuffer driver at all instead of making it a DRM driver.
> 
> I didn't understand this comment at first.  I thought that the DRM
> infra-structure had changed or something.  I see a recent post on
> IMX-DRM and I think there is a mis-conception on the Vybrid SOC.
> 
> At first, Freescale was to incorporate a Vivante GC355 GPU for OpenVG.
> However, this was removed from the design and is only present on some
> 'Automotive' parts, and not the VF610 nor the Tower boards.  These SOCs
> only have a multi-level framebuffer with alpha blending.  Was it meant
> that this be part of the DRM?  It seems that the hardware without the
> 'Vivante GC355 GPU' is best served by an fb driver.  

Exactly the multi-level part of the hardware should preferably be
programmed through the standardized plane stuff in the KMS userspace
interface, which is part of DRM.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
