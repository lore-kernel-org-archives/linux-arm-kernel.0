From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 27 May 2014 22:21:04 +0800
Subject: [linux-sunxi] Re: [PATCH 01/11] pinctrl: sunxi: create irq/pin
 mapping during init
In-Reply-To: <CACRpkdZpy2aT_kFp01bnrviVB3SOggiNUJB46wbWAY_bqW8=gg@mail.gmail.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-2-git-send-email-hdegoede@redhat.com>
 <CACRpkdZpy2aT_kFp01bnrviVB3SOggiNUJB46wbWAY_bqW8=gg@mail.gmail.com>
Message-ID: <CAGb2v65NW61+BV2hR3wn_xRvCyPo+AhcMU7hmFjQxKWj49G=Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 10:11 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> The irq/pin mapping is used to lookup the pin to mux to the irq
>> function when the irq is enabled. It is created when gpio_to_irq
>> is called. Creating the mapping during init allows us to map the
>> interrupts directly from the device tree.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> This is exactly correct. Patch applied.

Thanks.

> I tried to hack the sunxi driver to even use the gpiolib
> irqchip helpers but exactly this complex map thing in
> ->irq_array[] git me stuck. If any of you guys could be so
> nice to take a stab at this (compare to other commits
> converting drivers to use gpiolibs irqchip helpers) then
> I'd be very happy.

We still need to rework the whole irqchip stuff for sun6i/sun8i,
which have 1 parent interrupt per EINT capable pin bank.

Earlier discussions with Maxime (on IRC IIRC) suggested moving this
over to gpiolib irqchip helpers might be more work than using our own
irqchip implementation, requiring 1 gpiochip per pin group? (not sure)


ChenYu
