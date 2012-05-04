From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 May 2012 15:09:19 -0600
Subject: Handling of modular boards
In-Reply-To: <201205042103.34285.arnd@arndb.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205042039.25794.arnd@arndb.de>
 <20120504205441.D293120645E@gemini.denx.de>
 <201205042103.34285.arnd@arndb.de>
Message-ID: <4FA4457F.1010900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 03:03 PM, Arnd Bergmann wrote:
> On Friday 04 May 2012, Wolfgang Denk wrote:
>> There are systems (and I bet it will be a growing number) where U-Boot
>> itself uses the DT for configuration.  Also, there are functions that
>> are needed both by the boot loader and the kernel - for example to
>> dislay a splash screen the boot loader needs to initialize the
>> display, so it must be able to detect which type of LCD is attached
>> (resolution, color-depth, orientation) - the device tree comes in very
>> handy here.  Why should Linux re-do all such things?
> 
> Sure, there are a lot of things that the boot loader can use from the
> device tree, but I'm not sure if the LCD panel connection fits into
> the same category as the devices that Mark was thinking of.

A board I have sitting on my desk right now has separate boards for (and
multiple options for each of):

* Motherboard
* CPU+DRAM
* PMU/PMIC
* Display (LCD)
... and many more.

Interaction with the PMU/PMIC is required for at least some of the boot
media options.

Interaction with the display (LCD) while not technically required to
simply boot the kernel is required by desired use-cases, in order to
display a splash screen ASAP during early boot.

Oh, and the motherboard has a gazillion different HW mux options, which
affect, amongst many other things, which SD/eMMC/SDIO ports are usable
on the motherboard, and which are routed to various daughter boards. I'm
not actually 100% sure if the switches controlling those mux settings
are readable from SW. I certainly hope so...
