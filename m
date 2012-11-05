From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Nov 2012 12:03:57 -0700
Subject: [PATCH V3 1/5] ARM: implement debug_ll_io_init()
In-Reply-To: <1350686507-3022-1-git-send-email-swarren@wwwdotorg.org>
References: <1350686507-3022-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50980D9D.7050207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2012 04:41 PM, Stephen Warren wrote:
> When using DEBUG_LL, the UART's (or other HW's) registers are mapped
> into early page tables based on the results of assembly macro addruart.
> Later, when the page tables are replaced, the same virtual address must
> remain valid. Historically, this has been ensured by using defines from
> <mach/iomap.h> in both the implementation of addruart, and the machine's
> .map_io() function. However, with the move to single zImage, we wish to
> remove <mach/iomap.h>. To enable this, the macro addruart may be used
> when constructing the late page tables too; addruart is exposed as a
> C function debug_ll_addr(), and used to set up the required mapping in
> debug_ll_io_init(), which may called on an opt-in basis from a machine's
> .map_io() function.

Patch 1 has been taken into arm-soc, and I've applied patches 2-5 to the
Tegra tree.
