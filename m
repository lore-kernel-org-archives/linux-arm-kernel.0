From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Jun 2013 00:25:19 -0700
Subject: [PATCHv2 11/11] ARM: OMAP4: register DT clocks and remove old data
In-Reply-To: <1371647942-4811-12-git-send-email-t-kristo@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-12-git-send-email-t-kristo@ti.com>
Message-ID: <20130621072518.GN5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [130619 06:25]:
> Now that the OMAP4 PRCM clock data has been converted to device tree
> representation, it is no longer needed as static clock data. OMAP4
> clock init routine is also changed to register DT clocks first.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/cclock44xx_data.c | 1674 +--------------------------------
>  1 file changed, 38 insertions(+), 1636 deletions(-)

This is nice, thanks for working on this. While at it, can
you also keep your eyes open for the register defines in the
header files we can also drop?

Some of those headers are quite huge.. and should eventually
be private to the related drivers if needed at all with DT.

Regards,

Tony 
