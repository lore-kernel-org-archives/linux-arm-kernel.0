From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 21 Jan 2015 11:38:27 +0100
Subject: [Query] should pinmux setting be put into board specific dts
 or SoC specific dtsi?
In-Reply-To: <20150121153056.1d325708@xhacker>
References: <20150121153056.1d325708@xhacker>
Message-ID: <54BF81A3.4060500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2015 08:30 AM, Jisheng Zhang wrote:
> IIUC, the pinmux setting is board specific. So my question is where to put the
> pinmux settings? Board specific dts or SoC specific dtsi? Could anyone kindly
> help me?

Jisheng,

it depends on the pinmux setting whether it should go in to SoC dtsi or
board dts. For example, the pinmux setting for internal devices like
UART - where there is only one or two possible settings - should go
into SoC dtsi. Also, if there is only one possible setting or one
default/common setting, the SoC dtsi node should already have the
corresponding pinctrl properties. If a specific board uses another
setting, it can always overwrite the default property with the
one used at board level.

A good example for board specific pinmux settings clearly is GPIO,
e.g. you have a regulator for USB power that is controlled by GPIO
then you'll have the regulator node on board level and also the
corresponding pinmux settings for that very GPIO pin.

If you give a specific example of what pinmux setting bothers you,
we can try to find a good place for it.

Sebastian
