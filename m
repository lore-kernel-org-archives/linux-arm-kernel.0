From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Nov 2015 16:50:41 +0100
Subject: pj4 -marm breaks thumb ftrace
In-Reply-To: <alpine.LFD.2.20.1511120953020.5826@knanqh.ubzr>
References: <20151112095020.GB15032@codeaurora.org>
 <56446A40.7000304@linaro.org>
 <alpine.LFD.2.20.1511120953020.5826@knanqh.ubzr>
Message-ID: <CAKv+Gu-h5VYx+18KBg1y6o3JbqR+Fyhy6Ne7ZUDfFChCKJ5O5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 16:22, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 12 Nov 2015, Ard Biesheuvel wrote:
>
[...]
>
> You might add __INIT here.
>
>> +ENTRY(pj4_cp_access_read)
>> +     mrc     p15, 0, r0, c1, c0, 2
>> +     ret     lr
>> +ENDPROC(pj4_cp_access_read)
>> +
>> +ENTRY(pj4_cp_access_write)
>> +     mcr     p15, 0, r0, c1, c0, 2
>> +     mrc     p15, 0, r0, c1, c0, 2
>> +     mov     r0, r0
>> +     sub     pc, pc, #4
>> +     ret     lr
>> +ENDPROC(pj4_cp_access_write)
>> +
>
> And __FINIT here.
>

OK, I will do that. Thanks for the tip.

-- 
Ard.
