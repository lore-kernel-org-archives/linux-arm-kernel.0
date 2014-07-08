From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 08 Jul 2014 13:18:54 -0700
Subject: [PATCHv2 1/8] clk: add an APPLY_RATE_CHANGE notifier event during
 clk_set_rate()
In-Reply-To: <20140708091540.0f886cfc@free-electrons.com>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404744702-32010-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <53BB30D2.3010908@codeaurora.org>
 <20140708091540.0f886cfc@free-electrons.com>
Message-ID: <53BC522E.8080302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/14 00:15, Thomas Petazzoni wrote:
> Dear Stephen Boyd,
>
> On Mon, 07 Jul 2014 16:44:18 -0700, Stephen Boyd wrote:
>
>>> In order to solve this problem, we propose to add an APPLY_RATE_CHANGE
>>> notifier event, which gets called right after ->set_rate(), but before
>>> ->recalc_rate(), and therefore regardless of whether there was an
>>> actualy frequency change or not.
>> Is there any reason why we can't call the pmsu code (part #3) directly
>> from the cpu clock driver? It seems like if we just called the
>> .set_rate() op we wouldn't actually have changed the clock's rate. That
>> doesn't seem very intuitive and it really makes the code flow hard to
>> follow.
> Right, but what solution would you propose to achieve that? These days,
> a direct call from drivers/ code to arch/arm/mach-<foo>/ code is
> frowned upon, no? (The code handling the PMSU is in
> arch/arm/mach-mvebu/pmsu.c).
>

I don't see a problem with having an include file in include/linux/ for
this, maybe others do though. If it actually is a problem then perhaps
moving the pmsu.c code into drivers/ is the right solution.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
