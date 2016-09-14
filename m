From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 14:36:39 +0200
Subject: [PATCH V2 4/4] ARM64 LPC: support earlycon for UART connected to
 LPC
In-Reply-To: <6e890161-0cd8-6027-f4e5-a222ceddd597@gmail.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <7585762.SZVHZyJdka@wuerfel> <6e890161-0cd8-6027-f4e5-a222ceddd597@gmail.com>
Message-ID: <2263975.sR08tijMiD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 7:26:22 PM CEST zhichang wrote:
> 
> > 
> >> Hip06 LPC uart need two base addresses for earlycon.
> >> 2. the IO type is mmio to introduce a memory base address to access LPC register file. But the real uart
> >> IO type is UPIO_PORT. This is spcial...
> > 
> > This sounds like a deficiency in the of_setup_earlycon() function,
> > which can only handle MMIO addresses, and won't actually
> > be able to understand nodes without a "ranges" property like
> > you have here.
> > 
> Yes.
> The current of_setup_earlycon only support MMIO and the first reg property must be memory.
> 
> We can not support our LPC uart without any new code.
> But we can implement a private earlycon setup function and register
> it to the __earlycon_table, things will be ok.

I still think you should adapt of_setup_earlycon instead to handle IORESOURCE_IO
registers.

	Arnd
