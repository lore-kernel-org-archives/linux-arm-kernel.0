From: lznuaa@gmail.com (Frank Li)
Date: Tue, 19 Mar 2013 15:49:50 +0800
Subject: Anyone implement Cortex A9 FIQ
In-Reply-To: <514764E2.6040101@arm.com>
References: <CAHrpEqSQ1n_WUfxoraKZFS2A8NjdP_MCcWmJdCjcon_QwgX4Hw@mail.gmail.com>
 <5142FBF5.3010307@arm.com>
 <CAHrpEqSO89Lx=EGTJJ_XOFwkHqL=heoOUQCtJUzm6D7mEAbWiw@mail.gmail.com>
 <514764E2.6040101@arm.com>
Message-ID: <CAHrpEqT9SSbHYK62i0ZteEd4SfZaa_nw+T0SHunP2W+MUEqmrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Whether this is feasible will really depend on what platform you're on - if
> there's a secure monitor then FIQs are out of the question anyway. Can you
> tell us more about the system?

Freescale MX6Q.

>
> If your average interrupt latency is low then you should just be able to do
> this with normal IRQs (have you got threaded interrupt handlers?)

Not all drivers use threaded interrupt handler.

>
> What is it about the situation that leads you to believe that you *need*
> FIQ?

FIQ can be executed even in spin_lock_saveirq.
We want do very small hardware set at related precision period (every 125us).

>
> Jonny
>
>
>
