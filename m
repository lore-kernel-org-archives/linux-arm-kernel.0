From: martin@sperl.org (Martin Sperl)
Date: Wed, 7 Sep 2016 11:08:47 +0200
Subject: [PATCH v3 0/4] clk: bcm2835: critical clocks and parent selection
In-Reply-To: <1464807936-532-1-git-send-email-eric@anholt.net>
References: <1464807936-532-1-git-send-email-eric@anholt.net>
Message-ID: <69F741EC-D4BB-461E-B3BA-FEF73DA70F2E@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 01.06.2016, at 21:05, Eric Anholt <eric@anholt.net> wrote:
> 
> I figured out another critical clock (patch 3), but didn't use the
> CLK_IS_CRITICAL flag since I want to just protect whatever clock
> happens to be the parent (there are #ifdefs in the firmware indicating
> that they've experimented with using different clocks as the parent).
> 
> I think these fixes are all suitable for 4.7.
> 
> Eric Anholt (4):
>  clk: bcm2835: Mark the VPU clock as critical
>  clk: bcm2835: Mark GPIO clocks enabled at boot as critical
>  clk: bcm2835: Mark the CM SDRAM clock's parent as critical
>  clk: bcm2835: Skip PLLC clocks when deciding on a new clock parent
> 
> drivers/clk/bcm/clk-bcm2835.c | 63 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 61 insertions(+), 2 deletions(-)

Whole series:
Acked-by: Martin Sperl <kernel@martin.sperl.org>

Note that these patches are also seeing more testing downstream in 4.7
and there have been no hiccups seen either. Clock selection is working
as expected for I2S as well.
