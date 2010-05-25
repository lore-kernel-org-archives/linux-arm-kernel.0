From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 25 May 2010 22:47:57 +0200
Subject: vpack270 and sleep mode
In-Reply-To: <20100525202447.GD16204@n2100.arm.linux.org.uk>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<4BFBD01E.8010101@papillon.ru>
	<20100525202447.GD16204@n2100.arm.linux.org.uk>
Message-ID: <201005252247.57688.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 25. kv?tna 2010 22:24:47 Russell King - ARM Linux napsal(a):
> On Tue, May 25, 2010 at 07:26:54PM +0600, 237 Rumjantsev Egor (PROG) wrote:
> > Unable to handle kernel paging request at virtual address a03ab26f
> > pgd = c7b10000
> > [a03ab26f] *pgd=8020040e(bad)
> > Internal error: Oops: 803 [#1] PREEMPT
> > Modules linked in: ipv6 pxa_reg
> > CPU: 0    Not tainted  (2.6.28.10-vpac3-splash #90)
> > PC is at bad_channel+0x80166/0x91f28
> > LR is at platform_pm_resume_noirq+0x48/0x54
> 
> My guess is that some platform driver hasn't been properly updated,
> and was registered using driver_register() rather than
> platform_driver_register().
> 
> Check your platform drivers to make sure that they're properly up to
> date.

I suspect that pxa_reg module. Like I said earlier.
