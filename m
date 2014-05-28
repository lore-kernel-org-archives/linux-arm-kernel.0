From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 May 2014 10:53:19 +0200
Subject: [linux-sunxi] Re: [PATCH 01/11] pinctrl: sunxi: create irq/pin
 mapping during init
In-Reply-To: <CAGb2v65NW61+BV2hR3wn_xRvCyPo+AhcMU7hmFjQxKWj49G=Bw@mail.gmail.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-2-git-send-email-hdegoede@redhat.com>
 <CACRpkdZpy2aT_kFp01bnrviVB3SOggiNUJB46wbWAY_bqW8=gg@mail.gmail.com>
 <CAGb2v65NW61+BV2hR3wn_xRvCyPo+AhcMU7hmFjQxKWj49G=Bw@mail.gmail.com>
Message-ID: <CACRpkdbJJWXyO-beDCed5rBfAx0aMmdXLTUDtYuyWZGfABXzpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 4:21 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, May 27, 2014 at 10:11 PM, Linus Walleij

>> I tried to hack the sunxi driver to even use the gpiolib
>> irqchip helpers but exactly this complex map thing in
>> ->irq_array[] git me stuck. If any of you guys could be so
>> nice to take a stab at this (compare to other commits
>> converting drivers to use gpiolibs irqchip helpers) then
>> I'd be very happy.
>
> We still need to rework the whole irqchip stuff for sun6i/sun8i,
> which have 1 parent interrupt per EINT capable pin bank.
>
> Earlier discussions with Maxime (on IRC IIRC) suggested moving this
> over to gpiolib irqchip helpers might be more work than using our own
> irqchip implementation, requiring 1 gpiochip per pin group? (not sure)

OK then keep your current code. I do not intend to cover all
cases in the world with these helpers, just the simple cases.
Complex hardware merits complex code.

Yours,
Linus Walleij
