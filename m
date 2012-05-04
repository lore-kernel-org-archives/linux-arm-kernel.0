From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 May 2012 20:22:10 +0200
Subject: [PATCH 04/15] drivers/net: Do not free an IRQ if its request
 failed
In-Reply-To: <4FA3E35B.3000604@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-5-git-send-email-lee.jones@linaro.org>
 <4FA3E35B.3000604@linaro.org>
Message-ID: <CACRpkdaB+mAmo50uSDvVcq=V9_BF01-zu2WHUU+cc2WPU1NEXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 4:10 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On 19/04/12 21:36, Lee Jones wrote:

>> - ? ? ? ? ? ? ? goto out_free_irq;
>> + ? ? ? ? ? ? ? goto out_disable_resources;
>> ? ? ? ?}
>>
>> ? ? ? ?retval = register_netdev(dev);
>
>
> Anything on this from the Net guys?

This was merged for 3.4-rc5, check:
https://lkml.org/lkml/2012/4/29/2

Linus Walleij
