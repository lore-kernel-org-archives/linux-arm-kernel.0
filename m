From: uwe@kleine-koenig.org (=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=)
Date: Thu, 24 Nov 2016 09:37:10 +0100
Subject: [RFC PATCH] ARM: dts: Add support for Turris Omnia
In-Reply-To: <20161123003505.GL2691@lunn.ch>
References: <1479851991.26813.2@smtp.gmail.com>
 <1479859770-9375-1-git-send-email-tmshlvck@gmail.com>
 <20161123003505.GL2691@lunn.ch>
Message-ID: <4e3f9628-dbf8-27c1-abea-d0ef58a67e51@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2016 01:35 AM, Andrew Lunn wrote:
>> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
>> @@ -0,0 +1,279 @@
>> +/*
>> + * Device Tree file for the Turris Omnia
>> + * Schematic available at https://www.turris.cz/doc/_media/rtrom01-schema.pdf
>
> Cool that there is a link to the schematics. But please could you put
> it lower down. It is more likely to be seen if it comes after the
> copyright and license section.

I added to the top because that's where I would look. But checking other
dts files it seems indeed to be more common after the copyright stuff.
I'd suggest to even start a new comment (i.e.

	 * last blabla of copyright
	 */

	/*
	 * Schematic available at ...

) to be more "loud".

@Tomas: I think it doesn't make sense when we alternate sending patches
without prior arrangement. Do you already work on a v5? If not I can do
that to fix the last few comments. Not sure when a submission is too
late to enter v4.10, but I think the window isn't that big any more.

> No leds? No buttons via gpio-keys?

The leds are controlled by a Cortex-M0 and without intervention blink
according to a hardware function (network, power, pci). IMHO that's ok
for an initial setup.

And there are no buttons that are routed to the Armada CPU. Just a reset
button (well, ok, this one is routed to the Armada CPU, but you cannot
make this a gpio-key :-) and the other button is used to control the
brightness of the LEDs and is only routed to the M0.

Best regards
Uwe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/8bd849c4/attachment-0001.sig>
