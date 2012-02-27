From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Feb 2012 08:44:09 +0100
Subject: [PATCH] ARM: integrator: convert to sparse irqs
In-Reply-To: <4F4AFB95.9040204@gmail.com>
References: <1330104737-22782-1-git-send-email-linus.walleij@linaro.org>
 <20120224191541.GB21556@game.jcrosoft.org>
 <CACRpkdbjeAmD=AsybOEkYFMUEyvfwONawdDGtfwMhBhrKyg2hQ@mail.gmail.com>
 <4F4AFB95.9040204@gmail.com>
Message-ID: <CACRpkdag3BsubBgTiNM35e97OmjHpzAseEz0WK3oo5rQ5i8S_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 4:42 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 02/26/2012 03:45 AM, Linus Walleij wrote:
>> On Fri, Feb 24, 2012 at 8:15 PM, Jean-Christophe PLAGNIOL-VILLARD
>> <plagnioj@jcrosoft.com> wrote:
>>> On 18:32 Fri 24 Feb ? ? , Linus Walleij wrote:
>>
>>>> -#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ? 47
>>>> +#define NR_IRQS_INTEGRATOR_AP ? ? ? ? ? ? ? ?34
>>>> +#define NR_IRQS_INTEGRATOR_CP ? ? ? ? ? ? ? ?47
>>>
>>> why do you need to specified both?
>>
>> They are two totally different machines and should never have had that
>> common roof of NR_IRQS = max(AP,CP), it's just not elegant.
>>
>> Maybe I'm a bit pedantic but I want to set the .nr_irqs for each machine so that
>> it corresponds exactly to what it actually has, instead of using a roof value.
>> I think it improves readability and understanding.
>
> Really, you want to get rid of the value altogether. Each irq_chip
> should allocate its irq_descs and then you don't need to set .nr_irqs.

OK can you point to a machine that does it the right way and
I'll fix.

Or do I need the irq domains lib to go in first to do that in a
good/non-awkward way?

Yours,
Linus Walleij
