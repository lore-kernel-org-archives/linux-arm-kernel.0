From: tony@atomide.com (Tony Lindgren)
Date: Sun, 19 Jul 2015 23:16:00 -0700
Subject: [PATCH v2 3/3] soc: ti: Add wkup_m3_ipc driver
In-Reply-To: <1437166592-25378-4-git-send-email-d-gerlach@ti.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-4-git-send-email-d-gerlach@ti.com>
Message-ID: <20150720061559.GX17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [150717 13:59]:
> +
> +/* Public functions */
...
> +EXPORT_SYMBOL_GPL(wkup_m3_set_mem_type);
> +EXPORT_SYMBOL_GPL(wkup_m3_set_resume_address);
> +EXPORT_SYMBOL_GPL(wkup_m3_request_pm_status);
> +EXPORT_SYMBOL_GPL(wkup_m3_prepare_low_power);
> +EXPORT_SYMBOL_GPL(wkup_m3_finish_low_power);

I think you can avoid exporting these SoC specific functions
by just exporting wkup_m3_request() and wkup_m3_free() type
functions with a data structure containing the necessary
function pointers.

Regards,

Tony
