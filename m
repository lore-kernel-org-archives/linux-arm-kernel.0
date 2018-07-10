From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 10 Jul 2018 20:32:27 +0800
Subject: [PATCH v2 0/4] sun8i: r40: add AHCI
In-Reply-To: <20180710122922.6sgmgfislqwhn3tt@flea>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
 <20180710122922.6sgmgfislqwhn3tt@flea>
Message-ID: <3F7BD4FD-D8D8-4900-BC53-E2C1928616A4@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?10? GMT+08:00 ??8:29:22, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Mon, Jul 09, 2018 at 03:20:54PM +0000, Corentin Labbe wrote:
>> Hello
>> 
>> With Moeicenowy's agreement, I have take leadership ot this patchset.
>> 
>> There are no really changes appart renaming struct quirck to variant.
>> 
>> Since the last serie is really old, I will answer comment here.
>> The two regulator (1.2 and 2.5V) are not for the PHY since:
>> - nothing in the schematic said that they are for the PHY, they seems
>>   only for controller
>> - all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>>   cannot be used for target)
>
>That's a pretty bad thing to do, especially for old series. You just
>dropped all the context that you reply to, and there's no way for any
>reviewer to tell if your answers make any kind of sense, or addresses
>any question one might have had.
>
>> Furthermore, the AHCI binding support only one regulator per PHY, so
>> using the "target" regulator is out of question for registring this
>two
>> non-phy regulator.
>
>Nothing is "out of question", we have the source code and can change
>it if needed.

The main problem is that he misunderstood the meaning
of target regulator -- it's not for PHY but for disk. And if a
device is designed to accept both 2.5" and 3.5" HDD at
the same port multiple target regulator might really
be useful -- one 5v and one 12v.

>
>Maxime
