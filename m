From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Aug 2013 11:19:26 +0200
Subject: [PATCHv3 1/3] video: mxsfb: fix color settings for 18bit data
 bus and 32bpp
In-Reply-To: <51FB6F51.7090500@ti.com>
References: <1375346437-18991-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375346437-18991-2-git-send-email-maxime.ripard@free-electrons.com>
 <51FB6F51.7090500@ti.com>
Message-ID: <20130802091926.GR2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 11:35:29AM +0300, Tomi Valkeinen wrote:
> On 01/08/13 11:40, Maxime Ripard wrote:
> > From: Hector Palacios <hector.palacios@digi.com>
> > 
> > For a combination of 18bit LCD data bus width and a color
> > mode of 32bpp, the driver was setting the color mapping to
> > rgb666, which is wrong, as the color in memory realy has an
> > rgb888 layout.
> > 
> > This patch also removes the setting of flag CTRL_DF24 that
> > makes the driver dimiss the upper 2 bits when handling 32/24bpp
> > colors in a diplay with 18bit data bus width. This flag made
> > true color images display wrong in such configurations.
> > 
> > Finally, the color mapping rgb666 has also been removed as nobody
> > is using it and high level applications like Qt5 cannot work
> > with it either.
> > 
> > Reference: https://lkml.org/lkml/2013/5/23/220
> > Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> > Acked-by: Juergen Beisert <jbe@pengutronix.de>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/video/mxsfb.c | 26 --------------------------
> >  1 file changed, 26 deletions(-)
> 
> This one is labeled as "fix". Should it got to v3.11?

It would be better yes. Otherwise, 3.12 will do.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/7d50883f/attachment.sig>
