From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Mar 2012 21:05:45 -0700 (MST)
Subject: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
In-Reply-To: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 6 Mar 2012, Tero Kristo wrote:

> Changes compared to previous version:
> 
> - patch2:
>   * fixed the timeout for waiting for ST_IO_CHAIN == 1
>   * added clear for ST_IO_CHAIN bit (as per spec + implementation in patch 1)
>   * replaced the timeout at the end of function with a simple register
>     readback (timing out on a register value that we are clearing does
>     not make that much sense, the bit is cleared the very first time CPU
>     manages to read it)
> - patch5:
>   * added spinlock for protecting io_chain_trigger operation
> 
> Tested on omap3 beagle + omap4 blaze. Also did measurements for the
> cost of IO chain trigger operation with ARM performance counters:
> 
> - omap3 approx 7...8us
> - omap4 approx 2...4us

Thanks for the changes.  So as you probably already saw, a few changes 
have been made.  The updated series is in the branch 
'io_chain_devel_3.4' on git://git.pwsan.com/linux-2.6.

The main outstanding question is whether the OMAP4 WUCLKOUT poll should be 
removed to match the v5 changes to the OMAP3 function.  Please let me 
know.   Any other testing or comments are of course welcome.


- Paul
