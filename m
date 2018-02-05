From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Feb 2018 15:21:55 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <51323c6d-ba50-f09e-fcd7-d9b18d03673a@micronovasrl.com>
References: <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180125152117.qikemrwl7f35ssjg@flea.lan>
 <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
 <20180126145608.5s6c6ltpvrko7iyv@flea.lan>
 <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
 <e3a8682c-7524-ee99-8d4f-c492709e6e49@micronovasrl.com>
 <20180201101411.d23efsjt7jdyi4zh@flea.lan>
 <51323c6d-ba50-f09e-fcd7-d9b18d03673a@micronovasrl.com>
Message-ID: <20180205142155.vgd2olchbwzm6a7x@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 05:09:33PM +0100, Giulio Benetti wrote:
> Il 01/02/2018 11:14, Maxime Ripard ha scritto:
> > On Sat, Jan 27, 2018 at 11:07:09PM +0100, Giulio Benetti wrote:
> > > > > > > I don't really know what the polarity of D0 would be just by
> > > > > > > judging at that capture, but we would have noticed if the colors
> > > > > > > were inverted for quite some time now.
> > > > > > 
> > > > > > D0-D23 are correct.
> > > > > > 
> > > > > > With that capture, I mean to show you instead dclk is inverted, as
> > > > > > dclk samples D0 on falling edge.
> > > > > 
> > > > > Ah right, DCLK being the first channel?
> > > > 
> > > > Yes, sorry I didn't place a label on channels
> > > > 
> > > > > 
> > > > > > So 0 is NEGEDGE and 1 is POSEDGE(1/3 of clock phase).
> > > > > > 1/3 clock phase seems enough to me to be considered POSEDGE,
> > > > > > 2/3 instead risks to go too much to the right of D0(even if it
> > > > > > could work).
> > > > > 
> > > > > Do you have captures with both settings?
> > > > 
> > > > Not now, but asap I'm going to take.
> > > 
> > > Here we are:
> > > 1/3 phase: https://pasteboard.co/H4VehON.png
> > > 2/3 phase: https://pasteboard.co/H4Veq8a.png
> > > 
> > > Yellow: D0
> > > Blue: DCLK
> > > 
> > > As you can see:
> > > 1/3 phase has DCLK rising edge almost in the middle of D0
> > > 2/3 phase has DCLK rising edge that comes too late
> > > 
> > > I would go for "1/3 phase" for Rising edge and "normal phase" for
> > > Falling edge.
> > > 
> > > What do you think?
> > 
> > It seems fair. This need a whole lot of comments though :)
> 
> Yes, then, do I proceed resubmitting both corrected patches with corrected
> commit logs?

Yes, please.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180205/0f492f4e/attachment.sig>
