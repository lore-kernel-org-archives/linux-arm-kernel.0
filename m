From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Sep 2012 09:17:45 +0800
Subject: [PATCH v3 1/3] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
In-Reply-To: <504A26E4.4070600@wwwdotorg.org>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-2-git-send-email-shawn.guo@linaro.org>
 <5049252D.9000802@wwwdotorg.org>
 <20120907025847.GI26709@S2101-09.ap.freescale.net>
 <504A26E4.4070600@wwwdotorg.org>
Message-ID: <20120910011741.GP26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 10:55:00AM -0600, Stephen Warren wrote:
> Yes, that does solve the problem (well, with s/late_init/late_initcall/).
> 
> As you imply, that change wouldn't help if cpu-tegra.c was built as a
> module.

I doubt that.  Have you confirmed it with testing?  When you install
module cpu-tegra, the pcie initialization has been done, right?

> So, is this something you can work around in your patch?
> 
Before we head to a solution, we need to identify the cause.

One thing I note is there is no loops_per_jiffy updating in cpu-tegra
driver.  But if I understand correctly, the driver is running on
MP system.  It should update loops_per_jiffy when cpu frequency
changes, right?  I'm worrying about that the timeout in tegra pcie
driver just happens to work with a wrong loops_per_jiffy, but becomes
broken when loops_per_jiffy gets correct.

-- 
Regards,
Shawn
