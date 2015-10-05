From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 05 Oct 2015 14:36:32 +0300
Subject: [PATCH v2 0/7] Add support for Exynos SROM Controller driver
In-Reply-To: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
References: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <018501d0ff62$1650b410$42f21c30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> This patch set adds support for Exynos SROM controller DT based driver.
> Currently SROM register sets are used only during S2R, so driver
> basically added for taking care of S2R. It will help us in removing
> static mapping from exynos.c and other extra code handline during S2R.

 Very good news, but, your driver seems not to do anything except suspend/resume. But how do i add
some device plugged into it? In order to be operational, its outputs have to be configured. But how
do i do it with your driver? For example, on SMDK boards SROM controller is used to connect SMSC9111
etherner chip.
 Currently i use hardcoded initialization based on of_machine_is_compatible(), but i believe this
would be considered a hack and such a thing cannot be pushed upstream. I guess i have to put all
needed configuration into device tree somehow. But how? Are there any recommentations?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
