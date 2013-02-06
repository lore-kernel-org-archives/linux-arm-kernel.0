From: johannes.d.braun@gmail.com (Johannes Braun)
Date: Wed, 6 Feb 2013 17:43:20 +0100
Subject: Freescale imx35 kernel 3.6, no kernel boot messages
Message-ID: <20130206174320.0ac0c863@jobraun>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear mailing list,

currently I`m trying to port the DENX 3.6 stable kernel for the flea3
board from carmedialabs. The board is based on a Freescale imx35
processor. Therefore I had a look at Stefano Bacics fork in the DENX
git repo, where I found a branch for the flea3 board. Compiling the
kernel required a modification of arch/arm/mach-imx/mach-flea3.c where
I had to replace .boot_params against .atag_offset in MACHINE_START.
Know my problem is that I can't see kernel boot messages. The boot uart
is uart2. So it has to be ttymxc2. 

The machine id is also added to arch/arm/tools/mach-types.h
+flea3 MACH_FLEA3 FLEA3 3668

After the message:
Uncompressing Kernel Image ... OK
the board is completly silent and I can`t see any boot messages.

But the kernel does not hang. I checked it with a bdi3000. When I step
through the start_kernel() function, there are some printk outputs.
These outputs are reached, but nothing is show via uart2.

As I read, newer kernels like 3.6 are using the common clk framework.
Do I have to enable the clock for the uart2 in
arch/arm/mach-imx/clk-imx35.c via clk_prepare_enable(clk[uart2_gate])?
I checked this, but had no success. 

DEBUG_LL is disabled.

In uboot I didn`t change anything. ttymxc2 is configured in the
bootparams. All the parameters are the same as with the 3.0.0 kernel.

Did someone had success running a kernel greater than 3.0 on a
freescale imx35 board?

Best regards
Johannes
