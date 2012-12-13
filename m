From: behanw@websterwood.com (Behan Webster)
Date: Thu, 13 Dec 2012 14:07:57 -0500
Subject: vexpress compilation error in next-20121127
In-Reply-To: <50B56601.5010305@broadcom.com>
References: <50B56601.5010305@broadcom.com>
Message-ID: <50CA278D.4030409@websterwood.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/12 20:16, Markus Mayer wrote:
> Hi Pawel,
>
> There seems to be an issue compiling vexpress at this point. The 
> problem being that vexpress' makefile references reset.o, but there's 
> no reset.c in arch/arm/mach-vexpress.
>
> [...]
>   CC      arch/arm/mach-bcm/board_bcm.o
>   LD      arch/arm/mach-bcm/built-in.o
>   CC      arch/arm/mach-vexpress/v2m.o
> make[1]: *** No rule to make target `arch/arm/mach-vexpress/reset.o', 
> needed by `arch/arm/mach-vexpress/built-in.o'.  Stop.
> make: *** [arch/arm/mach-vexpress] Error 2
Same issue in mainline now too: arch/arm/mach-vexpress/reset.c is missing.

Behan

-- 
Behan Webster
behanw at websterwood.com
