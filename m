From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Apr 2013 13:24:06 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAFEAcA8oE+2BRRgoeA4-0PzOQkxzGwDT5qunudzg7RBA9aWCgQ@mail.gmail.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAFEAcA-1HAG0pY-j-rqU=QmSoep3Di-KNPATvuou8ghRn3SaqA@mail.gmail.com>
 <516810F7.7040601@arm.com> <20130417101906.GX14496@n2100.arm.linux.org.uk>
 <516E7ADE.5090601@arm.com>
 <CAEDV+gK3nitpN+8ZePRY7n+bsc2t4XbWrz6fbdz0Wjq_kTgM4g@mail.gmail.com>
 <516E87D1.5000109@arm.com>
 <CAFEAcA8oE+2BRRgoeA4-0PzOQkxzGwDT5qunudzg7RBA9aWCgQ@mail.gmail.com>
Message-ID: <516E9466.2070805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/13 12:38, Peter Maydell wrote:
> On 17 April 2013 12:30, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> By disabling the problematic configuration, we just bury our head in the
>> sand and pretend everything is fine. Yes, this is a new feature. But by
>> saying "not a supported configuration", while the code *should* support
>> it, we're only fooling ourselves.
> 
> Who says the code should support running on big.LITTLE?

I do. The host code definitely should. If it doesn't, then lets fix that
bug, as it probably means the support is also broken on A15.

As I said in another email, guest support is a separate issue.

	M.
-- 
Jazz is not dead. It just smells funny...
