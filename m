From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Oct 2016 21:55:50 +0800
Subject: [PATCH 0/7] ARM: dts: support I2SE Duckbill device
In-Reply-To: <2694949.M3JJFNG6Xz@kerker>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
 <20161024131209.GK30578@tiger> <2694949.M3JJFNG6Xz@kerker>
Message-ID: <20161026135550.GQ30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 09:45:56PM +0200, Michael Heimpold wrote:
> Actually it would even be 11 files for 8 boards, thats right.
> There is no mechanism (no EEPROM, GPIO...) to automatically probe for the 
> device variants, and the "variant-forming daugther boards" are
> not switchable like the expansion boards e.g. for Raspberry Pi.
> Another point is, that this would really require to use U-Boot to apply
> the overlay (or another DT capable bootloader with this functionality).
> For booting very fast, the good old Freescale bootlets are still
> an option, which could not handle the overlays - at least at the moment...
> However, it still an option to have a second look...
> 
> To reduce the number of files, I see the following other approaches:
> - don't use the three "common" files which are included: -3 files (8 total)
> - don't mainline Duckbill EnOcean, Duckbill 485 and Duckbill SPI:
>   they are EOL, only Duckbill 2 variants are still sold;
>   however, since Duckbill (without 2) is/was already mainlined, we
>   should keep this, leaving 4 new variants + 1 old variant: -3 files (5 total)
> - only mainline Duckbill 2 (generic board) and maintain all other variants
>   in a private Github repo (this is what we are doing now): -3 files (2 total)
> 
> So, I'll discuss this again internally. Do you have any preference?

I'm fine with the second one.

Shawn
