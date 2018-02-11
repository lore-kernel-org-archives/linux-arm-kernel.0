From: embed3d@gmail.com (Philipp Rossak)
Date: Sun, 11 Feb 2018 03:43:07 +0100
Subject: [BUG]: A83T - AC100 gets the wrong number of parents
Message-ID: <1518316987.5562.7.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

When I boot my A83T I get the following bootlog [1].

After some debugging, I found out that the function call:
clk_hw_get_num_parents() returns 2. After a look in the devicetree I
found out that this value should be 1, since we only have one parent
clock [3].
Setting the variable num_parents to 1 fixes the problem, but this is no
soultion.

Regards,
Philipp



[1]: https://pastebin.com/5c7hxjsS
[2]: http://lxr.bootlin.com/linux/v4.15/source/drivers/rtc/rtc-ac100.c#
L180
[3]: http://lxr.bootlin.com/linux/v4.15/source/arch/arm/boot/dts/sun8i-
a83t-bananapi-m3.dts#L159
