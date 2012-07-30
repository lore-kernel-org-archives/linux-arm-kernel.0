From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 30 Jul 2012 16:55:37 +0800
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <501646FC.60900@gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <201207291409.56645.arnd@arndb.de> <50159FBC.2010409@gmail.com>
 <201207300831.32988.arnd@arndb.de> <501646FC.60900@gmail.com>
Message-ID: <CAN1soZwmyf=Q5mBJhr6AXYp0RzJDj9eN0GBRFzB0gUMzwJzO3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 4:34 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 30.07.2012 10:31, Arnd Bergmann wrote:
>> On Sunday 29 July 2012, Daniel Mack wrote:
>>> And I also wonder whether using the second spec value for a priority
>>> wouldn't be somehow abusive? Isn't that considered to denote the trigger
>>> flags in contexts of interrupt controllers? At least, that is what
>>> irq_domain_xlate_twocell() assumes.
>>
>> You would not use irq_domain_xlate_twocell in that scenario but provide your
>> own, which is ok. Interpreting the second cell as the trigger flags is just
>> a convenient default because it's the most common use for that.
>
> I see. Don't know how much sense it makes to have that detail
> configurable though. Haojian? And I think we can still change that
> detail later.
>
Arnd's suggestion is good. So we can setup each interrupt's priority
while parsing
all these pxa interrupts. In current code, we only assign priority
with the irq number.
Maybe it's not perfect solution. For example, Timer interrupt should
have highest
priority. LCD interrupt also has higher priority.

It's worth to do. And it's also OK if you want to queue it into your TODO list.

By the way, which patches that you prefer not to go through pxa git tree?

Regards
Haojian
