From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Oct 2009 17:20:59 -0700
Subject: [PATCH 11/14] omap: Remap L3, L4 to get more kernel io address
	space
In-Reply-To: <20091016234213.2463.61298.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
	<20091016234213.2463.61298.stgit@localhost>
Message-ID: <20091020002059.GZ12576@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091016 16:42]:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> This patch remap L3 and L4 io space to get more kernel address space.
> With this patch, 512 MB of IO space is reclaimed.
> Some more combinations are possible but to make it uniform across
> OMAP24XX, OMAP34XX and OMAP4430, these io combinations are chosen
> 
> Once this is reviewed and tested sufficiently, a documentation entry can
> be created to ease up reading and debugging.
> Like "Documentation/arm/omap/io_map.txt"
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/include/mach/io.h      |   97 ++++++++++++++++++-----------
>  arch/arm/plat-omap/include/mach/vmalloc.h |    2 -
>  2 files changed, 60 insertions(+), 39 deletions(-)
> 

<snip>  
  
> diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/plat-omap/include/mach/vmalloc.h
> index b97dfaf..9eebf62 100644
> --- a/arch/arm/plat-omap/include/mach/vmalloc.h
> +++ b/arch/arm/plat-omap/include/mach/vmalloc.h
> @@ -17,5 +17,5 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
> -#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)
> +#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)

This vmalloc.h change causes issues on omap1. I'll update the series
to ifdef this define.

Then I'll split the file in the later patches into separate
vmalloc.h for mach-omap1 and mach-omap2, see below.

Regards,

Tony
