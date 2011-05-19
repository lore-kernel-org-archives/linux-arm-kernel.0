From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 15:17:35 +0200
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <BANLkTim2rv9QHDd2zjBfyVqG9dSGCM=PAw@mail.gmail.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=poU17RqAzp28CPjWHrN_+aFiyag@mail.gmail.com>
	<BANLkTindee6UMez8HyBUwd2H6mN-DknzPw@mail.gmail.com>
	<BANLkTik7BnJKWCsm2L3-GJPTaaiXFNSgaA@mail.gmail.com>
	<BANLkTim2rv9QHDd2zjBfyVqG9dSGCM=PAw@mail.gmail.com>
Message-ID: <BANLkTinABWucqESqSRYJV+-frm6vDmpxFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 2:35 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2011/5/19 Linus Walleij <linus.walleij@linaro.org>:
>> On Thu, May 19, 2011 at 1:38 PM, Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> looks like the driver can't be a real module, is the module_exit
>>> suitable? it looks strange module_exit plays together with
>>> arch_initcall.
>>
>> It's a rather common design pattern in the kernel for early
>> platform drivers. Either the dependencies are resolved by the
>> different initlevels or they are resolved in probe order with
>> loadable modules. Module load will call all initlevels in order.
>>
>> It is not elegant but it is common.
>
> Linus, thanks for your reply. module_exit and related functions are
> really useless codes. but people have done that before, then we have
> no way except following.
> u300_gpio_exit never gets chance to run and when we disassemble
> vmlinux, u300_gpio_exit() ?function should be not in the final binary
> at all, just a symbol name is left.

I know. I can make the Kconfig options tristate if it makes you feel
better...

Linus Walleij
