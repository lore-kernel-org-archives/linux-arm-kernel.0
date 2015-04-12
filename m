From: harald@ccbib.org (Harald Geyer)
Date: Sun, 12 Apr 2015 14:05:48 +0200
Subject: Bug: Wrong gpio polarity for green LED on Olinuxino Maxi
In-Reply-To: <1546181298.189897.1428834954615.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <1546181298.189897.1428834954615.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Message-ID: <E1YhGe4-00011i-B4@stardust.g4.wien.funkfeuer.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan!

Stefan Wahren writes:
> i recently discovered that the polarity of the green LED on iMX233-Olinuxino
> Maxi (Rev B) is wrong:
> 
> # Switches the led off, expected on
> echo 255 > /sys/class/leds/green/brightness
> 
> # Switches the led on, exptected off
> echo 0 > /sys/class/leds/green/brightness
> 
> Kernel: 4.0.0-rc4-next-20150320
> 
> Unfortunately i don't have any other Olimex board like Mini or Nano.
> 
> @Harald: Could you please check it on your boards?

I don't have access to my boards right now, but I know that this is
the behaviour on Mini and Nano and always (i started with 3.10) has been.
This is caused by the leds-gpio configuration in devicetree:
                user {
                        label = "green";
                        gpios = <&gpio2 1 1>;
                };

The last 1 in <&gpio2 1 1> inverts gpio polarity AFAIR. I don't know why
this was selected, but as it seemed to be deliberate I never bothered
about it.

HTH,
Harald
