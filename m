From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 2 Aug 2013 09:18:50 -0400
Subject: select statement sort order in arch/arm/Kconfig -- again
In-Reply-To: <20130801170812.GA23006@n2100.arm.linux.org.uk>
References: <20130801170812.GA23006@n2100.arm.linux.org.uk>
Message-ID: <20130802131850.GY5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 06:08:12PM +0100, Russell King - ARM Linux wrote:
> So, we go one kernel release since I fixed the ordering in this file
> after Andrew Morton's complaint about conflicts, and people manage to
> mess up the ordering.  Sorting the stuff in this file is clearly a
> waste of time.
> 
> Not impressed.
> 
> On the plus side, I have a script which sorts these, so it's not
> difficult to put them back into the correct order - that's not the
> point - I _shouldn't_ have to do this.  It's just that it's _EXTRA_
> _UNNECESSARY_ _CHURN_ each time I have to clean up after the fact.

iirc, you had to update the script since you posted it the last time.
Would you mind posting it again?

> 
> --- a/arch/arm/Kconfig	2013-08-01 15:43:46.335784638 +0100
> +++ b/arch/arm/Kconfig	2013-08-01 18:01:52.161928393 +0100
...
> @@ -498,11 +498,11 @@
>  	select CPU_PJ4
>  	select GENERIC_CLOCKEVENTS
>  	select MIGHT_HAVE_PCI
> +	select MVEBU_MBUS
>  	select PINCTRL
>  	select PINCTRL_DOVE
>  	select PLAT_ORION_LEGACY
>  	select USB_ARCH_HAS_EHCI
> -	select MVEBU_MBUS
>  	help
>  	  Support for the Marvell Dove SoC 88AP510
>  
> @@ -512,12 +512,12 @@
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_FEROCEON
>  	select GENERIC_CLOCKEVENTS
> +	select MVEBU_MBUS
>  	select PCI
>  	select PCI_QUIRKS
>  	select PINCTRL
>  	select PINCTRL_KIRKWOOD
>  	select PLAT_ORION_LEGACY
> -	select MVEBU_MBUS
>  	help
>  	  Support for the following Marvell Kirkwood series SoCs:
>  	  88F6180, 88F6192 and 88F6281.
> @@ -527,9 +527,9 @@
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_FEROCEON
>  	select GENERIC_CLOCKEVENTS
> +	select MVEBU_MBUS
>  	select PCI
>  	select PLAT_ORION_LEGACY
> -	select MVEBU_MBUS
>  	help
>  	  Support for the following Marvell MV78xx0 series SoCs:
>  	  MV781x0, MV782x0.
> @@ -540,9 +540,9 @@
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_FEROCEON
>  	select GENERIC_CLOCKEVENTS
> +	select MVEBU_MBUS
>  	select PCI
>  	select PLAT_ORION_LEGACY
> -	select MVEBU_MBUS
>  	help
>  	  Support for the following Marvell Orion 5x series SoCs:
>  	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),

damn.  This block was my fault.

So, it looks like I just volunteered myself to add a check to checkpatch
;-)

sorry,

Jason.
