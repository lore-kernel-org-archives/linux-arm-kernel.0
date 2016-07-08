From: andi@etezian.org (Andi Shyti)
Date: Sat, 9 Jul 2016 01:31:58 +0900
Subject: [PATCH v2 5/7] spi: s3c64xx: add exynos5433 compatible for ioclk
 handling
In-Reply-To: <146799441227.73491.13833003558807352160@resonance>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
 <146799441227.73491.13833003558807352160@resonance>
Message-ID: <20160708163158.GD1256@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

> >         pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
> >         pm_runtime_use_autosuspend(&pdev->dev);
> >         pm_runtime_set_active(&pdev->dev);
> > @@ -1193,6 +1211,8 @@ err_pm_put:
> >         pm_runtime_disable(&pdev->dev);
> >         pm_runtime_set_suspended(&pdev->dev);
> >  
> > +       clk_disable_unprepare(sdd->ioclk);
> > +err_disable_src_clk:
> >         clk_disable_unprepare(sdd->src_clk);
> >  err_disable_clk:
> >         clk_disable_unprepare(sdd->clk);
> 
> Why aren't these clocks enabled/disabled by calls to pm_runtime_get/put?

yes, they are, but this should be fixed in a different patch.

I will send a follow-up, thanks for pointing this out.

Andi
