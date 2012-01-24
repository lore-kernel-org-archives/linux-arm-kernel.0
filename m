From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Jan 2012 23:00:31 +0100
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <20120124110410.GF19798@mudshark.cambridge.arm.com>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
 <20120120174456.GB11845@n2100.arm.linux.org.uk>
 <20120122125411.GA27821@mudshark.cambridge.arm.com>
 <20120122152710.GT1068@n2100.arm.linux.org.uk>
 <20120124110410.GF19798@mudshark.cambridge.arm.com>
Message-ID: <CACRpkdazORvVrfTkNzeSZRpLdGQRY=RbsQzuAVZC+SZ_jWsv8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 12:04 PM, Will Deacon <will.deacon@arm.com> wrote:
> [Russell]
>> So, if you have interrupts which can only be serviced by a group of CPUs,
>> at least one of those CPUs must remain online at all times that those
>> dependent devices could produce an interrupt.
>>
>> I think what we want instead is for the IRQ subsystem to record on a
>> per-IRQ basis which CPUs the interrupt /can/ be routed to, and if:
>>
>> ? ? ? affinity & cpus_online & allowable_cpus
>>
>> becomes empty, the attempt to set the affinity is failed. ?Also, a callback
>> in the hotplug code to error out if
>>
>> ? ? ? cpus_online & allowable_cpus & ~offlining_cpu
>>
>> would become an empty set.
>
> That looks like a good idea to me. I suggest we wait until somebody builds
> such a monster and get them to implement the solution :) (unless the ux500 is
> capable of booting on a CPU other than 0?).

No it needs to boot on 0. So let's let this thread sleep ...

Thanks,
Linus Walleij
