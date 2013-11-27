From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 27 Nov 2013 09:22:46 +0800
Subject: STOP THE MADNESS
In-Reply-To: <CACRpkdY9MTUDtDxRKRHCXch98cNiMS-dumQvaTH7gp1OCVUx6w@mail.gmail.com>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>	<CAL_Jsq+AYEN2GQxgkN5a+eJsC-80n9y6Y9JngpZN7FzbLGdENw@mail.gmail.com>
 <CACRpkdY9MTUDtDxRKRHCXch98cNiMS-dumQvaTH7gp1OCVUx6w@mail.gmail.com>
Message-ID: <52954966.8030706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/27/2013 06:09 AM, Linus Walleij wrote:
> On Tue, Nov 26, 2013 at 6:29 PM, Rob Herring <robherring2@gmail.com> wrote:
>
>> IMO, the whole commit causing this problem should be reverted for
>> additional reasons. Irq generic chp and irqdomains are orthogonal
>> features/infrastructure and should not be mutually exclusive. We need
>> to fix irq generic chip.
> This cannot be easily reverted due to a lot of code and fixes building
> on top of it, and even if it could I guess it will also break device tree
> use on these: git grep pl061 arch/arm/boot/dts
>
> As DT mandates that the irqdomain be used, or it cannot translate
> the IRQs as before this patch it uses an hard-coded base from
> platform data. This is one of those odd drivers that don't need
> one line of DT-specific code in it to work with device tree, yet
> it works.
>
> I guess what I have to do is take out the very board Russell has
> and that I happen to have also and just get to the bottom of this
> bug and fix it and test it.
>
> A pointer to an "ideal" GPIO chip + irq_chip driver would be highly
> appreciated ...
>
> Yours,
> Linus Walleij

Does qemu support the board that Russell is using? If so, we can fix & 
test it.

Regards
Haojian
