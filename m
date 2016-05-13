From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 13 May 2016 14:40:31 +0300
Subject: [PATCH 18/23] ARM: dts: lager: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-19-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
 <1463126163-29423-19-git-send-email-geert+renesas@glider.be>
Message-ID: <749bd9bd-aeb9-49fe-b1f9-31da008ae696@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/13/2016 10:55 AM, Geert Uytterhoeven wrote:

> Warning (unit_address_vs_reg): Node /keyboard/button at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /keyboard/button at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /keyboard/button at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /keyboard/button at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /fixedregulator at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /regulator at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c at 8 has a unit name, but no reg property
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 749ba02b6a53a9de..c01e27868083147a 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
[...]
> @@ -119,7 +119,7 @@
>  		};
>  	};
>
> -	fixedregulator3v3: fixedregulator at 0 {
> +	fixedregulator3v3: fixedregulator3v3 {

    Likewise, could you drop "fixed"?

[...]

MBR, Sergei
