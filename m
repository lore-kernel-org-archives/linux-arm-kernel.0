From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Feb 2016 22:44:28 +0100
Subject: LPC18xx doesn't boot on linux-next
In-Reply-To: <CAAEAJfCB6REQe6TiCR1z3m4LnsCfp0O2zD5=fLhSGADJzF5qPA@mail.gmail.com>
References: <CAAEAJfB4_JbRMC5Y5siqPR__Tr8V6x15DSuvEdANxVNjiB-v3w@mail.gmail.com>
 <CAGhQ9VyyhCKy4qCFAe-WQ45OjLCSa8AmExL8YkWnSdYNE2v_2w@mail.gmail.com>
 <CAAEAJfCB6REQe6TiCR1z3m4LnsCfp0O2zD5=fLhSGADJzF5qPA@mail.gmail.com>
Message-ID: <CAGhQ9VxcktYKb26MLLmio_H2AnvPTpt55pCs+R+iru3x1a_b=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 February 2016 at 22:25, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> On 21 February 2016 at 18:14, Joachim  Eastwood <manabian@gmail.com> wrote:
>> Hi Ezequiel,
>>
>> On 21 February 2016 at 21:17, Ezequiel Garcia
>> <ezequiel@vanguardiasur.com.ar> wrote:
>>> Hey Joachim,
>>>
>>> I've noticed that my Hitex LPC4350 doesn't boot with latest next.
>>> Here's the bootlog,
>>> with lpc18xx_defconfig.
>>
>> Thanks for reporting.
>>
>> The 'would create circular parent' message doesn't seem to exist in
>> v4.5rc and seem to have been added by 858d58815 'clk: avoid circular
>> clock topology'.
>>
>> Does it help to revert that commit? if not could you bisected it?
>>
>
> Indeed, reverting 858d58815 works, and allows to boot the board.

Thanks for testing.

I have now replied on the clk patch which broke lpc18xx with you on
cc, so we'll take it from there.


> (BTW: forgot to mention that you need to apply
> "ARM: fix __start_rodata_section_aligned on XIP" as !MMU build seems
> broken on linux-next without it).

Ok, I see. It is been while since I have tried booting next.


regards,
Joachim Eastwood
