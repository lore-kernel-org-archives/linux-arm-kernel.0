From: holler@ahsoftware.de (Alexander Holler)
Date: Sat, 03 Aug 2013 09:23:39 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <51FBD1CA.1000202@ahsoftware.de>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <51F8CC35.1070704@collabora.co.uk> <51FB8292.9090000@ahsoftware.de>
 <51FBD1CA.1000202@ahsoftware.de>
Message-ID: <51FCAFFB.4000005@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.08.2013 17:35, schrieb Alexander Holler:
> Am 02.08.2013 11:57, schrieb Alexander Holler:
> 
>> There must have been a bug in the patch too. I've also added that
>> iinterrupt-parent stuff (with the same flags as used by the driver) and
>> just have let the driver call
>>
>> request_threaded_irq(gpio_to_irq(gpio), flags);
>>
>> without the gpio_request()/input() before. And request_threaded_irq()

Thinking again about what I've tried, I might have make the failure to
add the interrupt-parent line to the mmc-section (where the gpio was
specified) and not to the gpio(-controller) section where it might have
belong too (again, there was no example and no documentation).

But why I again bother you all with another mail, is that I don't like
the fact that the irq-flags might have to be specified in the DT and the
source (and they have to match).

A solution might be to use the flags specified in the DT for the
particular irq and ignore the flags specified as parameter to
request_irq(). At least as long as DT isn't mandatory. And in the
future, the flags could just be removed from the call to request_irq()
depending (then visible too) only on the flags as specified in the DT.

Regards,

Alexander Holler
