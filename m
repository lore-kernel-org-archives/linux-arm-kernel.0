From: monstr@monstr.eu (Michal Simek)
Date: Wed, 13 Feb 2013 17:21:10 +0100
Subject: [PATCH 1/4] clocksource: pass DT node pointer to init functions
In-Reply-To: <1360264144-20714-2-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
 <1360264144-20714-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAHTX3dKLCbfhBaHKBE=fVTcRReVL6yotA9e_8S70bH+_gajL5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/7 Rob Herring <robherring2@gmail.com>:
> From: Rob Herring <rob.herring@calxeda.com>
>
> In cases where we have multiple nodes of the same type, we may need the
> node pointer to know which node was matched. Passing the node pointer
> also keeps the init function from having to match the node a 2nd time.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: John Stultz <johnstul@us.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/clocksource/clksrc-of.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Michal Simek <michal.simek@xilinx.com>

The rest is just the same as I have done. Any option to add these
patches to v3.9?
Because I need these patches for zynq timer because we have two in the soc.
Is it OK to register several clock source and clockevent devices?

btw: there is still one issue because you can just setup only one
compatibility string.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
