From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 23 May 2017 15:06:04 +0200
Subject: [PATCH 3/6] gpio: dt-bindings: Add documentation for gpio
 controllers on Armada 7K/8K
In-Reply-To: <CACRpkdY97DDcwec+J-4X1AT5a7Mbo4GnWUJmuAOYhNzOA8_HZQ@mail.gmail.com>
 (Linus Walleij's message of "Tue, 23 May 2017 11:20:19 +0200")
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
 <306395ff39de3d3d3c8f55e5da4de8def29ae8d1.1495210061.git-series.gregory.clement@free-electrons.com>
 <CACRpkdY97DDcwec+J-4X1AT5a7Mbo4GnWUJmuAOYhNzOA8_HZQ@mail.gmail.com>
Message-ID: <878tlnzps3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mar., mai 23 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, May 19, 2017 at 6:09 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>
>> Document the device tree binding for the gpio controllers found on the
>> Marvell Armada 7K and Armada 8K SoCs.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> This does not apply at all to the GPIO "devel" branch.
> And that is a fairly clean v4.12-rc2.
>
> Please rebase and resend the rest of the patches.

Actually I was wrong with my assumption that there was no dependency.
For the binding documentation there is dependecy accross the series I
sent.

This patch depends on "pinctrl: dt-bindings: add documentation for AP806
pin controllers" [1] and "pinctrl: dt-bindings: add documentation for
CP110 pin controllers" [3] from the series "Add support for the pin
controllers on the Marvell Armada 7K/8K".

As you are maintainer of both gpio and pinctrl subsystem it will be easy
to resolv.

But these last patches depend also on "clk: mvebu: ap806: introduce a
new binding" [3] in the clock series "Improve ap806 clk support on
Marvell Armada 7K/8K" and on "clk: mvebu: cp110: introduce a new
binding" [4] in the clock series "Improve cp110 clk support on Marvell
Armada 7K/8K".

So for these particular patches, either I rebase them on the v4.12-rc2
and there will be a small merge conflict during the merge window for
v4.13, or we can ask a stable branch with only these few patches (I am
adding the clock maintainer to this email).

If we chose this last option I can split the clock patches to have patch
modifying only the binding documentation.

Gregory

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507399.html
[2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507398.html
[3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507393.html
[4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507384.html

> Would be nice with a DT ACK but no controversial changes here.
>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
