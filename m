From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Nov 2012 17:14:21 +0000
Subject: [PATCH v4 08/14] KVM: ARM: World-switch implementation
In-Reply-To: <CANM98q+TQZiXe3GLjcPpPVZz40emmizgnEmyZEju1ruKNR6EEQ@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154306.2836.93473.stgit@chazy-air>
 <20121119145758.GA3205@mudshark.cambridge.arm.com>
 <CANM98qJFFP=2ueyUpbN6x15XwtWXbgZjkMBaq2jVpqik4kT54Q@mail.gmail.com>
 <20121130151500.GC26289@mudshark.cambridge.arm.com>
 <CANM98q+TQZiXe3GLjcPpPVZz40emmizgnEmyZEju1ruKNR6EEQ@mail.gmail.com>
Message-ID: <20121130171420.GC619@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 04:47:40PM +0000, Christoffer Dall wrote:
> On Fri, Nov 30, 2012 at 10:15 AM, Will Deacon <will.deacon@arm.com> wrote:
> > At this point, VM1 is running and VM0:VCPU1 is running. VM0:VCPU0 is not
> > running because physical CPU0 is handling an interrupt. The problem is that
> > when VCPU0 *is* resumed, it will update the VMID of VM0 and could be
> > scheduled in parallel with VCPU1 but with a different VMID.
> >
> > How do you avoid this in the current code?
> >
> I don't. Nice catch. Please apply your interesting brain to the following fix:)

I'm far too sober to look at your patch right now, but I'll think about it
over the weekend [I can't break it at a quick glance] :)

In the meantime, can you think about whether the TLB operations need to run
on every CPU please?

Will
