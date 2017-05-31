From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 31 May 2017 12:02:59 +0200
Subject: [PATCH 3/6] gpio: dt-bindings: Add documentation for gpio
 controllers on Armada 7K/8K
In-Reply-To: <20170530222358.abta3srv5emz7wtp@rob-hp-laptop> (Rob Herring's
 message of "Tue, 30 May 2017 17:23:58 -0500")
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
 <306395ff39de3d3d3c8f55e5da4de8def29ae8d1.1495210061.git-series.gregory.clement@free-electrons.com>
 <CACRpkdY97DDcwec+J-4X1AT5a7Mbo4GnWUJmuAOYhNzOA8_HZQ@mail.gmail.com>
 <878tlnzps3.fsf@free-electrons.com>
 <CACRpkdbW3T5auXCMrqH_tTzcVseGbiV+y53fJ2xN5p-VbGz7rA@mail.gmail.com>
 <20170530222358.abta3srv5emz7wtp@rob-hp-laptop>
Message-ID: <87k24xtkbw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On mer., mai 31 2017, Rob Herring <robh@kernel.org> wrote:

> On Mon, May 29, 2017 at 10:08:16AM +0200, Linus Walleij wrote:
>> On Tue, May 23, 2017 at 3:06 PM, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>> >  On mar., mai 23 2017, Linus Walleij <linus.walleij@linaro.org> wrote:
>> 
>> >> Please rebase and resend the rest of the patches.
>> >
>> > Actually I was wrong with my assumption that there was no dependency.
>> > For the binding documentation there is dependecy accross the series I
>> > sent.
>> >
>> > This patch depends on "pinctrl: dt-bindings: add documentation for AP806
>> > pin controllers" [1] and "pinctrl: dt-bindings: add documentation for
>> > CP110 pin controllers" [3] from the series "Add support for the pin
>> > controllers on the Marvell Armada 7K/8K".
>> >
>> > As you are maintainer of both gpio and pinctrl subsystem it will be easy
>> > to resolv.
>> 
>> Please send all patches in one big series in that case, so I can apply
>> them all to a branch and merge that branch into both trees.
>> 
>> > But these last patches depend also on "clk: mvebu: ap806: introduce a
>> > new binding" [3] in the clock series "Improve ap806 clk support on
>> > Marvell Armada 7K/8K" and on "clk: mvebu: cp110: introduce a new
>> > binding" [4] in the clock series "Improve cp110 clk support on Marvell
>> > Armada 7K/8K".
>> 
>> That sounds messy.
>> 
>> > So for these particular patches, either I rebase them on the v4.12-rc2
>> > and there will be a small merge conflict during the merge window for
>> > v4.13, or we can ask a stable branch with only these few patches (I am
>> > adding the clock maintainer to this email).
>> >
>> > If we chose this last option I can split the clock patches to have patch
>> > modifying only the binding documentation.
>> 
>> I think you can make a patch just modifying the binding documentation
>> and then apply that patch to *both* trees, just make sure the patch
>> is *final* and not applied in different versions in clk and pinctrl.
>
> I thought we try to avoid doing that.
>
>> I think cross-tree branches for documentation clashes is too much
>> bureaucracy.
>
> I can just take all the doc patches separately. Or you can take the 
> clock one too.

If you can take all the doc patches I think we will managed to solve the
issue in a efficient way. So I am going to send a new version of the
clock series by splitting the "clk: mvebu: *: introduce a new binding"
patches so you will be able to only pick the doc part.

Thanks!

Gregory


>
>> Make sure your clock patch is finalized and preferably also applied
>> to the clk tree then put it in the bottom of the patch set you send
>> to me as well and I will proceed like above.
>> 
>> Yours,
>> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
