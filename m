From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 19 Oct 2010 22:21:10 +0200
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <8762wyyv99.fsf@deeprootsystems.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-2-git-send-email-ohad@wizery.com>
	<8762wyyv99.fsf@deeprootsystems.com>
Message-ID: <AANLkTi=4hYRJheBBLJARJr_s5RbMs3APFTKD-pk1VJEy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 6:58 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> + ? ? ?* This spin_trylock_irqsave serves two purposes:
>> +
>> + ? ? ?* 1. Disable local interrupts and preemption, in order to
>> + ? ? ?* ? ?minimize the period of time in which the hwspinlock
>> + ? ? ?* ? ?is taken (so caller will not preempted). This is
>> + ? ? ?* ? ?important in order to minimize the possible polling on
>> + ? ? ?* ? ?the hardware interconnect by a remote user of this lock.
>> + ? ? ?*
>> + ? ? ?* 2. Make this hwspinlock primitive SMP-safe (so we can try to
>> + ? ? ?* ? ?take it from additional contexts on the local cpu)
>> + ? ? ?*/
>
> 3. Ensures that in_atomic/might_sleep checks catch potential problems
> ? with hwspinlock usage (e.g. scheduler checks like 'scheduling while
> ? atomic' etc.)

Nice one. Added.

>> +/**
>> + * omap_hwspinlock_unlock() - unlock a specific hwspinlock
>
> minor nit: s/lock_unlock/_unlock/ ?to match name below

Thanks.
