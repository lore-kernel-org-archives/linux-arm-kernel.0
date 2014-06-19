From: robherring2@gmail.com (Rob Herring)
Date: Thu, 19 Jun 2014 09:54:31 -0500
Subject: [PATCH] ARM: mvebu: Fix missing binding documentation for Armada
 38x
In-Reply-To: <1403186871-28204-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403186871-28204-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAL_Jsq+JyngWXvk6ZzV8LPfGqVMDPyouJsADaokAGzgHv=gphQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 9:07 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> For the Armada 380 and Armada 385 SoCs, the common bindings for those
> 2 SoCs, was forgotten. This patch add the documentation for the
> marvell,aramda38x property.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
>
> This fix should be merged in 3.16. For 3.15 I am not sure as it is not
> a regression.
>
> Thanks,
> Gregory
>
>  Documentation/devicetree/bindings/arm/armada-38x.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/armada-38x.txt
> index 11f2330a6554..b68bcb80d2de 100644
> --- a/Documentation/devicetree/bindings/arm/armada-38x.txt
> +++ b/Documentation/devicetree/bindings/arm/armada-38x.txt
> @@ -6,5 +6,9 @@ following property:
>
>  Required root node property:
>
> +compatible: must contain "marvell,armada38x"
> +
> +Required root node property:
> +
>   - compatible: must contain either "marvell,armada380" or
>     "marvell,armada385" depending on the variant of the SoC being used.

This looks a bit strange. How about something like this:

   - compatible: must contain either "marvell,armada380" or
     "marvell,armada385" depending on the variant of the SoC being
used and contain "marvell,armada38x".

Rob
