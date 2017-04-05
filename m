From: davem@davemloft.net (David Miller)
Date: Wed, 05 Apr 2017 06:43:03 -0700 (PDT)
Subject: [PATCH net-next] macb: Add hardware PTP support.
In-Reply-To: <1491225015-25553-1-git-send-email-rafalo@cadence.com>
References: <20170329.093914.152103359543418375.davem@davemloft.net>
 <1491225015-25553-1-git-send-email-rafalo@cadence.com>
Message-ID: <20170405.064303.211440601700403108.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafal Ozieblo <rafalo@cadence.com>
Date: Mon, 3 Apr 2017 14:10:15 +0100

> This patch is based on original Harini's patch and Andrei's patch,
> implemented in aseparate file to ease the review/maintanance
> and integration with other platforms.
> 
> In case that macb is compiled as a module, it has been renamed to
> cadence-macb.ko to avoid naming confusion in Makefile.
> 
> This driver does support GEM-GXL:
> - Enable HW time stamp
> - Register ptp clock framework
> - Initialize PTP related registers
> - Updated dma buffer descriptor read/write mechanism
> - HW time stamp on the PTP Ethernet packets are received using the
>   SO_TIMESTAMPING API. Where timers are obtained from the dma buffer
>   descriptors
> - Added tsu_clk to device tree
> 
> Note: Patch on net-next, on April 3rd.
> Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>

This patch does too many things at one time.  Each entry in that list
of changes above should be a separate change, all posted together as
a group as a proper patch series.

Thank you.
