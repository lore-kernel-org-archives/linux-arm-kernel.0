From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Tue, 20 Dec 2011 11:45:08 +0530
Subject: [PATCH V2 1/4] i2c: tegra: Add __devinit/exit to probe/remove
In-Reply-To: <20111220015634.GA27789@quad.lixom.net>
References: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
 <20111220015634.GA27789@quad.lixom.net>
Message-ID: <CAM=Q2cs8K4vraWPNqervcmxEqUGiAbng+44+L9OhD3ijPw9tAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 7:26 AM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Dec 17, 2011 at 11:29:29PM -0700, Stephen Warren wrote:
>> This fixes some section mismatch build warnings.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>
> Ben, since the patch is trivial, I've picked it up in tegra
> for-3.3/drivers and will merge that way. Let me know if you disagree.
>
>
Hi Stephen ,
could you check this one also
thanks.

From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Tue, 20 Dec 2011 11:40:51 +0530
Subject: [PATCH] I2C : tegra : devexit in remove

Adding I2C __devexxit in remove

Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Untested

 drivers/i2c/busses/i2c-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 46b6500..b25f78b 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -751,7 +751,7 @@ MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);

 static struct platform_driver tegra_i2c_driver = {
        .probe   = tegra_i2c_probe,
-       .remove  = tegra_i2c_remove,
+       .remove  =__devexit_p(tegra_i2c_remove),
 #ifdef CONFIG_PM
        .suspend = tegra_i2c_suspend,
        .resume  = tegra_i2c_resume,
-- 
1.7.1

> Thanks,
>
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
