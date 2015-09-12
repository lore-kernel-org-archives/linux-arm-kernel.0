From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Sep 2015 15:12:30 +0200
Subject: [PATCH] ARM: pxa: fix DFI bus lockups on startup
In-Reply-To: <1440357237-26713-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sun, 23 Aug 2015 21:13:57 +0200")
References: <1440357237-26713-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <874mizu6gx.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> After the conversion of pxa architecture to common clock framework, the
> NAND clock can be disabled on startup if no nand driver claims it.
>
> In this case, it happens that if the bootloader used the NAND and set
> the DFI arbitration bit, the next access to a static memory controller
> area, such as an ethernet card, the system bus will stall, and the core
> will be stalled forever.
>
> Fix this by clearing the DFI arbritration bit in pxa3xx startup. The bit
> will be enabled the pxa3xx-nand driver on need anyway. The only left
> requirement is that upon pxa3xx-nand removal, the bit should be cleared
> before the clock is disabled.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Queued to pxa/fixes.

-- 
Robert
