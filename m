From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 15:29:08 +0100
Subject: [PATCH 0/4] RealView boardfile endgame
In-Reply-To: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
References: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5411123.nOOnE7uo7z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 February 2016 14:15:07 Linus Walleij wrote:
> This patch set deletes the RealView board files and moves it
> over to a pure Device Tree boot, deleting ~3500 LoC.
> 
> Prerequisites:
> - The MTD driver patch handling the flash memory write
>   protection and VPP enable must go into the MTD subsystem.
>   http://marc.info/?l=linux-arm-kernel&m=145380689210787&w=2
> 
> - The CLCD device tree support patches (uncontroversial set)
>   must go into the FBDEV subsystem.
>   http://marc.info/?l=linux-fbdev&m=145622172219039&w=2
> 
> - I must queue the device tree patches for the Evaluation
>   Boards and Platform Baseboard and Platform Baseboard
>   Explore before these patches.
> 
> However this is how it will look once the above is in place,
> and it will support everything the kernel already supports
> today.
> 
> Tested on the real hardware for PB1176JZF-S and PB11MPCore.
> Tested on QEMU for 1136, 1176, 11MPCore and Cortex-A9 EB,
> Platform Baseboard for Cortex-A8 and Platform Baseboard Explore
> for Cortex-A9 variants.
> 

Awesome!

This leaves the question whether we should do all the preparation
in 4.6 and then only take these for 4.7, or do them all at
once. I can see good reasons either way, but none of them
particularly strong. What did you have in mind here?

	Arnd
