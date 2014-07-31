From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 1 Aug 2014 01:51:13 +0200
Subject: [PATCH v3] Documentation: devicetree: Fix tps65090 typos in
 example
In-Reply-To: <1406755767-5910-1-git-send-email-afaerber@suse.de>
References: <1406755767-5910-1-git-send-email-afaerber@suse.de>
Message-ID: <CABxcv==gNo84M7uFK04MiJp=Wn-n3uS4xH3QzxMNoKuOirH0VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On Wed, Jul 30, 2014 at 11:29 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Specification and existing device trees use vsys-l{1,2}-supply,
> not vsys_l{1,2}-supply. Fix the example to match the specification.
>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 21d2202158e9 ("mfd: tps65090: add DT support for tps65090")
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3:
>  * Added Fixes header
>  * + regulator and mfd maintainers
>
>  v1 -> v2:
>  * More verbose commit message (requested by Mark Rutland)
>
>  Documentation/devicetree/bindings/regulator/tps65090.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/tps65090.txt b/Documentation/devicetree/bindings/regulator/tps65090.txt
> index 340980239ea9..ca69f5e3040c 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65090.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65090.txt
> @@ -45,8 +45,8 @@ Example:
>                 infet5-supply = <&some_reg>;
>                 infet6-supply = <&some_reg>;
>                 infet7-supply = <&some_reg>;
> -               vsys_l1-supply = <&some_reg>;
> -               vsys_l2-supply = <&some_reg>;
> +               vsys-l1-supply = <&some_reg>;
> +               vsys-l2-supply = <&some_reg>;
>

True, these also matches the .supply_name used when registering the
LDO[1-2] regulators in the tps65090 driver. So clearly the example was
wrong while the property specification is correct.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
