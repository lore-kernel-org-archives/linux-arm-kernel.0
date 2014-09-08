From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 08 Sep 2014 13:47:59 -0700
Subject: [RFC PATCH 3/3] ARM: keystone: pm_domain: setup clk pm domain
 clocks from DT
In-Reply-To: <1406313096-29761-4-git-send-email-grygorii.strashko@ti.com>
 (Grygorii Strashko's message of "Fri, 25 Jul 2014 21:31:36 +0300")
References: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>
 <1406313096-29761-4-git-send-email-grygorii.strashko@ti.com>
Message-ID: <7hmwa9on40.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> This patch implements custom pm_clk_notifier callback for Keystone 2
> CLK PM domain which fills list of clocks for Device with all
> clocks assigned to this Device in DT.
>
> After this patch .con_ids field in pm_clk_notifier_block is not
> used and there are no limitation for clocks names in DT any more.

OK, but this also assumes you want *every* clock associated with a
device node managed by runtime PM.  Is that really what you want?  

I may have misunderstood, but your previous attempts at solving this
problem suggest you wanted finer grained control over which device
clocks are runtime PM managed and which ones arent.

Kevin
