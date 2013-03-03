From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun, 03 Mar 2013 12:17:29 +0100
Subject: [PATCH v6 01/16] clk: samsung: add common clock framework helper
 functions for Samsung platforms
In-Reply-To: <201303030208.49722.heiko@sntech.de>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <1361175686-19400-2-git-send-email-thomas.abraham@linaro.org>
 <201303030208.49722.heiko@sntech.de>
Message-ID: <51333149.1060105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/03/2013 02:08 AM, Heiko St?bner wrote:
> But is there an easy way to define more than one alias? On the s3c2416 for
> example the hsmmc hclk is the "hsmmc" io-clock, as well as the source for the
> "mmc_busclk.0". Same for the "uart" pclk, that is also a baud clock source.

This driver currently provides for only one additional clkdev lookup entry
per a platform clock. I pointed out this desing issue in the early version
of the patch set. It's because a machine clock definition is coupled with
a clock consumer definition. And IMO various samsung_clock_register_*
functions should not have clk_register_clkdev() inside them. I.e. first
step could be registering all machine clocks and in the second one clkdev
lookup entries could be created. This is how most (all?) existing SoC
clock drivers are working.

But those multiple aliases are important only for machines with device
tree support, aren't they ?

I hope this patch series gets merged early to linux-next in the 3.10
cycle so the multiple accumulated fixup patches for this clock driver
can be merged as well and issues like that you pointed out can be
resolved with incremental patches.

Regards,
Sylwester
