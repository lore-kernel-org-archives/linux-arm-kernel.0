From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Jul 2018 02:38:23 -0700
Subject: [PATCH] ARM: hwmod: RTC: Don't assume lock/unlock will be called
 with irq enabled
In-Reply-To: <1529572388-21890-1-git-send-email-j-keerthy@ti.com>
References: <1529572388-21890-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20180703093823.GU112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180621 02:16]:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> When the RTC lock and unlock functions were introduced it was likely
> assumed that they would always be called from irq enabled context, hence
> the use of local_irq_disable/enable. This is no longer true as the
> RTC+DDR path makes a late call during the suspend path after irqs
> have been disabled to enable the RTC hwmod which calls both unlock and
> lock, leading to IRQs being reenabled through the local_irq_enable call
> in omap_hwmod_rtc_lock call.
> 
> To avoid this change the local_irq_disable/enable to
> local_irq_save/restore to ensure that from whatever context this is
> called the proper IRQ configuration is maintained.

Thanks applying into omap-for-v4.19/soc.

Tony
