From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 23 Aug 2017 21:33:01 +0200
Subject: [PATCH] rtc: sa1100: fix unbalanced
 clk_prepare_enable/clk_disable_unprepare
References: <20170821160038.22650-1-alexandre.belloni@free-electrons.com>
Message-ID: <87bmn6qdua.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> In the error path of sa1100_rtc_open(), info->clk is disabled which will
> happen again in sa1100_rtc_remove() when the module is removed whereas it
> is only enabled once in sa1100_rtc_init().
>
> Fixes: 0cc0c38e9139 ("drivers/rtc/rtc-sa1100.c: move clock enable/disable to probe/remove")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
