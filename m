From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 09:47:29 +0200
Subject: [PATCH 1/5] ARM: mvebu: specify I2C bus frequency on Armada 370 DB
In-Reply-To: <1397806908-7550-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397806908-7550-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5350D891.4050609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2014 09:41, Thomas Petazzoni wrote:
> In commit 249f3822509b74f8c8d0731aeb7ccea065376c9b ('ARM: mvebu: add
> audio support to Armada 370 DB'), the I2C bus 0 was enabled on the
> Armada 370 DB board, and an I2C codec was described as being connected
> on this bus.
> 
> However, this commit forgot to define the I2C bus frequency, which
> leads the i2c-mv64xxx to fail probing, as it cannot calculate the baud
> rate multiplier/divisor to derive the I2C bus frequency from the core
> SoC frequency. It makes audio completely unusable, as the I2C bus is
> not probed, and therefore the audio codec is not probed either.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


> ---
> The audio support was merged in 3.15-rc1, so there's no need to
> backport this change into stable trees. However, it needs to go in the
> 3.15-rc cycle.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-db.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
> index 82f238a..3383c4b 100644
> --- a/arch/arm/boot/dts/armada-370-db.dts
> +++ b/arch/arm/boot/dts/armada-370-db.dts
> @@ -67,6 +67,7 @@
>  			i2c at 11000 {
>  				pinctrl-0 = <&i2c0_pins>;
>  				pinctrl-names = "default";
> +				clock-frequency = <100000>;
>  				status = "okay";
>  				audio_codec: audio-codec at 4a {
>  					compatible = "cirrus,cs42l51";
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
