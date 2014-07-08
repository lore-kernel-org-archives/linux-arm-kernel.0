From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Jul 2014 09:15:40 +0200
Subject: [PATCHv2 1/8] clk: add an APPLY_RATE_CHANGE notifier event
 during clk_set_rate()
In-Reply-To: <53BB30D2.3010908@codeaurora.org>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404744702-32010-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <53BB30D2.3010908@codeaurora.org>
Message-ID: <20140708091540.0f886cfc@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Boyd,

On Mon, 07 Jul 2014 16:44:18 -0700, Stephen Boyd wrote:

> > In order to solve this problem, we propose to add an APPLY_RATE_CHANGE
> > notifier event, which gets called right after ->set_rate(), but before
> > ->recalc_rate(), and therefore regardless of whether there was an
> > actualy frequency change or not.
> 
> Is there any reason why we can't call the pmsu code (part #3) directly
> from the cpu clock driver? It seems like if we just called the
> .set_rate() op we wouldn't actually have changed the clock's rate. That
> doesn't seem very intuitive and it really makes the code flow hard to
> follow.

Right, but what solution would you propose to achieve that? These days,
a direct call from drivers/ code to arch/arm/mach-<foo>/ code is
frowned upon, no? (The code handling the PMSU is in
arch/arm/mach-mvebu/pmsu.c).

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
