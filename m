From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 15:14:45 +0200
Subject: [PATCH v2 07/10] mfd: axp20x: add pinctrl cell for AXP813
In-Reply-To: <5345a2e94013f4e4f7b545cd4d84b098bd2fa349.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <5345a2e94013f4e4f7b545cd4d84b098bd2fa349.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170926131445.xo2uawiovjtmyivj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 12:17:17PM +0000, Quentin Schulz wrote:
> As pinctrl and GPIO driver now supports AXP813, add a cell for it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 336de66..a457528 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -876,6 +876,9 @@ static struct mfd_cell axp813_cells[] = {
>  		.name			= "axp221-pek",
>  		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>  		.resources		= axp803_pek_resources,
> +	}, {
> +		.name			= "axp20x-gpio",
> +		.of_compatible		= "x-powers,axp813-pctl",

This was probably introduced in the previous driver, but why are you
using the pctl suffix? Can't we just use the GPIO one to remain
consistent with the previous users and the datasheet?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/41ce5562/attachment.sig>
