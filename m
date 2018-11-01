From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 1 Nov 2018 11:10:48 +0100
Subject: kvm-unit-tests gicv2 cases fail
In-Reply-To: <CAD8of+q29DrQa4Ay6karXC19vXzX++2T8FR-V1SAjGuO0ejYhQ@mail.gmail.com>
References: <CAD8of+q29DrQa4Ay6karXC19vXzX++2T8FR-V1SAjGuO0ejYhQ@mail.gmail.com>
Message-ID: <20181101101048.GJ12057@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 05:17:57PM +0800, Li Zhang wrote:
> Hi,
> 
> I run kvm-units-test on ARM server(QDF2400), but gicv2-ipi,
> gicv2-active cases fail.

I didn't think QDF2400 has GICv2 on GICv3 support?

Do the test cases fail or are they reported as skipped?

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
> 

I don't think you need to care.  I believe Marc has run the
GICv2-on-GICv3 tests on his supported platforms with recent
kvm-unit-tests and other have reported succes as well.


Thanks,

    Christoffer
