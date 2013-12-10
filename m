From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Tue, 10 Dec 2013 16:52:35 +0200
Subject: [PATCH 1/2] arm: dts: keystone: add watchdog entry
In-Reply-To: <1386686869-729-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1386686869-729-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52A72AB3.5000900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ CC
devicetree at vger.kernel.org
linux-arm-kernel at lists.infradead.org
linux-kernel at vger.kernel.org

On 12/10/2013 04:47 PM, Ivan Khoronzhuk wrote:
> Add watchdog entry to keystone device tree.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
> Based on
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
> keystone/master
>
>   arch/arm/boot/dts/keystone.dtsi |    6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index f6d6d9e..54a8ff7 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -181,5 +181,11 @@
>   			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
>   			clocks = <&clkspi>;
>   		};
> +
> +		wdt: wdt at 022f0080 {
> +			compatible = "ti,keystone-wdt","ti,davinci-wdt";
> +			reg = <0x022f0080 0x80>;
> +			clocks = <&clkwdtimer0>;
> +		};
>   	};
>   };
>


-- 
Regards,
Ivan Khoronzhuk
