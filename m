From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 19 Feb 2016 11:10:22 -0500 (EST)
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <3974581.yknKb3tq7o@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-5-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181100410.13632@knanqh.ubzr>
 <3974581.yknKb3tq7o@wuerfel>
Message-ID: <alpine.LFD.2.20.1602191106020.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2016, Arnd Bergmann wrote:

> On Thursday 18 February 2016 11:02:33 Nicolas Pitre wrote:
> > 
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > 
> > Is there a way to provide a default for defaults?
> 
> We could have something like
> 
> config PHYS_OFFSET_0
> 	bool
> 
> config PHYS_OFFSET_1
> 	bool
> 
> config PHYS_OFFSET_2
> 	bool
> 
> ... (we need 8 of the 16 possible addresses)
> 
> 
> config PHYS_OFFSET
> 	hex "Physical address of main memory" if MMU
> 	default DRAM_BASE if !MMU
> 	default 0x00000000 if PHYS_OFFSET_0
> 	default 0x10000000 if PHYS_OFFSET_1
> 	default 0x20000000 if PHYS_OFFSET_2
> 	default 0x30000000 if PHYS_OFFSET_3
> 	default 0x70000000 if PHYS_OFFSET_7
> 	default 0x80000000 if PHYS_OFFSET_8
> 	default 0xa0000000 if PHYS_OFFSET_A
> 	default 0xc0000000 if PHYS_OFFSET_C
> 
> 
> and then select one of the bool symbols from each platform.
> Would that address your question?

Yes, but the ugliness factor isn't worth it IMHO.

I was wondering if something like this was possible:

config PHYS_OFFSET
        hex "Physical address of main memory" if MMU
        default DRAM_BASE if !MMU
        default 0x10000000 if FOO
        default 0x20000000 if BAR
        default 0x30000000 if BAZ
        default 0x00000000


Nicolas
