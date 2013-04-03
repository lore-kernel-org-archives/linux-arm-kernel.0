From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 13:54:41 -0700
Subject: [PATCH v2 09/18] ARM: OMAP4+: PM: Restore CPU power state to ON
 with clockdomain force wakeup method
In-Reply-To: <1364205910-32392-10-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:01 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-10-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87mwtftjvy.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> While waking up CPU from off state using clock domain force wakeup, restore
> the CPU power state to ON state before putting CPU clock domain under
> hardware control. Otherwise CPU wakeup might fail. The change is recommended
> for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
> devices first.

Sounds reasonable, but can you describe the "weakness" a little more?

IOW, what exactly happens if this is not done?  It sounds like the CPU
might immediately go back to retention, but how does that happen unless
it does a WFI?

Also, this sounds like a fix to me, and should probably be broken out
accordingly.

Kevin
