From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 14 May 2018 13:49:17 +0200
Subject: [PATCH 1/2] pinctrl: mvebu: update use "nand" function for "rb"
 pin
In-Reply-To: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Fri, 4 May 2018 15:06:37 +1200")
References: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <87r2me31aa.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On ven., mai 04 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> The Armada 98dx3236 SoCs don't have a different MPP sel value for nand
> specific pins so "dev" was technically correct. But all the other Armada
> SoCs use "nand" in their dts and the pin is specific to the nand
> interface so use "nand" for the function name.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
> ---
>  drivers/pinctrl/mvebu/pinctrl-armada-xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
> index b854f1ee5de5..28b199796fae 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
> @@ -431,7 +431,7 @@ static struct mvebu_mpp_mode mv98dx3236_mpp_modes[] = {
>  	MPP_MODE(19,
>  		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
>  		 MPP_VAR_FUNCTION(0x3, "uart1", "rxd",       V_98DX3236_PLUS),
> -		 MPP_VAR_FUNCTION(0x4, "dev", "rb",          V_98DX3236_PLUS)),
> +		 MPP_VAR_FUNCTION(0x4, "nand", "rb",         V_98DX3236_PLUS)),
>  	MPP_MODE(20,
>  		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
>  		 MPP_VAR_FUNCTION(0x4, "dev", "we0",         V_98DX3236_PLUS)),
> -- 
> 2.17.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
