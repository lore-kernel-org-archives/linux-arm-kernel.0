From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 11:35:02 +0200
Subject: mvebu: mbus device tree binding
In-Reply-To: <20130520123153.GA2904@localhost>
References: <20130520123153.GA2904@localhost>
Message-ID: <20130521113502.231a5f38@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Mon, 20 May 2013 09:31:54 -0300, Ezequiel Garcia wrote:

> This does not seem to be hugely problematic, for one could put the
> 'ranges' property only in the per-board files, and remove it from the
> common dtsi.
> 
> Therefore, first of all I'd like to know:
> 
> **1** What's so broken with the current approach that makes us seek for
>       solution, in the form of an mbus DT binding?

Currently, the addresses of the registers to configure the MBUS windows
and get the current values of the DRAM windows (to provide those
values to the device drivers so that they can configure their own DRAM
windows for DMA) are completely hardcoded. See
mach-mvebu/armada-370-xp.h.

For sure, we want those values to move into the Device Tree, just like
for all other peripherals. This is what my original DT binding of the
mvebu-mbus driver was doing, but since the DT binding was not complete,
Arnd suggested to completely remove it, merge the driver without a DT
binding, and think about it later.

So, for sure, we want a DT binding for the mvebu-mbus driver.

> In addition, reading the previous discussion you've had about this, I
> noticed Arnd suggested (and even required) that the mbus binding should
> update the ranges property in the DT blob each time an address window
> is dynamically allocated.
> 
> **2** Why is this required? Who will read the updated ranges
>       information?
>       Why can't the kernel access the mbus API to obtain information
>       about currently allocated windows?

This has already been asked by me in the past, and answered by Arnd at
the end of
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/160923.html.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
