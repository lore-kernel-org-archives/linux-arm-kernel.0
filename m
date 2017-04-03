From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 03 Apr 2017 09:07:50 -0700
Subject: [PATCH v2 1/2] pinctrl: meson: meson8b: fix the NAND DQS pins
In-Reply-To: <20170401135922.1288-2-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 1 Apr 2017 15:59:21 +0200")
References: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-2-martin.blumenstingl@googlemail.com>
Message-ID: <m2d1cta2zt.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The nand_groups table uses different names for the NAND DQS pins than
> the GROUP() definition in meson8b_cbus_groups (nand_dqs_0 vs nand_dqs0).
> This prevents using the NAND DQS pins in the devicetree.
>
> Fix this by ensuring that the GROUP() definition and the
> meson8b_cbus_groups use the same name for these pins.
>
> Fixes: 0fefcb6876d0 ("pinctrl: Add support for Meson8b")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/pinctrl/meson/pinctrl-meson8b.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
> index 76f077f18193..f87ef5a0ee6c 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson8b.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
> @@ -739,8 +739,8 @@ static const char * const sdxc_c_groups[] = {
>  static const char * const nand_groups[] = {
>  	"nand_io", "nand_io_ce0", "nand_io_ce1",
>  	"nand_io_rb0", "nand_ale", "nand_cle",
> -	"nand_wen_clk", "nand_ren_clk", "nand_dqs0",
> -	"nand_dqs1"
> +	"nand_wen_clk", "nand_ren_clk", "nand_dqs_0",
> +	"nand_dqs_1"
>  };
>  
>  static const char * const nor_groups[] = {
