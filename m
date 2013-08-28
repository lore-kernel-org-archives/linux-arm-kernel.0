From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 28 Aug 2013 13:15:48 +0200
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <521DD057.4040208@gmail.com>
References: <20130828113459.48ecbb34@armhf> <521DCD33.2070008@gmail.com>
 <20130828121943.1c8327ca@skate> <521DD057.4040208@gmail.com>
Message-ID: <20130828131548.0009d613@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Wed, 28 Aug 2013 12:26:31 +0200, Sebastian Hesselbarth wrote:

> >> as Mark Brown already took the bindings patch for above generic
> >> compatible, how are we going to discriminate different
> >> implementations/features of Dove, Kirkwood, and Armada 370?
> >
> > I agree that mvebu-audio is not a really good compatible string. It
> > should use the first SoC that introduced the IP block, so that if
> > future SOCs have variations, we can introduce separate compatible
> > strings.
> >
> > So for now, the compatible string should be kirkwood-audio.
> 
> Unfortunately, mvebu-audio has already been taken by Mark. Also, we
> know the differences for the three SoCs now and should have a compatible
> for each (and maybe mvebu-audio for fallback).

For 3.12, right? So 3.12 hasn't been released yet, so it's still time
to fix this.

> Also, we'll need to distinguish between the different audio controllers
> on a single SoC, i.e. i2s0 and i2s1. I suggest checking the (phys) reg
> base passed.

For what reason does the driver needs to know whether it's the instance
0 or instance 1 ? If it's needed for some specific reason, then there
should probably be something like marvell,i2s-channel-id = <0> and
marvell,i2s-channel-id = <1>.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
