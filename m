From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 04 Sep 2017 15:26:55 +0200
Subject: [PATCH] video: fbdev: make fb_videomode const
In-Reply-To: <1503761137-25263-1-git-send-email-bhumirks@gmail.com>
References: <CGME20170826152551epcas3p129fba70a978dca27cfe64d86ecefd404@epcas3p1.samsung.com>
 <1503761137-25263-1-git-send-email-bhumirks@gmail.com>
Message-ID: <2256568.NTq7reR8tp@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, August 26, 2017 08:55:37 PM Bhumika Goyal wrote:
> Make these const as they are only passed to a const argument of the
> function fb_find_mode.
> Done using Coccinelle.
> 
> @match disable optional_qualifier@
> identifier s;
> @@
> static struct fb_videomode s = {...};
> 
> @ref@
> position p;
> identifier match.s;
> @@
> s at p
> 
> @good1@
> identifier match.s;
> expression list[5] es;
> position ref.p;
> @@
> fb_find_mode(es,&s at p,...)
> 
> @bad depends on  !good1@
> position ref.p;
> identifier match.s;
> @@
> s at p
> 
> @depends on forall !bad disable optional_qualifier@
> identifier match.s;
> @@
> static
> + const
> struct fb_videomode s;
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
