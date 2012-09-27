From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 27 Sep 2012 15:38:32 +0200
Subject: ARM: OMAP: fix new sparse warnings
In-Reply-To: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
Message-ID: <506456D8.7020704@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 09/25/12 01:09, Paul Walmsley wrote:
> 
> Commit e54adb1e79762d3591459e5b0e9b9ff578e33fdb ("ARM: OMAP: omap3evm:
> cleanup revision bits") adds a new sparse[1] warning:
> 
> arch/arm/mach-omap2/board-omap3evm.c:90:4: warning: symbol 'get_omap3_evm_rev' was not declared. Should it be static?
> 
> This symbol no longer appears to be used outside this file, so mark it
> static and remove the export.
> 
> Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> debug_card_init() function") results in the following new sparse[1]
> warning:
> 
> arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> 
> Fix by including the proper header file.
> 
> ...
> 
> 1. https://sparse.wiki.kernel.org/index.php/Main_Page

Yeah, my compiler did not emit those... Thanks for the fix!

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
