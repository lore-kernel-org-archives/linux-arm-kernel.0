From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun, 07 Sep 2014 18:40:47 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <540C8577.2070907@gmail.com>
References: <20140905115704.GO13515@arm.com>	<20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
Message-ID: <540C8A8F.5010106@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomasz,

On 09/07/2014 06:19 PM, Tomasz Figa wrote:
> On 07.09.2014 18:12, Javier Martinez Canillas wrote:
>> Clocks is not an issue at least on this machine since the bootloader already
>> passes the clk_ignore_unused parameter to the kernel command line so in that
>> sense there isn't a regression comparing with older kernels. If possible I
>> would prefer to leave this way instead of adding quirks to the clock driver,
>> specially since there are proposed patches to have the display working using
>> the Exynos DRM driver on this machine.
> 
> Well, clk_ignore_unused seems a bit too coarse grained to me. Also
> forcing the user to add it in his bootloader (or any other way) is not
> really the best practice IMHO.
>

Fair enough.

> At least for next 3.17-rc I'd suggest fixing this up in respective clock
> driver and dropping the hack only after Exynos DRM patches are merged
> and confirmed working.
> 

Ok, I'll prepare a patch to add the CLK_IGNORE_UNUSED flag to the needed
clocks in drivers/clk/samsung/clk-exynos5250.c. That will be a more
fine-grained solution since the clk_ignore_unused kernel parameter won't be
needed.

> Best regards,
> Tomasz
> 

Best regards,
Javier
