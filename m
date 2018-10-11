From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 11 Oct 2018 15:20:11 +0200
Subject: [PATCH v3] arm64: new board - Emlid Neutis N5
In-Reply-To: <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <20181010144957.exrlupoph7ovsmdw@flea>
 <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
Message-ID: <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aleksandr,

Please keep your replies in text-only format, not HTML.

Am 11.10.18 um 14:01 schrieb aleksandr.aleksandrov at emlid.com:
>>     ?+/ {
>>     ?+ model = "Emlid Neutis N5 Developer board";
>>     ?+ compatible = "emlid,emlid-neutis-n5-devboard",
>>     ?+ "emlid,emlid-neutis-n5",
>>
>> Do you need the two emlid there? What comes before the comma is the
>> vendor, while what is after is the model.
> ?
> I think emlid-neutis-n5 module could be useful in the future, no need
> this now.

You misunderstand: The point would be to use, e.g., "emlid,neutis-n5"
instead of "emlid,emlid-neutis-n5" with duplicate "emlid,emlid-". It is
orthogonal to having multiple compatible strings.

>> ?+&uart1 {
>> ?+ pinctrl-names = "default";
>> ?+ pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>> ?+ status = "okay";
>> ?+};
>>
>> I guess this is for bluetooth? Have you tested serdev drivers?
>>
> Yes, bluetooth is connected over uart1.
> You mean if I have tested bluetooth stack via serial device?

Not quite, we're missing a child node within uart1 for a serdev driver.
Is there no such driver yet for your Bluetooth chipset, or did you not
yet check?

> Bluez works stably with bcm43xx over uart 1500000 baud rate.
> ?
>>
>> Also, I have a general comments, and it really depends on what your
>> intention about the board ecosystem is. Do you expect the SOM to be
>> swappable in multiple boards, or do you expect to send it as something
>> that is just fixed into a daughter board?
>>
>> In the former case, you probably want to use overlays instead. In the
>> latter, you're fine.
>>
> Right, we expect the SoM to be swappable. I agree, to use overlays is
> more convenient, but
> the devboard DT file will be a reference for the overlays and the future
> boards based on Neutis.

What about just keeping the common nodes enabled in a SoM .dts, so that
the average board doesn't need an Overlay for booting?

@Maxime/Rob, is it possible to merge .dtso files these days? If not,
could that be considered in the big dts Makefile refactoring? :)

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
