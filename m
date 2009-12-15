From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue, 15 Dec 2009 11:22:46 +0100
Subject: [PATCH v2] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <1260194893-30149-1-git-send-email-ospite@studenti.unina.it>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<1260194893-30149-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20091215112246.3abaa457.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  7 Dec 2009 15:08:13 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> This driver provides an interface for controlling LEDs (or vibrators)
> connected to PMICs for which there is a regulator framework driver.
> 
> This driver can be used, for instance, to control vibrator on all Motorola EZX
> phones using the pcap-regulator driver services.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> ---
> 
> Addressed the observations from Mark Brown, Liam Girdwood and Linus Walleij.
> 
> Patch against:
> git://git.o-hand.com/linux-rpurdie-leds for-mm
> 
> Changes since v1:
>  - Use "vled" as supply id.
>  - use regulator_get_exclusive
>  - remove double semicolon
>  - check for LED_OFF instead of 0
>  - handle regulators which can't change voltages
>  - rename led_regulator_get_vdd to led_regulator_get_voltage
>  - split regulator_led_set_value out of led_work
>  - allow setting an initial brightness value
>  - fix sections markers (__devinit, __devexit, etc.)
> 
> The only slight doubt I still have is about
> led_regulator_get_max_brightness(), I have to use regulator_set_voltage() there
> to tell if a regulator has REGULATOR_CHANGE_VOLTAGE enabled.
> 
> Regards,
>    Antonio

Ping?

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091215/93535f4a/attachment.sig>
