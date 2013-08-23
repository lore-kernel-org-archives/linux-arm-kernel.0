From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 15:05:07 +0200
Subject: [PATCH 33/40] ARM: ux500: Don't register the STMPE/SKE when
 booting with ATAG support
In-Reply-To: <CACRpkdZdzF-HqTmEWpYiBe2VwGN23fsnWCr7aqE0NYWpBfHsfw@mail.gmail.com>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
 <1377260620-18829-34-git-send-email-lee.jones@linaro.org>
 <CACRpkdZdzF-HqTmEWpYiBe2VwGN23fsnWCr7aqE0NYWpBfHsfw@mail.gmail.com>
Message-ID: <CACRpkdZE1yCPO0JVXX88SUKsp3ow7WBuJZZ=BEVk-c5=TOUO-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 2:55 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Aug 23, 2013 at 2:23 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> It's time to remove all ATAG support from ux500 and rely solely on
>> Device Tree booting. This patch is part of that endeavour.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> (...)
>> -/* STMPE/SKE keypad use this key layout */
>> -static const unsigned int mop500_keymap[] = {
>> -       KEY(2, 5, KEY_END),
>> -       KEY(4, 1, KEY_POWER),
>> -       KEY(3, 5, KEY_VOLUMEDOWN),
>> -       KEY(1, 3, KEY_3),
>> -       KEY(5, 2, KEY_RIGHT),
>> -       KEY(5, 0, KEY_9),
>> -
>> -       KEY(0, 5, KEY_MENU),
>> -       KEY(7, 6, KEY_ENTER),
>> -       KEY(4, 5, KEY_0),
>> -       KEY(6, 7, KEY_2),
>> -       KEY(3, 4, KEY_UP),
>> -       KEY(3, 3, KEY_DOWN),
>> -
>> -       KEY(6, 4, KEY_SEND),
>> -       KEY(6, 2, KEY_BACK),
>> -       KEY(4, 2, KEY_VOLUMEUP),
>> -       KEY(5, 5, KEY_1),
>> -       KEY(4, 3, KEY_LEFT),
>> -       KEY(3, 2, KEY_7),
>> -};
>
> This STMPE1601 keypad @0x40 and UIB encoding for
> the U8500 UIB does not exist in any DTS file does it? This
> means that the support for this UIB is effectively terminated.

You are wrong. Go read arch/arm/boot/dts/[ste-]stuib.dtsi.

Anyway, what you wanted to say was for these to be marked
"disabled" by default and turned into "okay" using an I2C
probe operation.

Yours,
Linus Walleij
