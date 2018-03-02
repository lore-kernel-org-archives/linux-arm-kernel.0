From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Mar 2018 15:37:36 +0100
Subject: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
In-Reply-To: <ebe7cfe5-e731-10cf-17cd-fe79bee0fdc4@micronovasrl.com>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180301095721.4iga7dcgg566j44m@flea>
 <ebe7cfe5-e731-10cf-17cd-fe79bee0fdc4@micronovasrl.com>
Message-ID: <20180302143736.kkxx54og2ppcmpzh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 12:42:14PM +0100, Giulio Benetti wrote:
> Hi,
> 
> Il 01/03/2018 10:57, Maxime Ripard ha scritto:
> > On Wed, Feb 28, 2018 at 06:53:52PM +0100, Giulio Benetti wrote:
> > >   static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
> > >   	.get_modes	= sun4i_lvds_get_modes,
> > > +	.mode_valid	= sun4i_lvds_mode_valid,
> > >   };
> > 
> > This should be on the encoder, not the connector.
> 
> I've seen it is bound to connector in rgb and to encoder in hdmi.
> Is it correct rgb mode_valid under connector funcs?
> Otherwise I send a patch also for that one.

This would need to be fixed as well. Bridges attach to encoder, not
connectors, so if you ever have a bridge connected to the RGB output
(like on the A13-Olinuxino), mode_valid isn't called at the moment.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/6fed8f63/attachment.sig>
