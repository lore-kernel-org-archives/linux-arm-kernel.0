From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 7 Apr 2012 05:19:33 +0200
Subject: [PATCH 2/2] ARM: at91: Export at91_matrix_base
In-Reply-To: <1333747466-5076-2-git-send-email-joachim.eastwood@jotron.com>
References: <1333747466-5076-1-git-send-email-joachim.eastwood@jotron.com>
 <1333747466-5076-2-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <20120407031933.GC16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:24 Fri 06 Apr     , Joachim Eastwood wrote:
> at91_matrix_* macro's are used by at91_udc usb gadget driver,
> which can be built as module, therefore we need to export the
> variable containing matrix base address.
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> ---
> 
> I didn't get a build error out of this one and I don't understand why.
> If there are some magic I don't understand going on feel free to drop
> this patch.
> 
>  arch/arm/mach-at91/setup.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index a1fcba3..8752d79 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -293,6 +293,7 @@ void __init at91_ioremap_rstc(u32 base_addr)
>  }
>  
>  void __iomem *at91_matrix_base;
> +EXPORT_SYMBOL(at91_matrix_base);
ditto here

Best Regards,
J.
