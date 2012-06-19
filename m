From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 23:17:24 -0300
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <201206190407.31524.marex@denx.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <F281D0F91ED19E4D8E63A7504E8A649803BE2DE2@039-SN2MPN1-023.039d.mgd.msft.net>
 <CAOMZO5C7KaxO_X23Ur9YwHEoAvCPf4emxMzH4mmrFX6=de5GZA@mail.gmail.com>
 <201206190407.31524.marex@denx.de>
Message-ID: <CAOMZO5Ap_KYM7uYebqOaCzpTzH2kcCFR6BTWX9GMKxsXoxCOew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 11:07 PM, Marek Vasut <marex@denx.de> wrote:

>> What should be done in addition to Richard's patch in order to get USB
>> host to work on mx28evk?
>
> Ah right, you need to toggle the power supply (vbus) GPIO.

Toggle it where?

I see the following:

reg_usb0_vbus: usb0_vbus {
compatible = "regulator-fixed";
regulator-name = "usb0_vbus";
regulator-min-microvolt = <5000000>;
regulator-max-microvolt = <5000000>;
gpio = <&gpio3 9 0>;
enable-active-high;

So the gpio3_9 will turn on the vbus.

What is missing?
