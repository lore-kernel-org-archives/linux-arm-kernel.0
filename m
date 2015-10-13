From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 13 Oct 2015 13:46:54 -0500
Subject: [PATCH] DT: ARM: pxa: Remove incorrect binding from documentation
In-Reply-To: <1444743846-25873-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1444743846-25873-1-git-send-email-jarkko.nikula@linux.intel.com>
Message-ID: <CAL_Jsq++KpzwCi+7kHTEYhDJb4HkxG=s88f0oe+17ADv2GnGQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 8:44 AM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> Remove "mrvl,lpss-ssp" property from documentation because LPSS SSP type is
> for certain Intel platforms. I believe commit a6e56c28a178
> ("ARM: pxa: ssp: add DT bindings") added it by accident by copying all
> enum pxa_ssp_type types from include/linux/pxa2xx_ssp.h.
>
> Please note this was removed from arch/arm/plat-pxa/ssp.c by the
> commit b692cb83b14d ("ARM: pxa: ssp: Fix build error by removing originally
> incorrect DT binding").
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
> index 669b8140dd79..d10cc06c0c37 100644
> --- a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
> +++ b/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
> @@ -10,7 +10,6 @@ Required properties:
>                                 mvrl,pxa168-ssp
>                                 mrvl,pxa910-ssp
>                                 mrvl,ce4100-ssp
> -                               mrvl,lpss-ssp
>
>         - reg:          The memory base
>         - dmas:         Two dma phandles, one for rx, one for tx
> --
> 2.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
