From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 14 May 2015 18:07:33 +0200
Subject: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
In-Reply-To: <CAPyr0yLq7PsMW45G+oJzJLbQ-be6Xx9n2S2SU2CiV+AMH9jJ8Q@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
 <20150506193803.GC32577@8074w.roxell.se>
 <CAPyr0y+OYikc2Euh++2nTWnVb-aZ4i-tifLLk3XUiRahtHKjCA@mail.gmail.com>
 <20150508000929.GE31914@8074w.roxell.se>
 <CAPyr0yLq7PsMW45G+oJzJLbQ-be6Xx9n2S2SU2CiV+AMH9jJ8Q@mail.gmail.com>
Message-ID: <20150514160733.GE13442@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ayyappa Ch | 2015-05-11 11:02:56 [+0530]:

>Hello Anders Roxell,
>
>Many thanks for your inputs.
>
>But as per my observation after this change , Cyclic test did not failed.
>
>As logs are huge size , sent only to you.
>
>Can you please check the logs and let us know your view ?

fpsimd_save_state() is almost the fpsimd_save macro which saves 32
16byte registers. And *this* takes really that long? You max says 100116
which means 100ms.

>Thanks and regards,
>Ayyappa.Ch

Sebastian
