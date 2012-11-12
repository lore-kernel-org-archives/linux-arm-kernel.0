From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 12 Nov 2012 11:35:46 +0000
Subject: [PATCH] arm: zynq: add system level control register manager
In-Reply-To: <20121108160125.GA5550@kryptos>
References: <20121031183610.GA2603@thinkbox> <20121108160125.GA5550@kryptos>
Message-ID: <5b1971ea-9ad9-4f58-841e-a3efb7cf905d@CO1EHSMHS022.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

first of all sorry for late answer.

> -----Original Message-----
> From: Josh Cartwright [mailto:joshc at eso.teric.us]
> Sent: Thursday, November 08, 2012 5:01 PM
> To: Daniel Borkmann; Arnd Bergmann
> Cc: Michal Simek; linux-arm-kernel at lists.infradead.org; John Linn; Josh
> Cartwright
> Subject: Re: [PATCH] arm: zynq: add system level control register manager
>
> On Wed, Oct 31, 2012 at 07:36:12PM +0100, Daniel Borkmann wrote:
> > This patch for the Xilinx Zynq ARM architecture adds management of
> > system level control register. The code is taken from the
> > Xilinx-internal Linux Git tree and cleaned up a bit for mainline
> > integration. Besides others, this patch is needed in order to
> > integrate further drivers for Zynq such as the Zynq xemacps networking
> > device driver. The patch is aganst the latest arm-soc tree.
> >
> > Signed-off-by: Daniel Borkmann <daniel.borkmann@tik.ee.ethz.ch>
> > Cc: Michal Simek <michals@xilinx.com>
> > Cc: John Linn <john.linn@xilinx.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
>
> Hey Daniel-
>
> These changes will conflict with my pending clk patchset [1], as I'm introducing
> bindings for the SLCR (and its clk interfaces).
>
> It seems like a hefty chunk of the out-of-tree slcr driver is related to configuring
> MIO.  I think it would be really nice if this driver was reworked to use the pinctrl
> subsystem, and also to provide suitable device tree bindings.

Agree with Josh.

>
> But, at an even higher level, it would be nice to have a coordinated plan for
> getting better Zynq support upstream.  My implicit plan (so
> far) has been:
>
>    1. Initial cleanup [get the thing booting] (done)
>    2. Figure out clk drivers and bindings (pending)

I will comment it today.

>    3. Figure out MIO pinctrl support and bindings (?)

We will look at this topic more closely.

>    4. Adapting out-of-tree peripheral drivers according to 2 & 3 (?)

This will take some time.

>    5. Add support for SMP (?)

I can't see any problem why we shouldn't add this after drivers.
Cleaning mach-zynq can be done in parallel.


>
> Step 4 has a dependency on 2 and 3, of course, the point being that we get those
> into a state where we are happy with them before moving all of the peripherals
> over.  I believe step 5 can be done in parallel to the others.

Ok. Here it is.

Thanks,
Michal



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
