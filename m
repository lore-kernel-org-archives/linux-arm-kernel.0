From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Thu, 24 Jul 2014 17:06:43 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <20140724162645.4e19c26c@bbrezillon>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>	<53D10C50.50305@aksignal.cz>
 <20140724162645.4e19c26c@bbrezillon>
Message-ID: <53D12103.3020103@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne 24.7.2014 v 16:26 Boris BREZILLON napsal(a):
> Hello Ji??,
>
> First of all, please try to use git format-patch when submitting a
> patch to any kernel mailing list.
Sorry for that.
>
> On Thu, 24 Jul 2014 15:38:24 +0200
> Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:
>
>> After ROMBOOT tries boot from flash on SPI0 NPCS0, this NPCS0 (PA14) remains set to PERIPH_A.
>> Because of that, this pin is unusable to something else.
>> This patch sets it back to GPIO.
>
> The policy is to leave pins in an unknown state till some peripheral
> need them.
>
> What are you trying to use this pin for ?
For chip select, but #3. And when SPI communicate with cs0 (PA22), it goes down too (PA14), so 2 devices on bus were 
selected.
> If you just want to use it as a chip select for an spi device, take a
> look at [1].
At [1] it's OK until as cs0 is for example PA22 and cs1 is PA14.
>
> Here the gpio is requested by the spi core when defining the cs-gpios
> property. The gpio controller then request the listed pins to the pin
> controller (pinctrl driver).
GPIO is not set in driver as GPIO, at least I didn't find it.
>
> You can explicitly define a new pinctrl state (by defining a new
> pinctrl_spi0_cs0 subnode in your dts file) and reference it in the
> spi0 node, though this is not mandatory.
>
> Best Regards,
>
> Boris
>
> [1]http://lxr.free-electrons.com/source/arch/arm/boot/dts/at91sam9x5ek.dtsi#L85
>
