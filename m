From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 17:23:44 +0100
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <alpine.LFD.2.20.1602191106020.13632@knanqh.ubzr>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <3974581.yknKb3tq7o@wuerfel>
 <alpine.LFD.2.20.1602191106020.13632@knanqh.ubzr>
Message-ID: <38246773.SnToSslHuj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 11:10:22 Nicolas Pitre wrote:
> On Fri, 19 Feb 2016, Arnd Bergmann wrote:
> 
> > On Thursday 18 February 2016 11:02:33 Nicolas Pitre wrote:
> > > 
> > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > > 
> > > Is there a way to provide a default for defaults?
...
> > and then select one of the bool symbols from each platform.
> > Would that address your question?
> 
> Yes, but the ugliness factor isn't worth it IMHO.
> 
> I was wondering if something like this was possible:
> 
> config PHYS_OFFSET
>         hex "Physical address of main memory" if MMU
>         default DRAM_BASE if !MMU
>         default 0x10000000 if FOO
>         default 0x20000000 if BAR
>         default 0x30000000 if BAZ
>         default 0x00000000
> 

Ah, that was my previous approach, but Russell didn't like
how it makes it easier to fall back to an incorrect address
instead of forcing a build error when the address is not
configured.

	Arnd
