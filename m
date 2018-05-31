From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 31 May 2018 14:52:27 +0200
Subject: [PATCH 0/7] sunxi: Add DT representation for the MBUS controller
In-Reply-To: <20180409092229.ljcnsqgv7wh2s4op@flea>
References: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
 <CAL_Jsq+cURC780ivftY1v3P59g5UKAHwb48raXXB6huQ2KBvuQ@mail.gmail.com>
 <20180409092229.ljcnsqgv7wh2s4op@flea>
Message-ID: <20180531125227.6c4k5glyvvqrf7fo@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 11:22:29AM +0200, Maxime Ripard wrote:
> Hi Rob,
> 
> On Tue, Apr 03, 2018 at 11:03:30AM -0500, Rob Herring wrote:
> > On Tue, Apr 3, 2018 at 8:29 AM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > Hi,
> > >
> > > We've had for quite some time to hack around in our drivers to take into
> > > account the fact that our DMA accesses are not done through the parent
> > > node, but through another bus with a different mapping than the CPU for the
> > > RAM (0 instead of 0x40000000 for most SoCs).
> > >
> > > After some discussion after the submission of a camera device suffering of
> > > the same hacks, I've decided to put together a serie that introduce a
> > > property called dma-parent that allows to express the DMA relationship
> > > between a master and its bus, even if they are not direct parents in the DT.
> > 
> > Reading thru v6 of the camera driver, it seems like having
> > intermediate buses would solve the problem in your case?
> 
> I guess it would yes, but I guess it wouldn't model the hardware
> properly since this seems to be really a bus only meant to do DMA, and
> you're not accessing the registers of the device through that bus.
> 
> And as far as I know, the DT implies that the topology is the one of
> the "control" side of the devices.
> 
> We'll also need eventually to have retrieve the MBUS endpoints ID to
> be able to support perf and PM QoS properly.
> 
> > As Arnd mentioned in that thread, something new needs to address all
> > the deficiencies with dma-ranges and describing DMA bus topologies.
> > This doesn't address the needs of describing bus interconnects.
> > There's been some efforts by the QCom folks with an interconnect
> > binding. They've mostly punted (for now at least) to not describing
> > the whole interconnect in DT and keeping the details in a driver.
> 
> Is it that patch serie? https://lkml.org/lkml/2018/3/9/856
> 
> > On the flip side, this does mirror the established pattern used by
> > interrupts, so maybe it's okay on it's own. I'll wait for others to
> > comment.
> 
> We'll see how it turns out then :)

Ping?

How should we move forward on this?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180531/dc5709d9/attachment.sig>
