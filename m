From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 26 Jan 2013 10:20:11 +0530
Subject: [RFC PATCH] ARM: mm: Fix alloc_init_section bug on LPAE
In-Reply-To: <1359160318-27068-1-git-send-email-chris@cloudcar.com>
References: <1359160318-27068-1-git-send-email-chris@cloudcar.com>
Message-ID: <51036083.4040407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Saturday 26 January 2013 06:01 AM, Christoffer Dall wrote:
> When using LPAE the call to alloc_init_pte is passed then end address
> for the entire 1st level page table region, and the code unluckily ends
> up going over the bounds of the single allocated PTE, which is sad.
>
> This caused LPAE boot on omap5 to crash.
>
> There may be some hidden mystery in the boot code that I'm unaware of
> or it may be assumed that all mappings are always mappable as sections
> on LPAE and therefore omap5 just does something bad, in which case this
> patch isn't the right fix, but I'd be happy to be told the reason.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jeremy C. Andrus <jeremya@cs.columbia.edu>
> Signed-off-by: Christoffer Dall <chris@cloudcar.com>
> ---

I was about to reply on the LPAE boot issue you mentioned in other
email. We have seen couple of issues with LPAE on OMAP5 and sent the
fixes.

[1] ARM: LPAE: Fix alloc_init_section to flush all the pmd entries
[2] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned addresses

Both needs ack from Catalin and RMK's ok to get into the patch system.

Can you please check if they work for you ?  I expect the [1] should
make your board boot on OMAP5.

Regards
Santosh

[1] https://patchwork.kernel.org/patch/1278031/

[2] https://patchwork.kernel.org/patch/1472031/
