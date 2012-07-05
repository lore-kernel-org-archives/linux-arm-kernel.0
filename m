From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 5 Jul 2012 16:28:46 +0800
Subject: [PATCH] regulator: core: remove sysfs entry properly in
 regulator_put
In-Reply-To: <1341469182-5079-1-git-send-email-shawn.guo@linaro.org>
References: <CAOMZO5BD_FcXVU18PauOFudod5FKd9MP-ZNUDJ4F9iQ6+EAjiA@mail.gmail.com>
 <1341469182-5079-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120705082845.GF14589@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 02:19:42PM +0800, Shawn Guo wrote:
> With changes introduced by commit 222cc7b (regulator: core: Allow
> multiple requests of a single supply mapping) on create_regulator,
> regulator_put needs a corresponding update on sysfs entry removing.
> 
> Also regulator->dev still needs to get assigned in create_regulator,
> otherwise, sysfs_remove_link call in regulator_put will get bypassed.
> 
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/regulator/core.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
Good catch.

Tested-by: Dong Aisheng <dong.aisheng@linaro.org>
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
