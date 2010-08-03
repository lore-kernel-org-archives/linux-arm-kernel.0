From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Aug 2010 08:32:50 +0100
Subject: IRQ dynamic distribution : A9-MPCore + GIC
In-Reply-To: <4C5795C8.7020002@st.com>
References: <4C5795C8.7020002@st.com>
Message-ID: <20100803073250.GB11987@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 09:36:32AM +0530, Suresh Shukla wrote:
>  Hi,
>
> Is there any available work on IRQ dynamic distribution for A9-MPCore  
> platform with GIC ?
> I see it is available for x86 APIC platform and priority based support  
> can be implemented for A9-MPCore/GIC combination.

I tried to get IRQ balancing working with the initial ARM SMP
implementation but I found it impossible to behave sanely within
kernel space.  I don't remember what the exact problems were though -
this was five or so years ago.

The advice I got from Arjan van de Ven (author of Powertop) was
not to bother - the kernel IRQ balancer is flawed because it constantly
shifts IRQs between CPUs, meaning that they don't benefit from cache
hotness.  There are also implementations for IRQ balancing in userspace
which could do a far better job.
