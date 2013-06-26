From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 26 Jun 2013 04:06:31 +0000
Subject: [PATCH 5/5] mmc: omap_hsmmc: Add reg-offset to bindings
 documentation
In-Reply-To: <1372209901-6715-1-git-send-email-joelagnel@ti.com>
References: <1372209901-6715-1-git-send-email-joelagnel@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC43DB1@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 06:55:01, Fernandes, Joel wrote:
> From: Joel A Fernandes <agnel.joel@gmail.com>
> 
> A new reg-offset property was added to account for register offsets
> in some omap-hsmmc's. Document the new property.
> 

Small nitpick

I usually get feedback that any driver DT changes and the associated
Binding doc update should come in one single patch for better readability.

In this case, I believe it would be patch 1/5 & 5/5


Regards, 
Gururaja


> Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 8c8908a..33f4b1e 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -20,6 +20,9 @@ ti,dual-volt: boolean, supports dual voltage cards
>  ti,non-removable: non-removable slot (like eMMC)
>  ti,needs-special-reset: Requires a special softreset sequence
>  ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
> +reg-offset: Supplementing the common reg property (described in bindings/mmc/mmc.txt),
> +some omap-hsmmc's can start an offset from reg but are otherwise identical to others.
> +The registers between start to offset are considered reserved.
>  dmas: List of DMA specifiers with the controller specific format
>  as described in the generic DMA client binding. A tx and rx
>  specifier is required.
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
