From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 18:09:22 -0800
Subject: [PATCH v2] ARM: OMAP1: Move dpll1 rates selection from config
 to runtime
In-Reply-To: <1323395476-26548-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <201112090013.37529.jkrzyszt@tis.icnet.pl>
 <1323395476-26548-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111209020922.GN31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111208 17:24]:
> For still better multi-OMAP1 support, expand omap1_rate_table with flags
> for different SoC types and match them while selecting clock rates. The
> idea is stolen from current omap24xx clock rate selection algorithm.
> 
> Since clkdev platform flag definitions are reused here, those had to be
> expanded with one extra entry for OMAP1710 subtype, as this is the only
> SoC for which we allow selection of the highest, 216 MHz rate.
> 
> Once done, remove no longer needed clock rate configure time options.
> 
> Created against linux-omap/master tip as of Thu Dec 1,
> commit f83c2a8cbb59981722d1ab610c79adfd034a2667.
> Tested on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> v2: limit OMAP1510 rate to 150 MHz, or some boards may not work.

Thanks pushing them all into omap1 branch, can you please check
that I got all the patches? I've boot tested it here on h2/osk/770.

Tony
