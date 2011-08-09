From: linux_arm@lakedaemon.net (Jason)
Date: Tue, 9 Aug 2011 14:10:31 -0400
Subject: [PATCH 2/3 v2] RFC: arm/kirkwood: add dreamplug support.
In-Reply-To: <87ei0uebut.fsf@lebrac.rtp-net.org>
References: <cover.1312906908.git.jason@lakedaemon.net>
	<cover.1312906908.git.jason@lakedaemon.net>
	<6b9e805f5765939fc844d5a9cd02ad141aa6af00.1312906908.git.jason@lakedaemon.net>
	<87ei0uebut.fsf@lebrac.rtp-net.org>
Message-ID: <20110809181031.GJ20071@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 07:25:14PM +0200, Arnaud Patard wrote:
> Jason Cooper <jason@lakedaemon.net> writes:
> > Copied guruplug-setup.c and did s/guruplug/dreamplug/g.  Then, switched
> > to SPI based NOR flash.  LED pins are correct.
> 
> Why don't use modify guruplug.c instead and use some if (machine_is_*)
> tests to handle the differences like what was done for openrd ? I find
> it quite wasteful to add a new machine file while (I guess) it should be
> easier to modify existing code.

Interesting, I hadn't looked carefully at openrd.  Thanks for the
pointer.  In my grand plan, there will be a boot/dts/kirkwood.dtsi, and
then a boot/dts/kirkwood-dreamplug.dts and, hopefully, a single
mach-kirkwood/board-dt.c ...  This patch [2/3] was left in because it
was the legacy way of doing things, at it works.  I wanted to show my
thought process (wrong and right) for migrating dreamplug to devicetree.
Dreamplug hasn't made it into mainline yet, because it isn't devicetree.

If I can get it right, migrating the other mach-kirkwood/*-setup.c
should be simply boot/dts/kirkwood-*.dts

thx,

Jason. 
