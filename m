From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Sep 2017 17:20:21 +0100
Subject: [PATCH v2 08/29] ARM: head: use PC-relative insn sequence for
 __smp_alt
In-Reply-To: <nycvar.YSQ.7.76.1709041215450.8603@knanqh.ubzr>
References: <20170903120757.14968-1-ard.biesheuvel@linaro.org>
 <20170903120757.14968-9-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1709041215450.8603@knanqh.ubzr>
Message-ID: <CAKv+Gu9=kZr9xf7x3wj3XArrVESMT5jz3CixG-3_1+JYGqmqmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2017 at 17:19, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sun, 3 Sep 2017, Ard Biesheuvel wrote:
>
>> Replace the open coded PC relative offset calculations with a pair
>> of adr_l invocations. This ensures these quantities are invariant
>> under runtime relocation.
>
> You probably should add that this patch must be applied on top of "ARM:
> kernel: use relative references for UP/SMP alternatives" because of the
> expected r3 value prior to that patch.
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>

Yes, that is why I needed to reorder them. I will add a mention to the
commit log.

Thanks,
