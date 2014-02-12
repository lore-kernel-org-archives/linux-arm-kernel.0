From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 17:16:21 +0000
Subject: [PATCH v2 0/9] ARM: multi-platform kconfig cleanup and mach-virt
 removal
In-Reply-To: <52FBAB51.4050401@arm.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <20140212134655.GC29132@mudshark.cambridge.arm.com>
 <CAL_JsqJkCXSFJZzRBRTrKh16PoBjvF95uKJbZAic-pk3htf_jg@mail.gmail.com>
 <1726732.KPDAFqxz2K@wuerfel> <52FBAB51.4050401@arm.com>
Message-ID: <20140212171621.GI29132@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 05:11:45PM +0000, Marc Zyngier wrote:
> On 12/02/14 16:53, Arnd Bergmann wrote:
> > 
> > On the topic of V6, we don't support CPU_V6T2 at all, though I assume that
> > there is an ARM1156 core tile for integrator and realview, and we support
> > running the V6/V6K parts with MMU turned off. Would all revisions of ARM1156
> > work with CPU_V6K and !MMU?
> 
> CPU_V6 and !MMU should work. V6K might, but that requires close
> inspection (WFE, SEV shouldn't be used in UP context)...

Well I can boot Debian on my 1136 r0p1 (no v6k) using a v6/v7 kernel, so the
lack of MMU shouldn't change that. The main issue was booting the same
kernel on an A15, which resulted in speculative interrupt acks on the GIC
(fix sitting in rmk's tree [ARM: 7954/1: mm: remove remaining domain support
from ARMv6]).

Will
