From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Dec 2014 08:53:08 -0500
Subject: [PATCHv0 2/5] ARM: mvebu: ISL12057 rtc chip can be used to
 wake up RN102
In-Reply-To: <b7208bdcd16dbc511d7ae6dd47aee91ab81f54f4.1418519430.git.arno@natisbad.org>
References: <cover.1418519430.git.arno@natisbad.org>
 <b7208bdcd16dbc511d7ae6dd47aee91ab81f54f4.1418519430.git.arno@natisbad.org>
Message-ID: <20141215135308.GB967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 02:42:28AM +0100, Arnaud Ebalard wrote:
> 
> Now that alarm support for ISL12057 chip is available, let's use a
> feature of the driver dedicated to NETGEAR ReadyNAS 102 specific
> routing of RTC IRQ#2 pin; on the device, this pin is not connected
> to the SoC but to a PMIC, which allows the device to be powered
> up when RTC alarm rings.
> 
> For that to work, the chip needs to be explicitly marked as a
> device wakeup source using the "can-wakeup-machine" boolean
> property. This makes 'wakealarm' sysfs entry available to
> configure the alarm.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 1 +
>  1 file changed, 1 insertion(+)

Please group patches 2 - 4 into one patch.

thx,

Jason.

> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index 4e24932c6e30..3b0f2b88ce9e 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -87,6 +87,7 @@
>  				isl12057: isl12057 at 68 {
>  					compatible = "isil,isl12057";
>  					reg = <0x68>;
> +					can-wakeup-machine;
>  				};
>  
>  				g762: g762 at 3e {
> -- 
> 2.1.1
> 
> 
