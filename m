From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Mon, 14 Jul 2014 17:43:50 -0400
Subject: [PATCH] mach-s3c64xx: Remove all defintions not related to
 regs-clocks
In-Reply-To: Your message of "Mon, 14 Jul 2014 14:14:24 -0400."
 <1405361664-5210-1-git-send-email-xerofoify@gmail.com>
References: <1405361664-5210-1-git-send-email-xerofoify@gmail.com>
Message-ID: <36350.1405374230@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jul 2014 14:14:24 -0400, Nicholas Krause said:
> This patch addresses the fix me message in this file that states to
> remove all definitions not related to reg-clocks in this header
> file.
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/include/mach/regs-clock.h | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)

> -#endif /* _PLAT_REGS_CLOCK_H */
> +/#endif /* _PLAT_REGS_CLOCK_H */

You're kidding us, right? Given that this was obviously *not* compile
tested at all, why should we believe that in fact all those #defines
are in fact no longer used?

Hint: There's a very high chance that somebody stuck that FIXME in there rather
than just cleaning it up themselves precisely *because* it was still in use in
an inconvenient to fix place in the tree..

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/99d5cb05/attachment.sig>
