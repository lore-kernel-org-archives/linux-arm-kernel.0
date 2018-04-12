From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Apr 2018 07:16:39 -0700
Subject: [PATCH 08/14] ARM: OMAP2: Add functions to save and restore
 pinctrl context.
In-Reply-To: <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
Message-ID: <20180412141639.GV5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> From: Russ Dill <Russ.Dill@gmail.com>
> 
> This adds a pair of context save/restore functions to save/restore the
> state of a set of pinctrl registers. This simplifies some of the AM33XX
> PM code as some of the pinctrl registers are lost when the per power
> domain loses power. The pincrtl code can perform the necessary
> save/restore.

So where's the patch adding callers to this code?

If this cannot be done from regular driver suspend/resume calls,
this probably should be done from cpu_pm notifiers CPU_PM_ENTER and
CPU_PM_EXIT. We should also do the same for GPIO BTW.

BTW, the subject line is wrong here, it should be "pinctrl" :)

Regards,

Tony
