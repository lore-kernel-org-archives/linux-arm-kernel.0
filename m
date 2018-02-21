From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Feb 2018 10:51:35 +0100
Subject: [PATCH v4 00/13] add support for AXP813 ADC and battery power
 supply
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Message-ID: <20180221095135.qasoo527jvlu6fsw@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 01:47:23PM +0100, Quentin Schulz wrote:
> The AXP813 PMIC is relatively close to the already supported AXP20X and
> AXP22X. It provides three different power outputs: battery, AC and USB, and
> measures a few different things: temperature, power supply status, current
> current and voltage supplied, maximum current limit, battery capacity, min
> and max voltage limits.
> 
> One of its two GPIOs can be used as an ADC.
> 
> There are a few differences with AXP20X/AXP22X PMICs though:
>   - a different constant charge current formula,
>   - battery temperature, GPIO0 and battery voltages are the only voltages
>   measurable,
>   - all data are stored on 12 bits (AXP20X/AXP22X had one type of data that
>   was stored on 13 bits),
>   - different scales and offsets,
>   - a different ADC rate formula and register,
> 
> This patch series adds support for the PMIC's ADC and battery power supply
> in the existing drivers.
> 
> Make the axp20x MFD automatically probe the ADC driver, add the battery
> power supply node in axp81x node and enable it for the TBS A711 since it
> has a soldered battery.
> 
> I suggest patches:
>   - 1,2,4,10,11,12 go through Maxime and Chen-Yu's tree,

Applied, thanks!
Maxiime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180221/99a8d83c/attachment-0001.sig>
