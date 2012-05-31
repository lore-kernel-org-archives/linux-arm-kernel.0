From: khilman@ti.com (Kevin Hilman)
Date: Thu, 31 May 2012 11:58:43 -0700
Subject: [PATCH v2 2/2] arm: omap3: am35x: Disable hlt when using Davinci
 EMAC
In-Reply-To: <1337105642-22711-3-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Tue, 15 May 2012 11:14:02 -0700")
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
 <1337105642-22711-3-git-send-email-mgreer@animalcreek.com>
Message-ID: <871um018kc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> The am35x family of SoCs has a Davinci EMAC ethernet
> controller on-chip.  Unfortunately, the EMAC is unable
> to wake the PRCM when there is network activity which
> leads to a hung or extremely slow system when the MPU
> has executed a 'wfi' instruction (because of pm_idle
> or CPUidle).  To prevent this, add hooks to the EMAC
> pm_runtime suspend/resume calls so that hlt is disabled
> whenever the EMAC is in use.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Looks good,

Acked-by: Kevin Hilman <khilman@ti.com>
