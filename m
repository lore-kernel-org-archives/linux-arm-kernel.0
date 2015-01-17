From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 17 Jan 2015 10:34:14 +0100
Subject: sun9i pll4 upstream kernel code seems wrong
Message-ID: <54BA2C96.7050102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ChenYu,

Looking at drivers/clk/sunxi/clk-sun9i-core.c:

sun9i_a80_get_pll4_factors(), and comparing it with
the A80 user manual, things seem way off, this seems
more accurate (although also possibly not quite)
for pll1 / pll2 then for pll4, and the comment at
the top does mention PLL1 once.

Note according to the datasheet pll4 should be treated
as an inmutable pll fixed at 960 MHz, so maybe we should
just drop the get_factors function for it ?

Luckily the struct clk_factors_config sun9i_a80_pll4_config
is correct, so as long as we do not try to change the
rate the current upstream code for pll4 does work.

Regards,

Hans
