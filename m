From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 13 Oct 2017 21:14:59 +0200
Subject: [PATCH] nvmem: meson: use generic compatible
In-Reply-To: <20171012152450.12454-1-jbrunet@baylibre.com>
References: <20171012152450.12454-1-jbrunet@baylibre.com>
Message-ID: <CAFBinCBVNEqTk+NUHz62FetLhYagFb5K+g17P_2Xb7sBUfEmdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Thu, Oct 12, 2017 at 5:24 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> The meson efuse driver seems to be compatible with more SoCs than
> initially thought. Let's use the most generic compatible he have in
> DT instead of the gxbb specific one
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt | 4 ++--
>  drivers/nvmem/meson-efuse.c                               | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> index fafd85bd67a6..0260524292fe 100644
> --- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> @@ -1,7 +1,7 @@
>  = Amlogic eFuse device tree bindings =
>
>  Required properties:
> -- compatible: should be "amlogic,meson-gxbb-efuse"
> +- compatible: should be "amlogic,meson-gx-efuse"
have you checked with the devicetree maintainers how they want the
documentation to look like in this case?
(I don't know if the old one should be kept instead of removing it)

>
>  = Data cells =
>  Are child nodes of eFuse, bindings of which as described in
> @@ -10,7 +10,7 @@ bindings/nvmem/nvmem.txt
>  Example:
>
>         efuse: efuse {
> -               compatible = "amlogic,meson-gxbb-efuse";
> +               compatible = "amlogic,meson-gx-efuse";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>
> diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
> index 70bfc9839bb2..e90c6d68a263 100644
> --- a/drivers/nvmem/meson-efuse.c
> +++ b/drivers/nvmem/meson-efuse.c
> @@ -44,7 +44,7 @@ static struct nvmem_config econfig = {
>  };
>
>  static const struct of_device_id meson_efuse_match[] = {
> -       { .compatible = "amlogic,meson-gxbb-efuse", },
> +       { .compatible = "amlogic,meson-gx-efuse", },
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_efuse_match);
> --
> 2.13.6
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
