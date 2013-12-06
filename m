From: mlweber1@rockwellcollins.com (mlweber1 at rockwellcollins.com)
Date: Thu, 5 Dec 2013 21:32:40 -0600
Subject: Moschip MCS8142 SoC
In-Reply-To: <201312060331.31958.arnd@arndb.de>
References: <OF433D4F00.CB35F8E7-ON86257C37.004F3E8D@rockwellcollins.com>
 <201312060331.31958.arnd@arndb.de>
Message-ID: <OF1C2A9619.4A882547-ON86257C39.0011D73C-86257C39.00137859@rockwellcollins.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> wrote on 12/05/2013 08:31:31 PM:

> From: Arnd Bergmann <arnd@arndb.de>
> To: linux-arm-kernel at lists.infradead.org, Jonas Jensen 
> <jonas.jensen@gmail.com>
> Cc: mlweber1 at rockwellcollins.com, Florian Fainelli <florian@openwrt.org>
> Date: 12/05/2013 08:31 PM
> Subject: Re: Moschip MCS8142 SoC
> 
<snip>

> Florian Fainelli (now on Cc) did the patch series for MCS814x in the 
past,
> see http://lwn.net/Articles/507006/. As far as I understand, MCS8140
> and MCS8142 only differ in the CPU core, so the required code is 
actually
> almost identical.
> However, I would now recommend doing the port on the latest kernel 
version,
> i.e. 3.13 at this point, for which you would not be able to reuse
> much of the code, as we have redone all the interfaces to make it 
simpler
> to add a new platform. Essentially you add separate drivers to 
> drivers/irqchip, drivers/clocksource, drivers/clk, 
arch/arm/include/debug
> and drivers/pci/host but won't need any actual code in arch/arm/mach-* 
any
> more at this point.

The newer FPGA SoC arch(s) we've been working with recently have been 
using 
that.  Nice and clean so I definitely agree that's the way to go. 
Originally
I was hoping that I could get an initial build with 3.3 just to get past 
my
current bug/issue we're working to resolve.... We'll see.

> 
> Jonas Jensen is working on support for the "moxart" platform, which uses
> the same fa526 core and which is similar in other regards, so I'd 
recommend
> looking at his code as examples for how to do this the right way.

Thanks, I'll take a look at (http://lwn.net/Articles/554101/).  I guess in 

some ways this would at least get my chip booting past the initial arch 
related asm stuff and if my DT is setup with the right serial port, the 
console should at least show some output until it dies.

Matt
