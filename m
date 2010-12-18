From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Fri, 17 Dec 2010 21:14:53 -0800
Subject: [PATCH] OMAP1: clock_data: use runtime cpu / machine checks
In-Reply-To: <alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
References: <201012112150.33831.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
Message-ID: <AANLkTi=t4gpG-+PV04+cJ35nSn_QeaZyQXDrMeCCqQYH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 1:24 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Janusz, Cory,
>
> On Sat, 11 Dec 2010, Janusz Krzysztofik wrote:
>
>> Otherwise multi-omap1 configurations may set wrong clock speed.
>>
>> Created and tested against l-o master on Amstrad Delta.
>>
>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> Thanks, this is a significant step forward in building a good
> omap1_defconfig. ?Cory, do you mind testing this out? ?If it works for you
> also, let's plan to take this for 2.6.38.
>
> However:
>
>> Tested with omap1_defconfig after dropping
>> CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=y and those of 12MHz xtal based
>> clock speeds which are too high for my board.
>
> This is also key. ?Until the board files can somehow indicate which rate
> sets are usable for their boards at runtime -- which is what the
> CONFIG_OMAP_ARM* KConfig options used to do at KConfig-time -- I don't
> think omap1_defconfig is possible yet.
>
> Volunteers to tackle that project are gladly welcome :-)
>
>
> - Paul
>

This doesn't seem to work for me.  Using my own config, it'll boot
fine, but the omap1_defconfig, even after making the above changes,
still fails to boot.  I'll see if I can figure out what makes it stop.

- Cory
