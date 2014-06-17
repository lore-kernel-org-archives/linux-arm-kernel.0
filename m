From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jun 2014 17:17:00 +0200
Subject: [PATCH 01/14] ARM: mvebu: fix randconfig builds for pmsu driver
In-Reply-To: <4575903.g78pJlsGh9@wuerfel>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
 <1402675276-538682-2-git-send-email-arnd@arndb.de>
 <20140617160011.03b1ea15@free-electrons.com>
 <4575903.g78pJlsGh9@wuerfel>
Message-ID: <20140617171700.27908c03@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 17 Jun 2014 17:03:28 +0200, Arnd Bergmann wrote:

> > So noMMU builds are supported in a single image with MMU builds?
> 
> It's not supported yet, but I have a patch to do that, which I used for
> testing this code. I try to have the platform code ready before submitting
> the main patch.

Ok.

> > This unfortunately isn't really correct, and the patch I sent in
> > "[PATCH] ARM: mvebu: select ARM_CPU_SUSPEND for Marvell EBU v7
> > platforms" on June, 11th already fixes the cpu_suspend()/cpu_resume()
> > problem.
> 
> ok.
> 
> > The issue with your solution is that it assumes this function is only
> > used for cpuidle. That is indeed the case in v3.16, but will be wrong
> > as soon as we add CPU hotplug support, which I have posted on May, 30th
> > in "[PATCH 0/5] CPU hotplug for Marvell Armada XP", and which I hope to
> > see included in v3.17.
> 
> Right. I'll drop this patch from the submission then. You came just in
> time, as I had originally planned to send it out this morning.
> 
> I'll also follow up with a separate patch to address the isb() issue.

Ok, thanks a lot!

So, should my patch adding the "select ARM_CPU_SUSPEND" be taken by
Jason and then pushed to you, or will you apply it directly?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
