From: drjones@redhat.com (Andrew Jones)
Date: Thu, 18 Oct 2018 22:25:57 -0500
Subject: kvm-unit-tests gicv2 cases fail
In-Reply-To: <CAD8of+q29DrQa4Ay6karXC19vXzX++2T8FR-V1SAjGuO0ejYhQ@mail.gmail.com>
References: <CAD8of+q29DrQa4Ay6karXC19vXzX++2T8FR-V1SAjGuO0ejYhQ@mail.gmail.com>
Message-ID: <20181019032557.h2je3v7frp7nnnj4@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 05:17:57PM +0800, Li Zhang wrote:
> Hi,
> 
> I run kvm-units-test on ARM server(QDF2400), but gicv2-ipi,
> gicv2-active cases fail.
> By debuging kvm-unit-tests source code, I found that interrupt is not
> handled. do_handle_exception is not called.
> 
> By looking into KVM source code, it has GICv2 emulation on GICv3 support.
> I've tried a lot of kernel versions, from v4.12~v4.19 in mainline,
> these cases always fail.
> Is it possible that hardware/software disables this?
> 
> It seems that GICv2 is a little old for ARM server, I am confused when
> we can use it.
> Do we need to care about these cases?

We care, but I haven't seen these issues, and, if this only reproduces on
a gicv2 emulation on gicv3 configuration, then I don't have any hardware
where I can reproduce/debug it.

Thanks,
drew
