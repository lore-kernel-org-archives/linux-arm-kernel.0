From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Oct 2013 10:49:39 +0100
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131008111913.09bfe93e@armhf>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk> <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
 <CAF6AEGsqGYj7_tZdzrsmUxExs6wm838dYPFhBdc8wqVC6mTxmg@mail.gmail.com>
 <20131008111913.09bfe93e@armhf>
Message-ID: <20131008094939.GD25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:19:13AM +0200, Jean-Francois Moine wrote:
> The Cubox is an open platform, and I use it just like a desktop PC.
> When its required drivers will be in the mainline, I will do the same
> as I do with PCs: I will not recompile a specific kernel each time
> there are kernel bugs or security issues. Instead, I will just upgrade
> my system from my distributor (Debian), and, in the packages, there
> will be a generic mvebu kernel as there is already one for Marvell
> Armada 370/xp, Freescale iMX5x/iMX6 (linux-image-3.10-3-armmp).
> But, for that, all the Cubox specific stuff must be described in a DT.

Which scenario is better:

1. To have something in mainline which is capable of driving the hardware,
   but may need some additional work to make it useful for DT based setups.

or

2. To have nothing.

Now, you may prefer to have nothing, but personally, I prefer there to be
forward progress.  Forward progress means getting some kind of DRM driver
into mainline.  Yes, it may not work with DT setups yet, but - as per
the discussions that have happened _endlessly_ on this topic, it's
something that can be resolved at a later date.

We _still_ haven't worked out how to properly deal with the TDA998x
driver (or indeed any DRM based outputs) in a DT based setup, and all
the time that problem exists, it won't be possible to write a proper
stable DT binding for this.

So please, get off your hobby horse about this and allow us to make some
modicum of progress.
