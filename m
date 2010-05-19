From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 19 May 2010 14:53:43 +0800
Subject: [RFC PATCH v2] preliminary support for sparse IRQ
In-Reply-To: <201005182345.07740.marek.vasut@gmail.com>
References: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
	<201005182345.07740.marek.vasut@gmail.com>
Message-ID: <AANLkTiniR4yBC_JlXCVyRXoGZdUClEtuO_wIYT-qtYLV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> - ? ? if (i < NR_IRQS) {
>> - ? ? ? ? ? ? raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
>> - ? ? ? ? ? ? action = irq_desc[i].action;
>> + ? ? if (i < nr_irqs) {
>> + ? ? ? ? ? ? desc = irq_to_desc(i);
>> + ? ? ? ? ? ? raw_spin_lock_irqsave(&desc->lock, flags);
>> + ? ? ? ? ? ? action = desc->action;
>
> Possibly stupid question, but shouldn't you asign 'desc' after locking ?
>

Locking is actually performed on desc->lock, that's why it needs desc to
be first assigned.
