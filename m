From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 20:07:26 +0800
Subject: [linux-sunxi] [PATCH v3 08/12] regulator: axp20x-regulator: add
 support for AXP803
In-Reply-To: <20170417115747.7300-9-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-9-icenowy@aosc.io>
Message-ID: <CAGb2v66whYhHmKwgjON36Gsoh_61G=vMwSH744t5Nt+ohdZ7pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 7:57 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> AXP803 PMIC also have a series of regulators (DCDCs and LDOs)
> controllable via I2C/RSB bus.
>
> Add support for them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Place AXP803 codes before AXP806/809 ones.
> - Fixed some errors in regulator description.
> - Reuse AXP803 DLDO2 range for AXP806 CLDO2 & AXP809 DLDO1.
>
>  drivers/regulator/axp20x-regulator.c | 153 ++++++++++++++++++++++++++++++-----
>  include/linux/mfd/axp20x.h           |  37 +++++++++
>  2 files changed, 168 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 0b9d4e3e52c7..2ed15e4a7a82 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c

[...]

> @@ -492,20 +578,38 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
>  {
>         u32 reg = 0;
>
> -       /* Only AXP806 has poly-phase outputs */
> -       if (axp20x->variant != AXP806_ID)
> -               return false;
> +       /*
> +        * Currently in our supported AXP variants, only AXP806 and AXP803

Nit: mention them in ascending order.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
