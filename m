From: davem@davemloft.net (David Miller)
Date: Wed, 29 Mar 2017 09:39:14 -0700 (PDT)
Subject: [PATCH] Add hardware PTP support.
In-Reply-To: <1490796051-28527-1-git-send-email-rafalo@cadence.com>
References: <1490796051-28527-1-git-send-email-rafalo@cadence.com>
Message-ID: <20170329.093914.152103359543418375.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafal Ozieblo <rafalo@cadence.com>
Date: Wed, 29 Mar 2017 15:00:51 +0100

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
> Note: Patch on net-next, on March 15th.
> 
> Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>

Your subject should provide a proper subsystem prefix such as
"cadence: " after "[PATCH] ".

Also, March 15th is nearly half a month ago, you should generate
patches against the current tree.
