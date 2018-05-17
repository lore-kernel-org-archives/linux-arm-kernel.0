From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2018 14:45:07 -0700
Subject: [PATCH 4/4] omap2: powerdomain: Inroduce cpu_pm notifiers for
 context save/restore
In-Reply-To: <1526483821-25585-5-git-send-email-j-keerthy@ti.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
 <1526483821-25585-5-git-send-email-j-keerthy@ti.com>
Message-ID: <20180517214507.GS98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180516 15:21]:
> +	/* Only AM43XX can lose pwrdm context during rtc-ddr suspend */
> +	if (soc_is_am43xx()) {
> +		nb.notifier_call = cpu_notifier;
> +		cpu_pm_register_notifier(&nb);
> +	}
> +

Hmm in patch 3/4 you add omap4_pwrdm_save_context(), I think
that we'd want to run with the notifier for cpuidle on omap4?

Regards,

Tony
