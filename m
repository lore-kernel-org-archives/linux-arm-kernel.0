From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 10:59:10 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod data: Fix wrong lostcontext_mask
 for OMAP4 l4_abe
In-Reply-To: <507D20F2.9060007@ti.com>
References: <507D20F2.9060007@ti.com>
Message-ID: <20121016175909.GZ15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [121016 01:56]:
> The following commit added the support for the lostcontext_mask
> along with the usage of the flag for l4_abe.
> 
>  commit ce80979aedfce937926a8dd40a1f92fd4bc2fd53
>  Author: Tero Kristo <t-kristo@ti.com>
>  Date:   Sun Sep 23 17:28:19 2012 -0600
> 
>     ARM: OMAP4: hwmod data: add support for lostcontext_mask
> 
> Unfortunately, the l4_abe does not contain this memory and thus
> cannot contain that flag.
> 
> Remove the flag from the l4_abe hwmod.
> 
> Change as well the mask for omap44xx_aess_hwmod to avoid missing
> the status in case LOSTMEM_AESSMEM is set. The AESS logic does
> not support retention and thus only the memory state is useful.
> It is even mandatory to avoid a crash in the case of the AESS
> resume.
> 
> TBD: Ideally each hwmod should contain an extra entry for memory
> context attached to it. The AESS does contain only one, but some
> IP like the IVAHD does have three memories with dedicated status.
> The granularity is never used, but at least one global information
> for all the memory banks is useful.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>

Thanks applying into omap-for-v3.7-rc1/fixes-part2.

Regards,

Tony
