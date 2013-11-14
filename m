From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Nov 2013 10:35:36 -0800
Subject: [PATCH v2] ARM: OMAP4460: cpuidle: Extend
 PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD on cpuidle
In-Reply-To: <5266CCE3.1090801@ti.com>
References: <1382467484-16957-1-git-send-email-grygorii.strashko@ti.com>
 <5266CCE3.1090801@ti.com>
Message-ID: <20131114183535.GL10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [131022 12:09]:
> The same workaround as ff999b8a0983ee15668394ed49e38d3568fc6859
> "ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC ..."
> need to be applied not only when system is booting, but when MPUSS hits
> OSWR state through CPUIdle too. Without this WA the same issue is
> reproduced now on boards PandaES and Tablet/Blaze with SOM OMAP4460
> when CONFIG_CPU_IDLE is enabled.
> After MPUSS has enterred OSWR and waken up:
> - GIC distributor became disabled forever
> - scheduling is not performed any more
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reported-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applying into omap-for-v3.13/fixes thanks.

Tony
