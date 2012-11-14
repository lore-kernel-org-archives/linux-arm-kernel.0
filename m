From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Nov 2012 09:44:48 +0800
Subject: [PATCH v4 2/9] pinctrl: single: support gpio request and free
In-Reply-To: <20121113173404.GA6801@atomide.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-3-git-send-email-haojian.zhuang@gmail.com>
 <20121107222738.GR6801@atomide.com>
 <CACRpkdbJzjZGLmCA+2mw6ahAVUXuhdpysnyiK7nuj8PLh_QNXg@mail.gmail.com>
 <20121113173404.GA6801@atomide.com>
Message-ID: <CAN1soZzYb2M3kj2O_1zU8oG6i5bq_5xNdSeue+XVK02TkaoKXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 1:34 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [121113 05:09]:
>> On Wed, Nov 7, 2012 at 11:27 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:21]:
>> >> Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
>> >> Each pin binds to one register. A lot of pins could be configured
>> >> as gpio.
>> >>
>> >> Now add these properties in below.
>> >> <gpio range phandle>:
>> >>       include "pinctrl-single,gpio" & "pinctrl,gpio-func" properties.
>> >>
>> >>       pinctrl-single,gpio: <gpio base, npins in range, register offset>
>> >>
>> >>       pinctrl-single,gpio-func: <gpio function value in mux>
>> >>
>> >> pinctrl-single,gpio-ranges: phandle list of gpio range array
>> >
>> > This one looks OK to me now:
>> >
>> > Acked-by: Tony Lindgren <tony@atomide.com>
>> >
>>
>> So:
>> - Will this patch in isolation apply to my pinctrl tree?
>> - In that case, do you want me to apply it?
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I guess the best way to go is if Linus applies this and
> the debugfs fix one into some immutable pinctrl branch that
> various SoC branches can pull in as needed.
>
> The generic pinconf patch still needs few updates.
>
> Regards,
>
> Tony
>
I prefer to hold on this patch since I found some gpio range code are
also contained in the
pinconf patch. I'll merge them together in the next round.
