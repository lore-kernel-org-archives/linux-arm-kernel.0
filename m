From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 16 Sep 2016 17:45:48 +0200
Subject: [PATCH v3 0/2] KVM: ARM: Enable vtimers with user space gic
In-Reply-To: <20160916134619.jjiaplhxgkkl5qri@kamzik.localdomain>
References: <1474007187-18673-1-git-send-email-agraf@suse.de>
 <57DBC782.7080305@arm.com> <7beb406b-6194-8451-2d92-9a4394ef91dd@redhat.com>
 <20160916123039.GB14140@cbox>
 <da8191ca-6fb1-f960-872c-d6bc27172db8@redhat.com>
 <20160916133027.GA27036@cbox>
 <20160916134619.jjiaplhxgkkl5qri@kamzik.localdomain>
Message-ID: <b4cdb857-cdd3-2f80-4642-c41aaa5e762b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/09/2016 15:46, Andrew Jones wrote:
> > But I haven't even looked at the patches in detail, I was just replying
> > to the comment about testing.
>
> This may be a great time to start encouraging feature writers to submit
> kvm-unit-tests patches at the same time as the feature (Hi Alex :-) I'm
> happy to help when a test isn't easy to write due to a lack of framework,
> but don't have nearly enough bandwidth to write all the tests myself.

In this case really a kernel smoke test can just work.  But yes,
architectural timer tests would be nice too.

> As for additional motivation for this series, I'll point out that it's
> good for bug isolation. When a guest fails to boot over KVM I can try
> TCG. If that works, then I've likely narrowed it to KVM. If I can
> further try kernel_irqchip=no, then I may further narrow it down to
> the vgic implementation.

(Or vice versa to the userspace GIC if you're looking at a TCG bug).

Paolo
