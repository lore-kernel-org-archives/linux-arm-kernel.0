From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 16:43:04 +0100
Subject: [PATCH v9 1/3] ARM: sunxi_defconfig: Add CONFIG_THERMAL_OF
In-Reply-To: <20161213143332.24988-2-quentin.schulz@free-electrons.com>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-2-quentin.schulz@free-electrons.com>
Message-ID: <20161213154304.k3v2nwwqinp64puj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 03:33:30PM +0100, Quentin Schulz wrote:
> This enables CONFIG_THERMAL_OF by default for sunxi_defconfig. It is
> required to get Allwinner SoCs' temperature from the GPADC driver.
> 
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. The first four channels can be used
> either for the ADC or the touchscreen and the fifth channel is used for
> the thermal sensor.
> 
> The thermal sensor requires the IP to be in touchscreen mode to return
> correct values. Therefore, if the user is continuously reading the ADC
> channel(s), the thermal framework in which the thermal sensor is
> registered will switch the IP in touchscreen mode to get a temperature
> value and requires a delay of 100ms (because of the mode switching),
> then the ADC will switch back to ADC mode and requires also a delay of
> 100ms. If the ADC readings are critical to user and the SoC temperature
> is not, the GPADC driver is capable of not registering the thermal
> sensor in the thermal framework and thus, "quicken" the ADC readings. In
> most use cases, the SoC temperature is more critical (for cpu throttling
> for example or activating cooling devices) than ADC readings, thus it is
> now enabled by default.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/cb630690/attachment.sig>
