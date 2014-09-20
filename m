From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 20 Sep 2014 11:55:58 +0200
Subject: [PATCH 7/8] ARM: mvebu: armada-xp: Add I2C eeprom on Lenovo
 ix4-300d
In-Reply-To: <1411157684-6991-8-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1411157684-6991-8-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <541D4F2E.9020707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2014 10:14 PM, Sebastian Hesselbarth wrote:
> There is an I2C eeprom connected on Lenovo ix4-300d, add the
> corresponding node.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
...
> ---
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> index c5ee6c00766c..cef50da88e45 100644
> --- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> +++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> @@ -98,6 +98,11 @@
>  					reg = <0x2e>;
>  				};
>  
> +				at24c64 at 50 {

nit: the node name should describe function, not its type.

@Jason, when you take this in, feel free to name the node eeprom at 50
instead.

Sebastian

> +					compatible = "atmel,24c64";
> +					reg = <0x50>;
> +				};
> +
>  				pcf8563 at 51 {
>  					compatible = "nxp,pcf8563";
>  					reg = <0x51>;
> 
