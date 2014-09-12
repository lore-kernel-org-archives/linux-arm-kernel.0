From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Sep 2014 10:03:16 +0200
Subject: [GIT PULL] ARM: LPC32xx: Device tree updates
In-Reply-To: <3900226.tYc6lW0Md4@wuerfel>
References: <540F1409.3070206@antcom.de> <4173517.3fBhGIV2aO@wuerfel>
 <54105765.5090708@antcom.de> <3900226.tYc6lW0Md4@wuerfel>
Message-ID: <CACRpkda66Wo1GMWB6XD76rV14O--gre434cwc1tRw-w2ro0N6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 4:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 10 September 2014 15:51:33 Roland Stigge wrote:
>>
>> > For
>> > lpc32xx, this is currently not possible because you are not using
>> > the common clk implementation. Would it be possible for you
>> > to look into converting that driver over and moving it to
>> > drivers/clk?
>>
>> It's certainly possible, but time might be scarce. What would be a good
>> reference platform to have a look into as example? Or a hint/link?
>
> I'll let Linus answer that one, he converted a couple of platform and
> probably has a better idea than I do.

Step-wise conversion on U300:

commit 50667d63085af108f625c83102430c1d74931d78
"ARM: u300: convert to common clock"
converts to common clock *without* using device tree.

commit 14c2607144c11653b27a423ead0703ffaa65d0b1
"clk: move the U300 fixed and fixed-factor to DT"
commit bba5f2cc2f0fe4191ad2699c7c03a6def31f54e2
"ARM: u300: move the gated system controller clocks to DT"
commit 85fb28bed813469ba56706a7e48fba596f47c253
"ARM: u300: convert MMC/SD clock to device tree"

Then gradually moves those clocks over to being handled
from the device tree.

For an example on a platform lacking clock implementation,
look at:

commit ef6eb322ce574ba73658a677e83e5da3cfab301b
"clk: nomadik: implement the Nomadik clocks properly"
where I implement the Nomadik per-bit enabled clocks
This includes device tree bindings.

commit c641d4dfef6d462c6d66a6fb57700086cd2f0106
"ARM: nomadik: add the new clocks to the device tree"
adds them to the device tree and make use of them.

Yours,
Linus Walleij
