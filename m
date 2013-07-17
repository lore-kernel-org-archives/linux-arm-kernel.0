From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Jul 2013 08:40:39 -0700
Subject: [PATCH 1/3] pinctrl: rollback check for !dev->pins in
 pinctrl_pm_select*() APIs
In-Reply-To: <1374061312-25469-2-git-send-email-grygorii.strashko@ti.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
 <1374061312-25469-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20130717154038.GK7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [130717 04:49]:
> The pinctrl support in Device core assumed to be optional - so, It's
> valid case, when there are no definition for default device's pinctrl
> states in DT at all ("default", "active", "idle", "sleep").
> And in this case dev->pins == NULL and pinctrl_pm_select*() API
> should return 0 always.
> 
> Now the checks for !dev->pins have been removed from
> pinctrl_pm_select*() API mistakenly by the patch
> pinctrl: Remove duplicate code in pinctrl_pm_select_state functions
> http://www.spinics.net/lists/arm-kernel/msg258829.html
> 
> Hence, rollback these checks in in pinctrl_pm_select*() APIs.

Thanks, it's best that I fold this fix into my patch as it has not
been committed yet.

Regards,

Tony
