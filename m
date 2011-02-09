From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Feb 2011 10:01:33 +0000
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <20110208164747.GD6188@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
	<20110208164747.GD6188@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimGa-Y6ddHknGe9Gar7+mWPuA_T2+6VL6ecfgxD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2011 16:47, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 10:06:20PM +0530, Santosh Shilimkar wrote:
>> Have tested this series on OMAP4430 and OMAP3430.
>> Don't know if it helps to push some of these patches to be part
>> of rc cycles. At least the SMP specific fixes should get merged
>> otherwise, builds like omap2plus_defconfig won't be running
>> right configuration on SMP machine.
>
> It's _too_ _late_ in the rc cycle for a fix of this size. ?As I've said
> (several times) it was only possible for rc1. ?That boat has been missed
> as we're now on rc4. ?We could see 2.6.38 in as little as two weeks time.
>
> ?27 files changed, 183 insertions(+), 197 deletions(-)
>
> is too big.
>
> There's still the outstanding question over:
>
> ?ARM: v6k: use CPU domain feature if we include support for arch < ARMv6K

Could we make the domains usage a run-time feature based on the
architecture version? For ARMv7, we need to have the vectors page
read-only anyway if the SWP emulation is enabled (and I posted a
simple patch in a reply to your email).

The issue I see is that ARM11MPCore is reported as v7 though we still
use domains on this processor (we could always remove the domains if
TLS register is available or use some more precise architecture
version identification).

-- 
Catalin
