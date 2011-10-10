From: linux_arm@lakedaemon.net (Jason)
Date: Mon, 10 Oct 2011 07:23:22 -0400
Subject: orion/kirkwood and device tree support
In-Reply-To: <201110091545.55645.michael@walle.cc>
References: <201110091545.55645.michael@walle.cc>
Message-ID: <20111010112322.GJ31288@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend, messed up my email alias.  I'm a dork.  :-(  Apologies.

Michael,

On Sun, Oct 09, 2011 at 03:45:55PM +0200, Michael Walle wrote:
> I submitted a patch to support the Buffalo LS-XHL three months ago, which was 
> rejected because no more old fashioned board setup patches will be merged. 

We have the same situation with the dreamplug (kirkwood based).

> Are there any plans or even ongoing developments to convert these platforms to 
> support device trees?

I'm attempting to, but that requires my learning devicetree.  Which is
fine in and of itself, but it also means I'm learning how Linux supports
arm SoCs.  Which is taking some time.  My current thought process is this:

1.) add arch/arm/mach-kirkwood/board-dt.c, arch/arm/boot/dts/kirkwood.dtsi,
    and arch/arm/boot/dts/kirkwood-dreamplug.dts
2.) fill it in with replacements of calls in common.c and irq.c
3.) get it working cleanly.
4.) add in calls from mpp.c, pcie.c, and cpuidle.c
5.) build arch/arm/boot/dts/kirkwood-*.dts for other boards.

I'd be happy to coordinate and test, although I have no buffalo gear.
And I sure would appreciate some help. ;-)

thx,

Jason.
