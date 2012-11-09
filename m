From: danborkmann@iogearbox.net (Daniel Borkmann)
Date: Fri, 9 Nov 2012 10:49:07 +0100
Subject: [PATCH] arm: zynq: add system level control register manager
In-Reply-To: <20121108160125.GA5550@kryptos>
References: <20121031183610.GA2603@thinkbox>
	<20121108160125.GA5550@kryptos>
Message-ID: <CAD6jFUQC+HPCT11_nWckUkhzgQtPkxLcqcTxbVb==kFmwCaTwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 5:01 PM, Josh Cartwright <joshc@eso.teric.us> wrote:
> On Wed, Oct 31, 2012 at 07:36:12PM +0100, Daniel Borkmann wrote:
>> This patch for the Xilinx Zynq ARM architecture adds management of system
>> level control register. The code is taken from the Xilinx-internal Linux
>> Git tree and cleaned up a bit for mainline integration. Besides others,
>> this patch is needed in order to integrate further drivers for Zynq such as
>> the Zynq xemacps networking device driver. The patch is aganst the latest
>> arm-soc tree.
>>
>> Signed-off-by: Daniel Borkmann <daniel.borkmann@tik.ee.ethz.ch>
>> Cc: Michal Simek <michals@xilinx.com>
>> Cc: John Linn <john.linn@xilinx.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> These changes will conflict with my pending clk patchset [1], as I'm
> introducing bindings for the SLCR (and its clk interfaces).

Oops, okay. Then your's has priority, of course.

> It seems like a hefty chunk of the out-of-tree slcr driver is related to
> configuring MIO.  I think it would be really nice if this driver was
> reworked to use the pinctrl subsystem, and also to provide suitable
> device tree bindings.

Agreed. If there's a chance to help with further Zynq integration and
to develop this driver with testing on Qemu for ARM Zynq, I'd like to
give it a try. (The board is a bit expensive as a hobby only.)

> But, at an even higher level, it would be nice to have a coordinated
> plan for getting better Zynq support upstream.  My implicit plan (so
> far) has been:
>
>    1. Initial cleanup [get the thing booting] (done)
>    2. Figure out clk drivers and bindings (pending)
>    3. Figure out MIO pinctrl support and bindings (?)
>    4. Adapting out-of-tree peripheral drivers according to 2 & 3 (?)
>    5. Add support for SMP (?)
>
> Step 4 has a dependency on 2 and 3, of course, the point being that we
> get those into a state where we are happy with them before moving all of
> the peripherals over.  I believe step 5 can be done in parallel to the
> others.
>
> Arnd-
>
> At a high level, does this sound like a suitable plan of action?  Is
> there something else you would like to see from those of us working on
> Zynq support?
>
> Thanks,
>    Josh
>
> 1: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/129295.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
