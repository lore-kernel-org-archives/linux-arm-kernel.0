From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 09:08:55 +0100
Subject: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
In-Reply-To: <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20171205080855.arr7vlgnxoxmyedd@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 03:12:49PM +0100, Quentin Schulz wrote:
> This makes the axp20x_adc driver probe with platform device id
> "axp813-adc".
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 2468b43..42e54d1 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -878,7 +878,9 @@ static struct mfd_cell axp813_cells[] = {
>  		.resources		= axp803_pek_resources,
>  	}, {
>  		.name			= "axp20x-regulator",
> -	}
> +	}, {
> +		.name			= "axp813-adc",
> +	},

Any particular reason you're not adding it to the DT?

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/3ed3b476/attachment-0001.sig>
