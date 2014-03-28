From: mporter@linaro.org (Matt Porter)
Date: Fri, 28 Mar 2014 15:35:53 -0400
Subject: [PATCH 00/75] l2c series - Olof's boot failures
In-Reply-To: <20140328183958.GP7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <20140328183958.GP7528@n2100.arm.linux.org.uk>
Message-ID: <20140328193553.GN24294@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 06:39:58PM +0000, Russell King wrote:
> On Fri, Mar 28, 2014 at 03:12:49PM +0000, Russell King - ARM Linux wrote:
> > This is another posting of the L2 cache controller series.  I'm not
> > planning for this for the upcoming merge window, but the one after,
> > as people need to test it and still need to feed back to me on
> > various issues.  Hence, this is not a finalised series.
> > 
> > There are still various issues which I've raised, and have had no
> > feedback on.
> 
> Olof's builder shows failures with this for:
> 
>     capri        multi_v7_defconfig            :        FAILED  1:03.10
>     seaboard     tegra_defconfig               :        FAILED  1:29.70
>     seaboard     multi_v7_defconfig            :        FAILED  1:26.35
> 
> I have no way to debug these failures.
> 
> However, strangely:
> 
>     capri        bcm_defconfig                 :        passed  0:42.83

This is fixed by the check cpu id for pj4 patch:
http://www.spinics.net/lists/arm-kernel/msg316431.html

updated version:
http://www.spinics.net/lists/arm-kernel/msg317283.html
http://www.spinics.net/lists/arm-kernel/msg317284.html

bcm_defconfig is fine because ARCH_DOVE isn't enabled

-Matt
