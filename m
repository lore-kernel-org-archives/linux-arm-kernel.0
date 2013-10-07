From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 7 Oct 2013 09:19:17 -0700
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for BE
 correct operation
In-Reply-To: <20131007155230.GQ12758@n2100.arm.linux.org.uk>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
 <1381160903-1248-2-git-send-email-victor.kamensky@linaro.org>
 <20131007155230.GQ12758@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr1GRcK=dEmhJ=U4vsQcwSdAuE3W78=KSjjE_pwCev2MnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 October 2013 08:52, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 07, 2013 at 08:48:23AM -0700, Victor Kamensky wrote:
>> -#define ASID(mm)     ((mm)->context.id.counter & ~ASID_MASK)
>> +#define ASID(mm)     ((unsigned int)((mm)->context.id.counter & ~ASID_MASK))
>
> Not a big problem, but "unsigned" is sufficient as per my suggestion.
> See:
>
>         http://en.wikipedia.org/wiki/C_data_types
>
> or look it up in the C standards. :)  I'll take it either way.

Understood, I just tried to be consistent with the rest of file -
'unsigned int' was
used just few lines above place that got changed.

Thanks,
Victor
