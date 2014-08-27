From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 15:01:11 -0700
Subject: [PATCH 1/2] ARM: pxa: dts: fix mmc controller compatible string
In-Reply-To: <1408009573-24523-1-git-send-email-zonque@gmail.com>
References: <1408009573-24523-1-git-send-email-zonque@gmail.com>
Message-ID: <CAOesGMh6sc7U6XRjGWBUPszaD9K66Ek=3xdMyGdh7bEAMXVG4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 2:46 AM, Daniel Mack <zonque@gmail.com> wrote:
> The vendor prefix was renamed from "mrvl" to "marvell". Follow this
> change in the dts file.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/boot/dts/pxa2xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
> index febd391..f188f8c 100644
> --- a/arch/arm/boot/dts/pxa2xx.dtsi
> +++ b/arch/arm/boot/dts/pxa2xx.dtsi
> @@ -128,7 +128,7 @@
>                 };
>
>                 mmc0: mmc at 41100000 {
> -                       compatible = "mrvl,pxa-mmc";
> +                       compatible = "marvell,pxa-mmc";

It seems that the driver was changed without consideration to
backwards compatibility. The driver should still handle both the old
and the new prefix (since we keep this a stable ABI). The old one
should be deprecated but still accepted.

I.e. this is an OK change, but it's fine to hold off as a cleanup
until 3.18. The driver has a regression though, that needs to be fixed
for 3.17.


-Olof
