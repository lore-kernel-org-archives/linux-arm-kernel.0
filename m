From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 14:42:01 -0600
Subject: [PATCH 1/4] ARM: OMAP2+: Add board-generic.c entry for ti81xx
In-Reply-To: <20150119191833.GC18552@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-2-git-send-email-tony@atomide.com>
 <54B67461.9010402@cogentembedded.com>
 <20150115000713.GV2419@atomide.com>
 <20150119191833.GC18552@atomide.com>
Message-ID: <20150119204201.GQ20386@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 11:18:34AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150114 16:14]:
> > * Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [150114 05:54]:
> > > Hello.
> > > 
> > > On 1/14/2015 2:37 AM, Tony Lindgren wrote:
> > > 
> > > >This allows booting ti81xx boards with with when a .dts
> > > 
> > >    So, with, with or when? :-)
> > 
> > Heh thanks will updated to:
> > 
> > This allows booting ti81xx boards when a .dts file
> > is in place.
> 
> This too needs to be in a separate ifdef CONFIG_SOC_TI81XX block
> to avoid make randconfig build errors. Updated patch below.
> 
> Regards,
> 
> Tony
> 
> 8< -----------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 19 Jan 2015 10:38:07 -0800
> Subject: [PATCH] ARM: OMAP2+: Add board-generic.c entry for ti81xx
> 
> This allows booting ti81xx boards when a .dts file
> is in place.
> 
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -142,6 +142,42 @@ DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flattened Device Tree)")
>  	.dt_compat	= am3517_boards_compat,
>  	.restart	= omap3xxx_restart,
>  MACHINE_END
> +
> +static const char *const ti814x_boards_compat[] __initconst = {

should this definition be within that ifdef too ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/6dad440b/attachment.sig>
