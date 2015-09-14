From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Sep 2015 11:56:43 -0700
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Add wakeup irq for mcp79410
In-Reply-To: <1441308240-26725-1-git-send-email-nm@ti.com>
References: <1441308240-26725-1-git-send-email-nm@ti.com>
Message-ID: <20150914185643.GT4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150903 12:27]:
> With the support in the generic PM framework for wakeirq and capability
> added to the rtc-ds1307 driver to support this, we can now define the
> optional wakeup irq to allow the RTC to wakeup the system from low power
> modes as part of suspend.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> This patch depends on upcoming merge for RTC
> https://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/log/?h=rtc-next&ofs=50
> 
> merge to master of:
> 9901c41bd019 rtc: ds1307: Support optional wakeup interrupt source
> 496a7ede6cac rtc: ds1307: Sort the headers
> e28475b15b65 rtc: ds1307: Switch to managed irq allocation
> 27a1dce6528a rtc: ds1307: Convert to threaded IRQ
> 
> Tested with the above commits from linux-next: http://pastebin.ubuntu.com/12265857/
> 
> Could probably go in round 2 of merges for 4.3?

Applying into omap-for-v4.3/fixes thanks.

Tony
 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index ede7fb73c717..8464f3cea280 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -526,7 +526,8 @@
>  	mcp_rtc: rtc at 6f {
>  		compatible = "microchip,mcp7941x";
>  		reg = <0x6f>;
> -		interrupts = <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;  /* IRQ_SYS_1N */
> +		interrupts-extended = <&crossbar_mpu GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&dra7_pmx_core 0x424>;
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&mcp79410_pins_default>;
> -- 
> 1.7.9.5
> 
