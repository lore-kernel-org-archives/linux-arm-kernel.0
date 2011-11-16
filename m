From: simon@sequanux.org (Simon Guinot)
Date: Wed, 16 Nov 2011 11:25:50 +0100
Subject: [PATCH v2] ARM: kirkwood: add LaCie Network Space Lite v2 support
In-Reply-To: <1321433573-3851-1-git-send-email-cvubrugier@lacie.com>
References: <1321433573-3851-1-git-send-email-cvubrugier@lacie.com>
Message-ID: <20111116102549.GF29864@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

On Wed, Nov 16, 2011 at 09:52:53AM +0100, Christophe Vu-Brugier wrote:
> The LaCie Network Space Lite v2 shares most of its characteristics
> with the LaCie Network Space v2.
> 
> Hardware:
>  * CPU: Marvell 88F6192 800Mhz
>  * SDRAM memory: 128 MiB DDR2
>  * Gigabit ethernet: PHY Marvell 88E1318
>  * Flash memory: Macronix MX25L4005A 512 KiB
>  * i2c EEPROM: 512 bytes
>  * 2 USB2 ports: host and host/device
>  * 1 push button
>  * 2 LEDs (red and blue)
> 
> Signed-off-by: Christophe Vu-Brugier <cvubrugier@lacie.com>
> ---
> The patch has been rebased on top of the 'reset' branch. It depends on
> the following commit:
> 
>   2f82cc8 ARM: restart: kirkwood: use new restart hook
> 
> Changes since v1:
>  * reorder machine_desc initializers
>  * use the leds-gpio driver to manage the blue LED
> 
>  arch/arm/mach-kirkwood/Kconfig             |    6 +++
>  arch/arm/mach-kirkwood/Makefile            |    1 +
>  arch/arm/mach-kirkwood/netspace_v2-setup.c |   61 +++++++++++++++++++++++++++-
>  3 files changed, 66 insertions(+), 2 deletions(-)

... snip ...

> @@ -268,6 +313,18 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
>  MACHINE_END
>  #endif
>  
> +#ifdef CONFIG_MACH_NETSPACE_LITE_V2
> +MACHINE_START(NETSPACE_LITE_V2, "LaCie Network Space Lite v2")
> +	.atag_offset	= 0x100,
> +	.map_io		= kirkwood_map_io,
> +	.init_early	= kirkwood_init_early,
> +	.init_irq	= kirkwood_init_irq,
> +	.timer		= &kirkwood_timer,
> +	.init_machine	= netspace_v2_init,
> +	.restart	= kirkwood_restart,
> +MACHINE_END
> +#endif
> +

As suggested by Nicolas, I would have preferred to have a fixed
machine_desc parameter ordering for Kirkwood machines before adding
support for the Lite. Please, could you provide a such patch ?

Except that, this patch looks good to me.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111116/410e8ff5/attachment.sig>
