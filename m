From: lee@kernel.org (Lee Jones)
Date: Tue, 9 Jun 2015 10:56:28 +0100
Subject: [PATCH v3 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <1433807940-15328-2-git-send-email-eric@anholt.net>
References: <1433807940-15328-1-git-send-email-eric@anholt.net>
 <1433807940-15328-2-git-send-email-eric@anholt.net>
Message-ID: <20150609095628.GP2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Jun 2015, Eric Anholt wrote:

> Unfortunately, the clock manager's registers are not accessible by the
> ARM, so we have to request that the firmware modify our clocks for us.
> 
> This driver only registers the clocks at the point they are requested
> by a client driver.  This is partially to support returning
> -EPROBE_DEFER when the firmware driver isn't supported yet, but it
> also avoids issues with disabling "unused" clocks due to them not yet
> being connected to their consumers in the DT.
> 
> v2: Declare the mutex static (from review by Baruch Siach), merge
>     description and copyright comments.
> 
> v3: Update for new rpi firmware API.  Update the compatible string.
>     Make the firmware handle be under a vendor-namespaced property.
>     Make the DT indices match the firmware clock IDs.  Move the driver
>     under the firmware driver's Kconfig, since it requires it.  Move a
>     container_of() from 2 callers into the callee.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/clk/Makefile          |   1 +
>  drivers/clk/clk-raspberrypi.c | 242 ++++++++++++++++++++++++++++++++++++++++++

This is not an "ARM" patch.

The subject line needs to reflect the subsystem you are submitting to.

`git log --oneline -- <subsystem>`
