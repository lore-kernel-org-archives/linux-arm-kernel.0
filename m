From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 30 Nov 2010 09:47:44 +0000
Subject: [PATCH v2] ARM: Allow SMP_ON_UP to work with Thumb-2 kernels.
In-Reply-To: <alpine.LFD.2.00.1011292239220.9313@xanadu.home>
References: <1291055974-2090-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011292239220.9313@xanadu.home>
Message-ID: <AANLkTikZ-tzyOQOa+0WwoEUpjKqXf4GG10dv-4uQWBbX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 3:44 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 29 Nov 2010, Dave Martin wrote:
>
>> v2:
>>
>> + ARM( ? ? ? ?str ? ? r4, [r0, r3] ? ?)
>> + THUMB( ? ? ?add ? ? r0, r0, r3 ? ? ?)
>> +#ifdef __ARMEB__
>> + THUMB( ? ? ?mov ? ? r4, r4, ror #16 ) ? ? ? @ Convert word order for big-endian.
>> +#endif
>> + THUMB( ? ? ?strh ? ?r4, [r0], #2 ? ?) ? ? ? @ For Thumb-2, store as two halfwords
>> + THUMB( ? ? ?mov ? ? r4, r4, lsr #16 ) ? ? ? @ to be robust against misaligned r3.
>> + THUMB( ? ? ?strh ? ?r4, [r0] ? ? ? ?) ? ? ? @ NOTE: currently assumes little-endian.
>
> That comment above is now obsolete.

Quite right!

I'll fix that...

>
> Otherwise:
>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks
---Dave

>
>
> Nicolas
>
