From: ljkenny@gmail.com (Lee Jones)
Date: Wed, 19 Sep 2012 21:09:52 +0200
Subject: [rtc-linux] [PATCH 1/1] drivers/rtc/rtc-ab8500.c: Revoke Device
 Tree enablement
In-Reply-To: <20120919160302.GN28670@sortiz-mobl>
References: <1344527828-6283-1-git-send-email-lee.jones@linaro.org>
 <1344527828-6283-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdZa-72QogrZ-P5jbDHTTX64babZo3ydjzfgC-4LWUBfMg@mail.gmail.com>
 <20120831110818.GA5962@gmail.com>
 <CACRpkdat3zj_47r7ENz7Qv3N8cNOSKDV+k5em9DjOhkNycy9gQ@mail.gmail.com>
 <CACRpkdbXwLXoWL+PS-wJ9cbztC-jWhyc=vr+98ffg70f6coaiQ@mail.gmail.com>
 <20120919160302.GN28670@sortiz-mobl>
Message-ID: <20120919190952.GB2753@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Sam: do you agree?
> I'd love to see the patch first :)
> Could you please bounce it to me ?

I'll help. :)

Author: Lee Jones <lee.jones@linaro.org>
Date:   Thu Aug 9 13:28:19 2012 +0100

    drivers/rtc/rtc-ab8500.c: Revoke Device Tree enablement
    
    All AB8500 devices are now registered via MFD core, so Device Tree
    capability is no longer required for probing. Here we pull the DT
    match table to ensure we're no longer probed during Device Tree
    start-up.
    
    CC: Alessandro Zummo <a.zummo@towertech.it>
    CC: rtc-linux at googlegroups.com
    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index bf3c2f6..2e5970f 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -462,16 +462,10 @@ static int __devexit ab8500_rtc_remove(struct platform_device *pdev)
   return 0;
 }
 
-static const struct of_device_id ab8500_rtc_match[] = {
-	{ .compatible = "stericsson,ab8500-rtc", },
-	{}
-};
-
 static struct platform_driver ab8500_rtc_driver = {
 	.driver = {
 		.name = "ab8500-rtc",
 		      .owner = THIS_MODULE,
-		      	     .of_match_table = ab8500_rtc_match,
 			     },
 			     .probe	= ab8500_rtc_probe,
 			     .remove = __devexit_p(ab8500_rtc_remove),

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
