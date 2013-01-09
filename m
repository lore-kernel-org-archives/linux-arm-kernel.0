From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 9 Jan 2013 07:15:18 +0100
Subject: [PATCH] pinctrl: mvebu: fix MPP6 value for kirkwood driver
In-Reply-To: <1357681024-4686-1-git-send-email-simon.guinot@sequanux.org>
References: <1357681024-4686-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130109061518.GL24650@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 10:37:04PM +0100, Simon Guinot wrote:
> Note that I am not sure about the MPP value for the PTP functionality.
> It seems that the PTP references have been removed from the Marvell
> hardware specifications available to me.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  drivers/pinctrl/mvebu/pinctrl-kirkwood.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
> index fa6ce31..02d5b89 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
> @@ -66,9 +66,9 @@ static struct mvebu_mpp_mode mv88f6xxx_mpp_modes[] = {
>  		MPP_VAR_FUNCTION(0x5, "sata0", "act",    V(0, 1, 1, 1, 1, 0)),
>  		MPP_VAR_FUNCTION(0xb, "lcd", "vsync",    V(0, 0, 0, 0, 1, 0))),
>  	MPP_MODE(6,
> -		MPP_VAR_FUNCTION(0x0, "sysrst", "out",   V(1, 1, 1, 1, 1, 1)),
> -		MPP_VAR_FUNCTION(0x1, "spi", "mosi",     V(1, 1, 1, 1, 1, 1)),
> -		MPP_VAR_FUNCTION(0x2, "ptp", "trig",     V(1, 1, 1, 1, 0, 0))),
> +		MPP_VAR_FUNCTION(0x1, "sysrst", "out",   V(1, 1, 1, 1, 1, 1)),
> +		MPP_VAR_FUNCTION(0x2, "spi", "mosi",     V(1, 1, 1, 1, 1, 1)),
> +		MPP_VAR_FUNCTION(0x3, "ptp", "trig",     V(1, 1, 1, 1, 0, 0))),
>  	MPP_MODE(7,
>  		MPP_VAR_FUNCTION(0x0, "gpo", NULL,       V(1, 1, 1, 1, 1, 1)),
>  		MPP_VAR_FUNCTION(0x1, "pex", "rsto",     V(1, 1, 1, 1, 0, 1)),
> -- 
> 1.7.10

Acked-by: Andrew Lunn <andrew@lunn.ch>

I checked against the old MPP.H and the "88F6281 Integrated Controller
Hardware Specifications".

It is interesting that pin 6 cannot be used as a GP[IO] at all. Some
of the other pins are limited to GPO, but this appears to be the only
one which cannot be used at all.

    Andrew
