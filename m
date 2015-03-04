From: rockford@yandex.ru (=?koi8-r?B?8MHOz9cg4c7E0sXK?=)
Date: Wed, 04 Mar 2015 23:05:43 +0300
Subject: [PATCH] ARM: i.MX6Q: Add fixup for RTL8211E Gigabit Ethernet PHY
In-Reply-To: <2796821.5chD2g3yoZ@wuerfel>
References: <1425404579-30591-1-git-send-email-rockford@yandex.ru>
 <3988965.hS0GXm2TNL@wuerfel> <4686121425496122@web26g.yandex.ru>
 <2796821.5chD2g3yoZ@wuerfel>
Message-ID: <4971421425499543@web17m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



04.03.2015, 22:44, "Arnd Bergmann" <arnd@arndb.de>:
> On Wednesday 04 March 2015 22:08:42 ????? ?????? wrote:
>>>> ??+ ??????????????phy_register_fixup_for_uid(PHY_ID_RTL8211E, 0xffffffff,
>>>> ??+ ??????????????????????????????rtl8211e_phy_fixup);
>>> ?How do you ensure that this fixup is only applied on the boards that need
>>> ?it, rather than all machines that happen to have this phy?
>> ?I've thought that if there no other fixups in code here checking a particular
>> ?board where they run, this isn't necessary.
>> ?This SoC has only one ethernet MAC and if it is connected to this PHY,
>> ?it should be initalized this way independently of board, like other code here does, I think.
>>
>> ?This code just does forcibly restart autonegotiation.
>> ?I can wrap it in if(!of_machine_is_compatible(...)){}, if it is need.
>
> Your explanation makes sense to me, though I wonder what the property of this
> SoC is that requires the PHY fixup. Is this something we could or should be doing
> in a more general way using the PHY API, by having the device driver call a
> phy API function to restart autoneg independent of the PHY?

Actually, I don't know. I've discovered this when I wanted to boot a more recent kernel
on this board, and network wasn't working. So I've had to disassembly a vendor's binary only module
to discover how they handle this situation.

--
 ??????
