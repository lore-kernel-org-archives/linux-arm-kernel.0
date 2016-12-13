From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 16:42:10 +0100
Subject: [PATCH v9 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <20161213143332.24988-4-quentin.schulz@free-electrons.com>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-4-quentin.schulz@free-electrons.com>
Message-ID: <20161213154210.qg5udk6shzj6zyph@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 03:33:32PM +0100, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
> 
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree. This registers
> the driver in the thermal framework.
> 
> The thermal sensor requires the IP to be in touchscreen mode to return
> correct values. Therefore, if the user is continuously reading the ADC
> channel(s), the thermal framework in which the thermal sensor is
> registered will switch the IP in touchscreen mode to get a temperature
> value and requires a delay of 100ms (because of the mode switching),
> then the ADC will switch back to ADC mode and requires also a delay of
> 100ms. If the ADC readings are critical to user and the SoC temperature
> is not, this driver is capable of not registering the thermal sensor in
> the thermal framework and thus, "quicken" the ADC readings.
> 
> This driver probes on three different platform_device_id to take into
> account slight differences (registers bit and temperature computation)
> between Allwinner SoCs ADCs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I already gave my Acked-by apparently, but I'll say it again :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/fc278b98/attachment.sig>
