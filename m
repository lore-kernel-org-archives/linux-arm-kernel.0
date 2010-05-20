From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 20 May 2010 18:10:11 +0800
Subject: [RFC PATCH v2] preliminary support for sparse IRQ
In-Reply-To: <AANLkTimvwmdYobnycek2qGxIX0MZFWNOVD-0pIxUB7cH@mail.gmail.com>
References: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
	<3319586236559971954@unknownmsgid>
	<AANLkTimvwmdYobnycek2qGxIX0MZFWNOVD-0pIxUB7cH@mail.gmail.com>
Message-ID: <AANLkTinJAVNlAGZFysLiJEkrUv0XAjBcF3uZKy89DIk2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 5:25 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, May 20, 2010 at 5:21 PM, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Eric,
>>
>>> +#ifdef CONFIG_SPARSE_IRQ
>>> +int __init arch_probe_nr_irqs(void)
>>> +{
>>> + ? ? nr_irqs = arch_nr_irqs ? arch_nr_irqs : NR_IRQS;
>>> + ? ? return 0;
>>> +}
>>> +#endif
>>
>> Possibly a daft question, but if CONFIG_SPARSE_IRQ is
>> not set, where does nr_irqs get assigned to?
>>
>> Other than that, looks good to me.
>>
>
> It's defined as NR_IRQS then.
>

Sorry, initialized to NR_IRQS. In kernel/irq/handle.c, around line 72.
