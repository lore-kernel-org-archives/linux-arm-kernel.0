From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Fri, 12 Jul 2013 14:30:28 +0200
Subject: [PATCH RESEND] video: mxsfb: fix color settings for 18bit data
 bus and 32bpp
In-Reply-To: <20130703085505.GG2969@lukather>
References: <51C01DE1.8030300@digi.com>
 <20130703085505.GG2969@lukather>
Message-ID: <20130712123028.GJ24370@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 10:55:05AM +0200, maxime.ripard at free-electrons.com wrote:
> Hi Jean-Christophe,
> 
> On Tue, Jun 18, 2013 at 10:44:17AM +0200, Hector Palacios wrote:
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
> 
> I don't see this patch in your for-next branch.
> 
> It would be really great to have it for 3.11 if possible.
> 
> Could you take a look at this patch please?

Ping?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/f181e374/attachment.sig>
