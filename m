From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 May 2010 15:54:35 +0100
Subject: [PATCH] Handle instruction cache maintenance fault properly
In-Reply-To: <7529.1273503128@localhost>
References: <AANLkTikIbI6hKoYSZlo6QDlyi2Qjxg287i-ilHpz1FF9@mail.gmail.com>
	<20100510131519.GB7796@n2100.arm.linux.org.uk>
	<AANLkTint0f2Ow2FM3jVAqGfPjolHvF-oBTGCmY7Jx7_d@mail.gmail.com>
	<7529.1273503128@localhost>
Message-ID: <1273503275.10282.63.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-10 at 15:52 +0100, Valdis.Kletnieks at vt.edu wrote:
> On Mon, 10 May 2010 16:34:57 +0300, "Kirill A. Shutemov" said:
> 
> > It looks like cache maintenance fault was introduced in ARMv6.
> > 
> > So, what is the right way to fix it? Something like:
> > 
> > #if __LINUX_ARM_ARCH__ < 6
> >         { do_bad,               SIGBUS,  0,             "external
> 
> This would need to be a runtime test, no?  Or does LINUX_ARM_ARCH not allow
> it to run on other arch levels? (i.e. can an ARM kernel boot for v5 and v6?)

v6 and v7 probably but I doubt v5 and v6 would work. There are other
#ifdefs in arch/arm/include/asm/system.h like barriers.

-- 
Catalin
