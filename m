From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 29 Jan 2018 17:01:54 +0200
Subject: [PATCH v1] ARM: pxa/raumfeld: use PROPERTY_ENTRY_U32() directly
In-Reply-To: <20180122125529.6291-1-andriy.shevchenko@linux.intel.com>
References: <20180122125529.6291-1-andriy.shevchenko@linux.intel.com>
Message-ID: <1517238114.7000.1299.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-01-22 at 14:55 +0200, Andy Shevchenko wrote:
> Instead of using PROPERTY_ENTRY_INTEGER() with explicitly supplied
> type,
> use PROPERTY_ENTRY_U32() dedicated macro.
> 
> It will help modify internals of built-in device properties API.
> 
> No functional change intended.
> 

Can someone apply that, or at least Ack? It's needed as a prerequisite
to fix one bug in device property core API.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/arm/mach-pxa/raumfeld.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-
> pxa/raumfeld.c
> index 9d662fed03ec..0bf5419a9d10 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -378,9 +378,9 @@ static struct gpiod_lookup_table
> raumfeld_rotary_gpios_table = {
>  };
>  
>  static const struct property_entry raumfeld_rotary_properties[]
> __initconst = {
> -	PROPERTY_ENTRY_INTEGER("rotary-encoder,steps-per-period",
> u32, 24),
> -	PROPERTY_ENTRY_INTEGER("linux,axis",			 
>  u32, REL_X),
> -	PROPERTY_ENTRY_INTEGER("rotary-encoder,relative_axis",	
>   u32, 1),
> +	PROPERTY_ENTRY_U32("rotary-encoder,steps-per-period", 24),
> +	PROPERTY_ENTRY_U32("linux,axis",		      REL_X),
> +	PROPERTY_ENTRY_U32("rotary-encoder,relative_axis",    1),
>  	{ },
>  };
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
