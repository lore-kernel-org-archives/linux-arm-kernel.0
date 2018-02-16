From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Feb 2018 16:50:49 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <e5d49c13-9b8f-d597-508c-10fed5300769@micronovasrl.com>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180207103905.mtyzgu73mmifyvvj@flea>
 <653f0438-c55a-02a5-dffb-2ee8e6d9ef4a@micronovasrl.com>
 <20180208204043.mqryuqhx7a6z4v3b@flea>
 <e5d49c13-9b8f-d597-508c-10fed5300769@micronovasrl.com>
Message-ID: <20180216155049.r2mc724nfluwrrbe@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 07:05:56PM +0100, Giulio Benetti wrote:
> > If so, and if remember the captures properly, the sampling would occur
> > right before the rise, and not really around the fall.
> > 
> > Would 2/3 be better here?
> 
> Yes, you're right, 2/3 phase is better:
> 
> 1/3 phase: https://pasteboard.co/H4VehON.png
> 2/3 phase: https://pasteboard.co/H4Veq8a.png
> 
> Take a look at the bit in middle(yellow) sampled by clock(blue).
> 
> Rising edge is almost in the middle of D0 bit.
> 
> > 
> > > According to scope captures above on both A20 and A33.
> > > Unfortunately I don't have other boards for the other SoCs to take captures.
> > > 
> > > What do you think?
> > 
> > I guess we can make that part applicable to all SoCs, we haven't seen
> > any significant differences on those part.
> 
> So let's keep:
> - As normal(rising edge) => IO_POL_REG "0x2 => 2/3 phase"
> - As inverted(falling edge) => IO_POL_REG "0x0 => normal phase"

I was actually thinking 1/3 for rising, 2/3 for falling.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180216/af2ccffd/attachment.sig>
