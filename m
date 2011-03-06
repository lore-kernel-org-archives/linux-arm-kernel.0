From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Sun, 6 Mar 2011 10:40:33 +0900
Subject: staging: iio: ak8975: make gpio platdata mandatory
In-Reply-To: <20110306005841.GF27468@n2100.arm.linux.org.uk>
References: <AANLkTik1MSkfyb36AHUOG+OK=h=rt1D4sbpyUiYg07dT@mail.gmail.com>
	<AANLkTinXLC+tb7AkVBm-_xKS4ukA6v_AHDKkHKWvP6i3@mail.gmail.com>
	<AANLkTikWcW4X2eHoYLk_Ctd0kG8uY8LE8g2HPJCki-N0@mail.gmail.com>
	<20110306005841.GF27468@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=C-M8cjEHkvPYfR+hQpBUuoG=wjR_XXPyYyfCD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,

On 6 March 2011 09:58, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Sun, Mar 06, 2011 at 09:31:41AM +0900, Naveen Krishna Ch wrote:
>> Hi Kyungmin Park,
>>
>> On 4 March 2011 14:51, Kyungmin Park <kmpark@infradead.org> wrote:
>> > Hi,
>> >
>> > On Fri, Mar 4, 2011 at 2:34 PM, Naveen Krishna Ch
>> > <naveenkrishna.ch@gmail.com> wrote:
>> >> Issue:
>> >> For some architectures CONFIG_GENERIC_GPIO is defined,
>> >> leaving irq_to_gpio undefined. ?Causing build break.
>> >
>> > It's better to implement the irq_to_gpio. Since gpio_to_irq is already
>> > implemented. it's just vice versa.
>> Implementing such macros in machine header files leads to inclusion of
>> mach/gpio.h or irqs.h
>> Russel King, seems against to the same...
>
> Four reasons:
>
> 1. including mach/gpio.h means that the code is non-portable to other
> ? architectures.
> 2. linux/gpio.h defines helpers for the !GENERIC_GPIO case.
> 3. it's good practice to always use linux/ includes rather than asm/ or
> ? mach/ where-ever possible.
> 4. over time, standard helpers tend to get split out into the common
> ? architecture-independent header files. ?Who would like to volunteer
> ? to fix up all the mach/gpio.h->linux/gpio.h when that happens.
I understand,  the complication created by using machine specific code.
>
> However:
>> >> For some architectures CONFIG_GENERIC_GPIO is defined,
>> >> leaving irq_to_gpio undefined. ?Causing build break.
>
> I read this as saying: "There are architectures which set
> CONFIG_GENERIC_GPIO but do not provide a definition for irq_to_gpio()".
> If that's true, then that's a problem for those architectures to solve.
I will start looking into fixing the problem, instead of this issue.

>
> However, first I'd like you to clear up some confusion: what do you mean
> by architecture? ?ARM/Sparc/x86? ?Or S3C2410 vs OMAP4430 vs Orion vs
> Tegra? ?The former are architectures. ?The latter are SoCs or families
> of SoCs/machines/platforms.
I mean, SoCs or families.
>
> Last point: do _not_ cc: mailing list managers for normal discussion
> email - I'm talking about the majordomo at vger.kernel.org which was in the
> CC in this thread.
Sorry my bad, Will correct it here on.

> Mailing list managers take specially formatted email
> messages in order to take automated action. ?They do not recognise plain
> language, and you'll probably get a verbose error reply.
Yes, I Did..
>
Thanks, for your prompt reply and the explanation.

-- 
Shine bright,
(: Nav :)
