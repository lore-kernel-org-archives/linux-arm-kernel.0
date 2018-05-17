From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2018 11:46:12 -0700
Subject: [PATCH v2] pinctrl: pinctrl-single: Add functions to save and
 restore pinctrl context
In-Reply-To: <1526532021-16387-1-git-send-email-j-keerthy@ti.com>
References: <1526532021-16387-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20180517184612.GM98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180517 04:42]:
> This adds a pair of context save/restore functions to save/restore the
> state of a set of pinctrl registers. The context is lost during rtc only
> suspend with ddr in self-refresh on am43xx. Currently the save/restore
> is being done unconditionally. This will be optimized later with a
> pdata-quirk function which will allow is to save/restore only when doing
> the rtc only mode with ddr in self refresh.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * As this is needed only the in the suspend/resume path
>     removed the cpu_pm notifier and added the save/restore in
>     the suspend/resume calls.
>   * Saving/Restoring unconditionally at the moment. This will
>     be optimized later with the help of a pdata-quirk function.

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
