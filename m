From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 May 2014 23:56:23 +0200
Subject: [PATCH v3 6/7] Documentation: add the Marvell Berlin pinctrl
 documentation
In-Reply-To: <20140516164751.GA8406@kwain>
References: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399267649-20218-7-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkdaL9tzfUrY=wLjSR3dcD7JC1mUX3kdG+Wh5gDyxGY2Yqw@mail.gmail.com>
 <20140516164751.GA8406@kwain>
Message-ID: <CACRpkdbJvasUR2+gvLSCF=grgkofs-BaOFEzK1pE212LvVj1tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 6:47 PM, Antoine T?nart
<antoine.tenart@free-electrons.com> wrote:
> Linus,

>> > +sm_pinctrl: pin-controller at 0 {
>> > +       compatible = "marvell,berlin2q-sysmgr-pinctrl";
>> > +       reg = <0xfc0000 0x44>;
>> > +
>> > +       uart0_pmux: uart0-pmux {
>> > +               marvell,groups = "GSM12", "GSM13";
>> > +               marvell,function = "uart0";
>> > +       };
>> > +}
>>
>> I feel like ... can't we just standardize that and make it a common
>> pinctrl binding, and name the properties "groups" and "function"
>> for a family of pin controllers just mapping N groups to 1 function?
>>
>> I will merge the patches as are, but maybe we can make it generic
>> on top of this before the merge window?
>
> Do you mean just changing:
>
> s/marvell,groups/groups/
> s/marvell,function/function/
>
> and updating the documentation ?

To the pinctrl.txt document as generic bindings.
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

That and maybe moving some of the parsing into the pinctrl-utils.

> If so, I can definitely do that.

No big deal, we're a bit late on it. But if you like the looks of it,
please send a patch like that.

Yours,
Linus Walleij
