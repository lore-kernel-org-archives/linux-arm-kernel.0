From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Sep 2012 23:31:06 +0800
Subject: [PATCH RFC] clk: use spinlock for clk_get_rate
In-Reply-To: <CAPDyKFo38_zJBZ2K1gNSre0+C4hF8A2bkg2eyZum=5izkEEELw@mail.gmail.com>
References: <1346919146-25972-1-git-send-email-shawn.guo@linaro.org>
 <CAPDyKFo38_zJBZ2K1gNSre0+C4hF8A2bkg2eyZum=5izkEEELw@mail.gmail.com>
Message-ID: <20120906153102.GA26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 11:28:10AM +0200, Ulf Hansson wrote:
> Hi Shawn,
> 
> Interesting problem you found. :-)
> 
> Just a note, that in my suggested patch: "[PATCH 1/4] clk: Provide
> option for clk_get_rate to issue hw for new rate",
> the prepare mutex will be required to keep.
> 
Right.  Just realized that the prepare mutex is also being used to
protect clock tree topology in clk_get_rate, so it's required anyway.
We may need to look for a fixing in smp_twd driver.

> Not sure if that should be considered as a part of the solution to the
> cpufreq problem, but anyway, thought you should know.
> 

-- 
Regards,
Shawn
