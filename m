From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Mar 2013 10:27:56 -0800
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <20130305182756.GD11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130305 09:51]:
> Hi everyone,
> 
> Although I'm not present at the Linaro Connect hacking
> sessions, I am participating remotely and have tried
> hacking on multiplatform support for Exynos. This patch
> set is far from complete, but I think the patches
> can be useful anyway.
> 
> The series gets increasingly fishy towards the end,
> and we should probably not apply any of the last nine
> patches as-is, nor do I expect everything to work, since
> I have not tested them at all.
> 
> With this patch set, we can build mach-exynos as part
> of a multiplatform kernel, with the following caveats:
> 
> * Only DT based boards are supported
> * Moving to common-clk breaks things including cpufreq
>   and others. Thomas is working on a patch for this
> * We disable the gpio implementation, which also breaks
>   stuff, but Thomas has a patch already
> * Using the generic DMA engine API in SPI and ASoC
>   means they no longer work on S3C
> * I did not like the solution for the UART driver, but
>   could also not think of a better one.
> * The FB_S3C, S3C2410_WATCHDOG and S3C_ADC drivers
>   are left as an exercise to the reader, they are
>   currently disabled with multiplatform
> * sparsemem support is not available on multiplatform

For booting, you might want to add fixing up of the initcalls
to your checklist too as that can easily cause surprises to
other SoCs.

Regards,

Tony
