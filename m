From: ayyappa.ch.linux@gmail.com (Ayyappa Ch)
Date: Sat, 16 May 2015 12:08:53 +0530
Subject: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
In-Reply-To: <20150514160733.GE13442@linutronix.de>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
 <20150506193803.GC32577@8074w.roxell.se>
 <CAPyr0y+OYikc2Euh++2nTWnVb-aZ4i-tifLLk3XUiRahtHKjCA@mail.gmail.com>
 <20150508000929.GE31914@8074w.roxell.se>
 <CAPyr0yLq7PsMW45G+oJzJLbQ-be6Xx9n2S2SU2CiV+AMH9jJ8Q@mail.gmail.com>
 <20150514160733.GE13442@linutronix.de>
Message-ID: <CAPyr0yL8xJt4bj7poLFrauR0wtfKB7nPg+uy4A+R0dTT-eM3Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes. Due to preemt_disable and preempt_enable is causing the delay.

As cyclic log is really big , i will be sending it to you separately.

After this fix , cyclic test is completed succesfully.

On Thu, May 14, 2015 at 9:37 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Ayyappa Ch | 2015-05-11 11:02:56 [+0530]:
>
>>Hello Anders Roxell,
>>
>>Many thanks for your inputs.
>>
>>But as per my observation after this change , Cyclic test did not failed.
>>
>>As logs are huge size , sent only to you.
>>
>>Can you please check the logs and let us know your view ?
>
> fpsimd_save_state() is almost the fpsimd_save macro which saves 32
> 16byte registers. And *this* takes really that long? You max says 100116
> which means 100ms.
>
>>Thanks and regards,
>>Ayyappa.Ch
>
> Sebastian
