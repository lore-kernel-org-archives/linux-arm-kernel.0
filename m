From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Dec 2013 10:37:05 -0800
Subject: [PATCHv12 00/49] ARM: TI SoC clock DT conversion
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Message-ID: <20131220183703.GA26054@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [131220 08:36]:
> Hi,
> 
> Hopefully final post of this series. At least this is going to be the last
> post this year as I will be going to x-mas vacation and won't be back before
> Jan 2nd. This time I just sent the patches that have changes in them,
> the missing ones are exactly the same as in v11.
> 
> Changes done:
>  - most of the patches:
>    * Some cosmetic documentation fixes
>  - patch 06:
>    * Changed register pointer types from 'u32 __iomem *' to 'void __iomem *'
>  - patch 07,08,09:
>    * Added check for clk->ll_ops being NULL (happens with statically built
>      clock data), fixes the boot time crash issue noticed by Tony
>  - patch 11:
>    * Moved __clk_of_table extern declaration to clk-provider.h header file...
>      Got flamed about this enough times now. :)
>    * Type for the declaration changed also from array to single entry,
>      and address for this used in code. This prevents compile time error:
>      "array type has incomplete element type". Can't use pointer here either
>      as this messes the address of the table.
>    * ti_clk_retry_init() now has int return type, and checks for kzalloc
>      failure
>  - patch 12, 14, 23:
>    * Added cleanup in case ti_clk_retry_init() fails
>  - patch 17:
>    * Fixed potential memory leak in failed init detected by sparse
>  - patch 18:
>    * Modified commit message to add some details about clockdomains
>  - patch 43:
>    * Changed register pointer types from 'u32 *' to 'void __iomem *'
> 
> Testing done:
> - omap3-beagle: boot, suspend/resume (ret), suspend/resume (off)
> - omap4-panda-es: boot, suspend/resume (ret)
> - omap5-uevm: boot
> - am335x-bone: boot
> - dra7-evm: boot
> 
> Branches available at https://github.com/t-kristo/linux-pm.git:
> - branch: 3.13-rc4-dt-clks-v12 : contains everything, shall me merged last
> - branch: 3.13-rc4-dt-clks-v12-for-mike : drivers/clk changes
> - branch: 3.13-rc4-dt-clks-v11-for-benoit : DT data only (from v11, no changes)

Boots now for me on omap2/3/4, and off-idle works on omap3. So as far as
I'm concerned, please feel free to add my ack to the new and updated patches
still missing it:

Acked-by: Tony Lindgren <tony@atomide.com>
