From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 Sep 2016 17:47:56 +0000
Subject: [RFC 1/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <20160908172346.27506-1-netz.kernel@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
Message-ID: <20160908174756.GC12916@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marty,

+ Andrew, Russell,


Since this is your first series, I'll go ahead and gather a few comments
right here:

- Make sure to change the subject line for each patch.

The subject is retrieved from the first line of the commit.  you can
look at the output of 'git log --oneline' to see a nice, concise view of
your series.

- Include 'PATCH' or 'Patch' inside the square brackets on the subject
  line.

When you use the prefix option, as you did, it *replaces* 'PATCH', so
you need '--subject-prefix="RFC PATCH"' or '--subject-prefix="RFC PATCH V2"'

- Please Cc Andrew, Russell and myself on future series.

Personally, I do that at the 'send-email' stage instead of
'format-patch'.  But whichever you prefer.  Don't be shy about Cc'ing.
We all are accustomed to handling lots of email.  It makes it easier for
us to spot stuff we are actively involved in. :-)

thx,

Jason.

On Thu, Sep 08, 2016 at 12:23:40PM -0500, Marty Plummer wrote:
> This is a preparatory series for adding the ARMv5/v6 hi3520 SoCs.
> Assumptions were made when adding hi3620 that don't hold water in
> light of adding support for the hi3520 SoC.  Fix the issue by renaming
> config options and other namespaces to avoid collisions with the new
> work.
> 
> Only internal APIs are modified with this series.
> 
> Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
> ---
>  arch/arm/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index a9693b6..9094ca6 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -280,7 +280,7 @@ choice
>  
>  	config DEBUG_HI3620_UART
>  		bool "Hisilicon HI3620 Debug UART"
> -		depends on ARCH_HI3xxx
> +		depends on ARCH_HI3620
>  		select DEBUG_UART_PL01X
>  		help
>  		  Say Y here if you want kernel low-level debugging support
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
