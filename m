From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 28 Dec 2015 11:15:30 +0100
Subject: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions"
 node
In-Reply-To: <20151228050147.GE1066@verge.net.au>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <20151228050147.GE1066@verge.net.au>
Message-ID: <CAMuHMdXt36GSDuoFVGBebJVN9OHPh=ze8u8KvQ0B+RcvT6xTYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Dec 28, 2015 at 6:01 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
>> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
>> subnode of an SPI FLASH device node must have a compatible property. The
>> partitions are no longer detected if it is not present.
>>
>> However, several DTSes in -next have already been converted to the
>> "partitions" subnode without "compatible" property, introduced by
>> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
>> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
>> partitions in a special 'partitions' subnode"). Hence all of these are
>> now broken in -next, and will be broken in upstream during the merge
>> window.
>>
>> This series fixes all users in next-20151221.
>> Tested on r8a7791/koelsch.
>>
>> Changes since v1:
>>   - Add Acked-by,
>>   - Fix new users in -next (kirkwood, ci20).
>>
>> Most of these are in arm-soc/for-next. Exceptions are kirkwood (in
>> mvebu/for-next), and ci20 (in mips/mips-for-linux-next).
>>
>> Given we're late in the v4.4-rc cycle, perhaps it's easiest if the
>> arm-soc maintainers take all applicable patches directly, bypassing the
>> mvebu and shmobile maintainers?
>>
>> Thanks for queuing for v4.5!
>>
>> Geert Uytterhoeven (9):
>>   ARM: mvebu: ix4-300d: Add compatible property to "partitions" node
>>   ARM: mvebu: kirkwood: Add compatible property to "partitions" node
>>   ARM: shmobile: bockw dts: Add compatible property to "partitions" node
>>   ARM: shmobile: lager dts: Add compatible property to "partitions" node
>>   ARM: shmobile: koelsch dts: Add compatible property to "partitions"
>>     node
>>   ARM: shmobile: porter dts: Add compatible property to "partitions"
>>     node
>>   ARM: shmobile: gose dts: Add compatible property to "partitions" node
>>   ARM: shmobile: silk dts: Add compatible property to "partitions" node
>
> Thanks, I have queued up the above "shmobile" patches for v4.6.

I'm afraid v4.6 is too late, leaving all SPI FLASHes broken in v4.5.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
