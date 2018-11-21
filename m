From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Nov 2018 12:02:47 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990-ebisu: Enable i2c
In-Reply-To: <1540071365-27533-1-git-send-email-ykaneko0929@gmail.com>
References: <1540071365-27533-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20181121110247.opkddubdalmehohd@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 06:36:05AM +0900, Yoshihiro Kaneko wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch enables I2C3 channels for the r8a77990-ebisu.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Hi Kaneko-san,

thanks for your patch.

It seems that i2c3 is already enabled in upstream as of:

56629fcba94c ("arm64: dts: renesas: ebisu: Enable Audio")

Accordingly, I am dropping this patch.

> ---
> 
> This patch is based on the devel branch of Simon Horman's renesas tree.
> 
>  arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> index 611f026..4a596ef 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -294,6 +294,10 @@
>  	clock-names = "fck", "dclkin.0", "extal";
>  };
>  
> +&i2c3 {
> +	status = "okay";
> +};
> +
>  &ohci0 {
>  	status = "okay";
>  };
> -- 
> 1.9.1
> 
