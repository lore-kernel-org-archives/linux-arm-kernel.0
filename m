From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Mar 2010 19:24:01 +0000
Subject: board/device file names, and machine names
In-Reply-To: <5fca72811003031108n6d4799cbmf9254ab5d9df69d8@mail.gmail.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
	<5fca72811003031108n6d4799cbmf9254ab5d9df69d8@mail.gmail.com>
Message-ID: <20100303192401.GA4302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 03, 2010 at 02:08:31PM -0500, Theodore Tso wrote:
> This to me is the biggest thing to get right --- if there is deployed
> userspace which is using this name (mahimahi) in the bootloader to boot the
> machine, then changing this means that it adds a barrier to users who want
> to use the standard device userland, but who want to try testing their own
> kernel built from mainline.

Having a wide-ranging rename will be a major barrier to getting code
merged - especially if google intends to keep their internal naming.

It means every patch has to go through a renaming stage to be applied to
both trees - that's absolute madness.

There's still precious little to show in terms of progress on moving
this code towards the mainline tree - let's not put additional barriers
in the way.

Let's keep the current naming and arrange for informative comments in
files about the other names, and use the common name in the Kconfig -
that way it's obvious from the kernel configuration point of view what
is needed to be selected for a given platform, and it avoids the
problem of having effectively two code bases.
