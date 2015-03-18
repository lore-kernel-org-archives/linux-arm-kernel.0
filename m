From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 18 Mar 2015 21:24:32 +0300
Subject: [PATCHv4 23/35] ARM: OMAP2+: id: cache omap_type value
In-Reply-To: <1426689860-17537-24-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
 <1426689860-17537-24-git-send-email-t-kristo@ti.com>
Message-ID: <5509C2E0.8010705@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/18/2015 05:44 PM, Tero Kristo wrote:

> There is no need to read the register with every invocation of the function,
> as the value is constant. Thus, cache the value in a static variable.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/id.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2a2f4d5..1f5949f 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -52,7 +52,10 @@ EXPORT_SYMBOL(omap_rev);
>
>   int omap_type(void)
>   {
> -	u32 val = 0;
> +	static u32 val = OMAP2_DEVICETYPE_MASK + 1;
> +
> +	if (val < OMAP2_DEVICETYPE_MASK)

    <=, perhaps?

> +		return val;
[...]

WBR, Sergei
