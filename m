From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Mar 2013 08:56:30 -0500
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com> <201303121933.47994.arnd@arndb.de>
 <513F9597.8050000@gmail.com>
 <CAD6h2NTNFZM4cgDmCJG+NrNbd27MdXGGsRCTpC1bJGeMAgcP-g@mail.gmail.com>
 <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
Message-ID: <5140858E.9000400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 01:41 AM, Linus Walleij wrote:
> On Wed, Mar 13, 2013 at 3:04 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>> On 13 March 2013 04:52, Rob Herring <robherring2@gmail.com> wrote:
>>> On 03/12/2013 02:33 PM, Arnd Bergmann wrote:
>>>> On Tuesday 12 March 2013, Rob Herring wrote:
>>>>> On 03/12/2013 12:08 PM, Haojian Zhuang wrote:
>>>
>>> Since the primecell ID registers are defined to be at 0xFF? offset, it
>>> is quite impossible for the integrator timers to have the ID registers
>>> within their 0x100 address space.
>>>
>> I'm sorry that I don't know this. I can add "arm,integrator-timer" into
>> compatible table of sp804 driver. I think that we could resolve this
>> issue. What's your opinion?
> 
> As per the other discussion:
> 
> The Integrator/AP has a timer which is different from the SP804.
> 
> The Integrator/CP has an SP804.

Not quite. I was wrong that they are the same, The AP has 16-bit timers
and the CP has 32-bit timers. While the individual timer on the AP is
the same programming model as the sp804, it is still not the sp804 block.

Rob

> 
> Please restrict the patch set to Integrator/CP.
> 
> Yours,
> Linus Walleij
> 
