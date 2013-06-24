From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 24 Jun 2013 09:29:05 +0200
Subject: [patch 1/1] imx53-qsb: enable usb power
In-Reply-To: <20130623185952.GA26397@pengutronix.de> (Sascha Hauer's message
 of "Sun, 23 Jun 2013 20:59:52 +0200")
References: <20130620212939.018670789@rtp-net.org>
 <20130623185952.GA26397@pengutronix.de>
Message-ID: <8738s8arwe.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Thu, Jun 20, 2013 at 11:29:30PM +0200, Arnaud Patard wrote:
>> Enable usb power pin by using a fixed regulator. With this and the usb clock
>> patch is making usb working on my loco.
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-next/arch/arm/boot/dts/imx53-qsb.dts
>> ===================================================================
>> --- linux-next.orig/arch/arm/boot/dts/imx53-qsb.dts	2013-06-20 23:25:46.049428530 +0200
>> +++ linux-next/arch/arm/boot/dts/imx53-qsb.dts	2013-06-20 23:26:34.293425920 +0200
>> @@ -93,6 +93,15 @@
>>  			regulator-max-microvolt = <3200000>;
>>  			regulator-always-on;
>>  		};
>> +
>> +		reg_usbpwr: usbpwr {
>> +			compatible = "regulator-fixed";
>> +			regulator-name = "usbpwr";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			gpio = <&gpio7 8 0>;
>> +			regulator-always-on;
>> +		};
>
> Shouldn't this be provided to the chipidea driver as vbus?

I'm not sure about that. This gpio is controlling the usb power for the
2 usb ports while the vbus is more a port-basis thing.

Arnaud
