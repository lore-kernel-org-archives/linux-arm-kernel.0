From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 16 Sep 2016 18:48:50 +0200 (CEST)
Subject: [PATCH v3 6/6] ARM: dts: bcm283x: add pinctrl group to &sdhci,
 drop pins from &gpio
In-Reply-To: <1473841415-937-7-git-send-email-kraxel@redhat.com>
References: <1473841415-937-1-git-send-email-kraxel@redhat.com>
 <1473841415-937-7-git-send-email-kraxel@redhat.com>
Message-ID: <43420281.199608.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerd,

> Gerd Hoffmann <kraxel@redhat.com> hat am 14. September 2016 um 10:23
> geschrieben:
> 
> 
> As the alt3 group has no pins left after this
> update drop the whole alt3 group from &gpio.

sorry it won't be that simple. The references needs to removed too :-(

> grep alt3 *.dts*
bcm2835-rpi-a.dts:	pinctrl-0 = <&gpioout &alt0 &i2s_alt2 &alt3>;
bcm2835-rpi-a-plus.dts:	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
bcm2835-rpi-b.dts:	pinctrl-0 = <&gpioout &alt0 &alt3>;
bcm2835-rpi-b-plus.dts:	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
bcm2835-rpi-b-rev2.dts:	pinctrl-0 = <&gpioout &alt0 &i2s_alt2 &alt3>;
bcm2835-rpi.dtsi:	alt3: alt3 {
bcm2835-rpi-zero.dts:	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
bcm2836-rpi-2-b.dts:	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;

Regards
Stefan
