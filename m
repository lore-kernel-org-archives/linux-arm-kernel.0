From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 15:38:15 +0200
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency
 in non-SMP platforms
In-Reply-To: <20140514170456.GC15946@arm.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
Message-ID: <20140519153815.0c147a6e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Wed, 14 May 2014 18:04:56 +0100, Catalin Marinas wrote:

> >    - The pages must be set as shareable.
> 
> Here you may have some conflict between the initial page tables set in
> __create_page_tables as non-shareable (that's unless MPIDR shows it as
> SMP but I guess not since smp-on-up kicks in). I have to think a bit
> more about the implications (the ARM ARM has a chapter on mismatched
> memory attributes and I think it talks about shareable vs
> non-shareable).

Do you have more insights about this potential conflict?

The problem is that at the arch/arm/kernel/head.S stage, it's currently
not possible to do platform-specific code while keeping multiplatform
characteristics, because I don't see how we could get a machine_desc
pointer or any other platform-specific indicator so early in the boot.
Do you have suggestions?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
