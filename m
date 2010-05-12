From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 May 2010 12:01:27 +0100
Subject: [PATCH v2] [RESEND] Handle instruction cache maintenance fault
	properly
In-Reply-To: <AANLkTilVp0xvAJNns3TEe4SzEUpN8hMC9DdwmwW7i9yX@mail.gmail.com>
References: <AANLkTilVp0xvAJNns3TEe4SzEUpN8hMC9DdwmwW7i9yX@mail.gmail.com>
Message-ID: <1273662087.23818.63.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-11 at 11:33 +0100, Kirill A. Shutemov wrote:
> Between "clean D line..." and "invalidate I line" operations in
> v7_coherent_user_range(), the memory page may get swapped out.
> And the fault on "invalidate I line" could not be properly handled
> causing the oops.
> 
> In ARMv6 "external abort on linefetch" replaced by "instruction cache
> maintenance fault". Let's handle it as translation fault. It fixes the
> issue.
> 
> I'm not sure if it's reasonable to check arch version in run-time.
> Let's do it in compile time for now.
> 
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>

FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
