From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 3 May 2011 02:08:20 +0200
Subject: [PATCH V4 00/23] Create common framework for AT91 device
	initialisation
In-Reply-To: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
References: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <20110503000820.GD2802@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:03 Tue 03 May     , Ryan Mallon wrote:
> Each AT91 variant (AT91RM9200, AT91SAM9260, etc) currently has its own
> devices file, which includes the MMIO address, interrupt
> configuration, GPIO setup, etc for each device. This results in a large
> amount of duplicated code.
> 
> This patch set introduces a framework for adding shared devices for the
> AT91 platform and replaces the multiple device setup implementations for
> each device with single implementations in the new framework. This has
> a net reduction of over 5000 lines of code.
> 
> Each of the arch/arm/mach-at91/*_devices.c files becomes a collection of
> structures (with some initialisation callbacks where necessary) with a
> table of devices which are present on the particular AT91 variant. All
> structures/functions are marked as __init/__initdata so there is little
> additional memory overhead. This also means that the #ifdefs around each
> device can be removed from the *_devices.c files (but remain in the new
> common devices.c file) without overhead.
> 
> This is also a step towards allowing more than one AT91 variant to be
> built into a single kernel by removing duplicate function names across
> the *_devices.c files.
> 
> I have build tested the patch series for all of the  AT91 variants 
> and devices, and have boot tested it on the AT91SAM9G20 (Snapper 9G20
> board) and tested basic device functionality.
> 
> Changes from v1:
>  - Moved __initdata to the end of lines
>  - Fixed at572d940hf EMAC MMIO base
>  - Fixed some whitespace issues
> 
> Changes from v2:
>  - Renamed UART identifiers from AT91_ID_USx to AT91_UART_USx. The
>    AT91_UARTx names are already in use. See patch 12 for more details.
>  - Removed some left over debugging.
> 
> Changes from v3:
>  - Made resource/data allocation dynamic to remove all of the near
>    empty static declarations.
>  - Use arrays when multiple devices exist to reduce code complexity
>  - Fixed indendation on some structures and initialisers 
>  - Fixed some additional bugs
>  - Now removes over 5000 lines of code :-)
> 
> Ryan Mallon (23):
>   at91: Add common devices framework
>   at91: Make Ethernet device common
>   at91: Make USB OHCI/EHCI devices common
>   at91: Make UDC device common
>   at91: Make MMC device common
>   at91: Make NAND device common
>   at91: Make TWI device common
>   at91: Make SPI device common
>   at91: Make TCB device common
>   at91: Make RTT device common
>   at91: Make watchdog device common
>   at91: Make UART devices common
>   at91: Make PWM device common
>   at91: Make SSC device common
>   at91: Make AC97 device common
>   at91: Make LCD controller device common
>   at91: Make touchscreen device common
>   at91: Make HDMAC device common
>   at91: Make RTC device common
>   at91: Make high speed USB gadget device common
>   at91: Make compact flash device common
>   at91: Move at91sam9263 CAN device to common devices
>   at91: Remove mAgic and ISI device code
good patch

I'll send some comment to remove more
and we have issue on some of the api we need to fix first so as I tell you
before we keep in hold until we fix it as they are in confict
suc as GPIO, RTC, TIMERS, clock etc...

Best Regards,
J.
