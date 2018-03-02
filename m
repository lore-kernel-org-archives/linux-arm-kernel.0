From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Mar 2018 09:12:36 +0100
Subject: [PATCH v2 06/16] drm/sun4i: Don't process LVDS if TCON doesn't
 support it
In-Reply-To: <5333678.QYsGi30oEL@jernej-laptop>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <20180227222701.9716-7-jernej.skrabec@siol.net>
 <20180228073608.r2zd3qkiudm2uarm@flea>
 <5333678.QYsGi30oEL@jernej-laptop>
Message-ID: <20180302081236.zlt52z6jjsglzk3i@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 28, 2018 at 10:43:30PM +0100, Jernej ?krabec wrote:
> Dne sreda, 28. februar 2018 ob 08:36:08 CET je Maxime Ripard napisal(a):
> > On Tue, Feb 27, 2018 at 11:26:51PM +0100, Jernej Skrabec wrote:
> > > TCON checks for LVDS properties even if it doesn't support it. Add a
> > > check to skip that part of the code if TCON doesn't support channel 0.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > I have already sent a similar patch here:
> > https://lists.freedesktop.org/archives/dri-devel/2018-February/166665.html
> 
> Right. However, check last chunk in my patch. There is no need to call 
> sun4i_rgb_init() if TCON doesn't support channel 0. It doesn't do anything, 
> except producing warning. Will you add that this change to your patch and then 
> I can remove this patch from next revision?

They are orthogonal to me though. Mine fixes the spurious LVDS error
messages that you were mentionning in your commit log. Your point here
is that we shouldn't need to even register the LVDS and RGB output
when there's no channel 0. This is obviously true, but it should be in
a separate patch.

> BTW, your patch won't apply cleanly, since you didn't base it on latest code 
> (every TCON variant has at least one entry now).

I'll fix it when applying.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/addc48ec/attachment-0001.sig>
