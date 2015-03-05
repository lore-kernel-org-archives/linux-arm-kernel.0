From: rockford@yandex.ru (=?koi8-r?B?8MHOz9cg4c7E0sXK?=)
Date: Thu, 05 Mar 2015 09:40:59 +0300
Subject: [PATCH] ARM: i.MX6Q: Add fixup for RTL8211E Gigabit Ethernet PHY
In-Reply-To: <2318103.drIWJFctaK@wuerfel>
References: <1425404579-30591-1-git-send-email-rockford@yandex.ru>
 <CAOMZO5C+uyfi=Br8kj5zE1ik=qxk2h4vaQn1Loo9=Uv_WGaoQg@mail.gmail.com>
 <5019881425501158@web17m.yandex.ru> <2318103.drIWJFctaK@wuerfel>
Message-ID: <6447821425537659@web14h.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



05.03.2015, 00:32, "Arnd Bergmann" <arnd@arndb.de>:
> On Wednesday 04 March 2015 23:32:38 ????? ?????? wrote:
>> ?04.03.2015, 23:18, "Fabio Estevam" <festevam@gmail.com>:
>>> ?On Wed, Mar 4, 2015 at 5:05 PM, ????? ?????? <rockford@yandex.ru> wrote:
>>>> ??Actually, I don't know. I've discovered this when I wanted to boot a more recent kernel
>>>> ??on this board, and network wasn't working. So I've had to disassembly a vendor's binary only module
>>>> ??to discover how they handle this situation.
>>> ?Do you use the generic PHY driver or do you have CONFIG_REALTEK_PHY enabled?
>> ?CONFIG_REALTEK_PHY=y
>> ?CONFIG_FIXED_PHY=y
>>> ?In case you use the realtek PHY driver and still see the issue, can't
>>> ?you fix this in drivers/net/phy/realtek.c instead?
>> ?I think there it will require a more work with board detection than here and will
>> ?populate a driver with unnecessary for most users code.
>
> But you said earlier that it's board independent and a property of the SoC
> instead. Can't the ethernet driver call phy_start_aneg() for the same effect,
> like a lot of other ethernet drivers do?

Of course. I'll try to make it this way.

--
 ??????
