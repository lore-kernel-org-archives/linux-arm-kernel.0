From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 13:53:41 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180125152117.qikemrwl7f35ssjg@flea.lan>
 <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
 <20180126145608.5s6c6ltpvrko7iyv@flea.lan>
 <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
Message-ID: <20180129125341.elup47ymedzxornn@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 26, 2018 at 04:55:54PM +0100, Giulio Benetti wrote:
> > > > > It behaves the same way as A20, so as I mean IO polarity,
> > > > > all signals(except D0-D23), are inverted.
> > > > > For A33 I've used A33-OLinuXino.
> > > > > For A20 our LiNova1.
> > > > 
> > > > Indeed, HSYNC and VSYNC look inverted.
> > > 
> > > Yes, so they should be inverted inside the driver.
> > 
> > Yep. And the LCD panels used on our boards as well in order to avoid
> > any breakages.
> 
> Can you provide a list?
> Or is there a way I can find it on my own?
> I can create a whole patch-set providing this too on panel-simple.c
> Ok?

Grepping through the DT, it seems like there's only the A13 q8 tablet
and the SinA33. The former uses simple-panel, the latter a custom
panel driver.

> > > A little out of thread but:
> > > I'd like to send one for u-boot too,
> > > but this means also to modify every sunxi "sync:3" to "sync:0" and
> > > vice-versa.
> > > 
> > > What do you think?
> > 
> > That it's going to be a nightmare... We've advertised since the very
> > beginning something, and we're about to break it. I'm not sure we want
> > to do that.
> 
> I can take care about that.
> But I also think that a lot of displays work because they use only DE-mode,
> almost ignoring HSync and VSync signals(HV-mode).
> 
> In any case I have to produce these patches because of my company's board
> based on A20 and A33, and modify defconfig according to it.
> The only technical nightmare I see is to produce a commit for every
> defconfig to be modified and copy-paste che commit-log substituing board
> name(1-2 days of work).
> Problem is testing, but we're speaking about something that probably was
> badly working, but you couldn't see it on display.
> So I think this is only an improvement at the end.

It really is a separate discussion, but you would also need to fix all
the environments everywhere, which is simply not feasible.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/884737a3/attachment-0001.sig>
