From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 01 Aug 2017 14:46:09 +0200
Subject: [PATCH] video: xilinxfb: constify fb_fix_screeninfo and
 fb_var_screeninfo structures
In-Reply-To: <20170708012416.GA1843@embeddedgus>
References: <CGME20170708012420epcas4p3f5cc06fb74847c659e28a80d405f77a0@epcas4p3.samsung.com>
 <20170708012416.GA1843@embeddedgus>
Message-ID: <3588026.hdL4GfIT2C@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 07, 2017 08:24:16 PM Gustavo A. R. Silva wrote:
> These structures are only used to copy into other structures,
> so declare them as const.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct fb_fix_screeninfo i at p = { ... };
> 
> @ok@
> identifier r.i;
> expression e;
> position p;
> @@
> e = i at p
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct fb_fix_screeninfo e;
> @@
> e at i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct fb_fix_screeninfo i = { ... };
> 
> The semantic patch for fb_var_screeninfo is analogous.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
