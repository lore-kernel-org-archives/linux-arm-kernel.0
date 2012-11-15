From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Nov 2012 16:06:38 +0000
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
In-Reply-To: <50A50C24.9010702@gmail.com>
References: <50A3EBCD.3040801@ti.com>
 <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com>
 <20121115110137.GA25985@arm.com> <50A4FCC5.2080604@gmail.com>
 <20121115143714.GF25985@arm.com> <50A50C24.9010702@gmail.com>
Message-ID: <20121115160638.GA30579@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 03:37:08PM +0000, Rob Herring wrote:
> On 11/15/2012 08:37 AM, Catalin Marinas wrote:
> > On Thu, Nov 15, 2012 at 02:31:33PM +0000, Rob Herring wrote:
> >> Does that work for Versatile Express CA9? It needs ARM_ERRATA_751472.
> > 
> > On VE Linux runs in secure mode, so it's fine.
> 
> WTF? You are contradicting yourself.

No, it was just a statement that you can enable this workaround on VE
CA9. Didn't realise you were referring to the MULTI_PLATFORM case (it's
afternoon and coffee here not that great).

> Don't determine secure mode or not,
> but apply work-arounds only in secure mode? How does a kernel built to
> boot on secure and non-secure chips know that? The requirement would be
> that every platform have proper work-arounds setup by the bootloader
> regardless of running in secure or non-secure mode.

Yes, so for such workarounds that require secure register access just
make them depend on !MULTI_PLATFORM. Of course, VE CA9 would be affected
since neither the boot loader nor boot monitor touch those bits (yet).
But they definitely should as I don't see any other way to support
multi-platform, especially when such bits need to be set long before the
DT is parsed.

-- 
Catalin
