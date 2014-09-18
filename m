From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 18 Sep 2014 20:34:47 +0200
Subject: [PATCH] ARM: zImage: add support for ARMv7-M
In-Reply-To: <201409181938.46996.arnd@arndb.de>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
 <201409181938.46996.arnd@arndb.de>
Message-ID: <CAGhQ9VxMKD-DcFhobUky3FnKjerTiv66w4PSCPfi+=bo_zWgUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 September 2014 19:38, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 September 2014, Joachim Eastwood wrote:
>>   ARM(          mov     pc, r4  )               @ call kernel
>> - THUMB(                bx      r4      )               @ entry point is always ARM
>> +#ifdef CONFIG_CPU_V7M
>> +               add     r4, r4, #1              @ enter in Thumb mode for ARMv7M
>> +#endif
>> + THUMB(                bx      r4      )               @ entry point is always ARM for non ARMv7M CPUs
>>
>
> I think it would be much nicer to avoid sprinkling #ifdefs here. We already
> have the ARM() and THUMB() macros to deal with the two cases we support, which
> are booting in ARM mode vs ARMv7-A with THUMB2 mode. We can probably add
> another macro like this to deal with the ARMv7-M case that does not have
> ARM mode.

Well, I guess I could make a THUMBONLY macro or something like that.
But I think that the macro would only be useful in the case you quoted
above. The other ifdefs in the patch are either for large blocks or
removing code. So I don't think it would improve the patch a great
deal.

btw, do you have better name suggestion than THUMBONLY?

regards
Joachim Eastwood
