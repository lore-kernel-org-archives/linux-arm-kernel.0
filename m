From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Oct 2016 11:38:15 +0100
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
 <1477040798.15560.96.camel@baylibre.com>
 <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
Message-ID: <ec7c6cc5-cf9a-9c75-4b07-e337064c7d6e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/16 10:14, Linus Walleij wrote:
> On Fri, Oct 21, 2016 at 11:06 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
>>> Isn't this usecase (also as described in the cover letter) a textbook
>>> example of when you should be using hierarchical irqdomain?
>>>
>>> Please check with Marc et al on hierarchical irqdomains.
>>
>> Linus,
>> Do you mean I should create a new hierarchical irqdomains in each of
>> the two pinctrl instances we have in these SoC, these domains being
>> stacked on the one I just added for controller in irqchip ?
>>
>> I did not understand this is what you meant when I asked you the
>> question at ELCE.
> 
> Honestly, I do not understand when and where to properly use
> hierarchical irqdomain, even after Marc's talk at ELC-E.

I probably didn't do that good a job explaining it then. Let's try
again. You want to use hierarchical domains when you want to describe an
interrupt whose path traverses multiple controllers without ever being
multiplexed with other signals. As long as you have this 1:1
relationship between controllers, you can use them.

> Which is problematic since quite a few GPIO drivers now
> need to use them.
> 
> I will review his slides, in the meantime I would say: whatever
> Marc ACKs is fine with me. I trust this guy 100%. So I guess I
> could ask that he ACK the entire chain of patches
> from GIC->specialchip->GPIO.

Man, I don't even trust myself... ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
