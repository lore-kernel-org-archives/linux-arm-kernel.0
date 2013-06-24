From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 24 Jun 2013 10:42:04 +0300
Subject: [PATCHv2 06/11] CLK: omap: move part of the machine specific
 clock header contents to driver
In-Reply-To: <20130621073250.GO5523@atomide.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-7-git-send-email-t-kristo@ti.com>
 <20130621073250.GO5523@atomide.com>
Message-ID: <51C7F84C.5080607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 10:32 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [130619 06:25]:
>> Some of the clock.h contents are needed by the new OMAP clock driver,
>> including dpll_data and clk_hw_omap. Thus, move these to the generic
>> omap header file which can be accessed by the driver.
>
> Do you mean "are only needed by the new OMAP clock driver"?

Not only, it is needed by both driver and mach-omap2.

> Otherwise it sounds like this will break things for other
> omaps that don't yet have clocks configured in DT..

No it doesn't, as you can probably see, the new include/linux/clk/omap.h 
is included from clock.h also.

-Tero

>
> Regards,
>
> Tony
>
