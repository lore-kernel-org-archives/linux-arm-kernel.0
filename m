From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 21 Apr 2011 12:02:52 -0500
Subject: [PATCH v2 00/23] at91: Replace duplicate device initialisation
	code	with
In-Reply-To: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D242FBC3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
>
> Each AT91 variant (AT91RM9200, AT91SAM9260, etc) currently has its own
> devices file, which includes the MMIO address, interrupt
> configuration, GPIO setup, etc for each device. This results in a large
> amount of duplicated code.
>
> This patch set introduces a framework for adding shared devices for the
> AT91 platform and replaces the multiple device setup implementations for
> each device with single implementations in the new framework. This has
> a net reduction of nearly 5000 lines of code.
>
> Each of the arch/arm/mach-at91/*_devices.c files becomes a collection of
> structures (with some initialisation callbacks where necessary) with a
> table of devices which are present on the particular AT91 variant. All
> structures/functions are marked as __init/__initdata so there is little
> additional memory overhead. This also means that the #ifdefs around each
> device can be removed from the *_devices.c files (but remain in the new
> common devices.c file) without overhead.
>
> This patch series does not introduce any functional changes to how the
> board files add devices, it only replaces the duplicate device 
> initialisation code with common versions. The patch series attempts to
> have minimum change by rewriting as little as possible of the actual
> device initialisation functions.
>
> This is also a step towards allowing more than one AT91 variant to be
> built into a single kernel by removing duplicate function names across
> the *_devices.c files.
>
> I have build tested the patch series for all of the  AT91 variants 
> and devices, and have boot tested it on the AT91SAM9260 (Snapper 9260
> board) and tested basic device functionality.
>
> Changes from v1:
>  - Moved __initdata to the end of lines
>  - Fixed at572d940hf EMAC MMIO base
>  - Fixed some whitespace issues
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

Ryan,

This one must be still getting held.  Any chance you could send my a copy directly?
I believe there was another party also interested in getting it.

Thanks,
Hartley
