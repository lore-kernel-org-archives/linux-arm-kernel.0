From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 09 Jun 2014 12:16:51 +0200
Subject: [PATCH 0/5] Add Maxim 77802 PMIC support
In-Reply-To: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1402309011.17650.9.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-06-09 at 11:37 +0200, Javier Martinez Canillas wrote:
> MAX77802 is a PMIC that contains 10 high efficiency Buck regulators,
> 32 Low-dropout (LDO) regulators, two 32kHz buffered clock outputs,
> a Real-Time-Clock (RTC) and a I2C interface to program the individual
> regulators, clocks and the RTC.
> 
> This series are based on drivers added by Simon Glass to the Chrome OS
> kernel and adds support for the Maxim 77802 Power Management IC, their
> regulators, clocks, RTC and I2C interface. It is composed of patches:
> 
> [PATCH 1/5] mfd: Add driver for Maxim 77802 Power Management IC
> [PATCH 2/5] regulator: Add driver for Maxim 77802 PMIC regulators
> [PATCH 3/5] clk: Add driver for Maxim 77802 PMIC clocks
> [PATCH 4/5] rtc: Add driver for Maxim 77802 PMIC Real-Time-Clock
> [PATCH 5/5] ARM: dts: Add max77802 device node for exynos5420-peach-pit
> 
> Patches 1-4 add support for the different devices and Patch 5 enables
> the MAX77802 PMIC on the Exynos5420 based Peach pit board.


Hi,

The main mfd, mfd irq, clk and rtc drivers look very similar to max77686
drivers. I haven't checked other Maxim drivers but I think there will be
a lot of similarities with them also. It is almost common for Maxim
chipsets to share components between each other.

I think there is no need in duplicating all that stuff once again in new
driver for another Maxim-almost-the-same-as-others-XYZ chipset. Just
merge it with max77686 (or other better candidate).

The only difference is in regulator driver. I am not sure whether this
is a result of differences in chip or differences in driver design.

Best regards,
Krzysztof



> Lee,
> 
> Patches 2-4 depend on Patch 1 so I think that it makes sense if you take
> 1-4 through your mfd tree once the relevant maintainers ack the drivers
> added to the other subsystems (regulator, clk and rtc).
> 
> Patch 5 can go through Kukjin tree since is just DTS changes.
> 
> Thanks a lot and best regards,
> Javier
