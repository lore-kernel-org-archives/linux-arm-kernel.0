From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 04 Nov 2014 22:58:45 +0100
Subject: [PATCH v5] clk: rockchip: disable unused clocks
In-Reply-To: <1415092270-24932-1-git-send-email-kever.yang@rock-chips.com>
References: <1415092270-24932-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <14899684.S24jkIkXzQ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

Am Dienstag, 4. November 2014, 17:11:10 schrieb Kever Yang:
> The rockchip clock driver use CLK_IGNORE_UNUSED flag to make sure
> all the clocks are available like default power on state.
> We have implement the clock manage in most of rockchip drivers,
> it is time to remove it for power save.
> Instead we add CLK_IGNORE_UNUSED for some clock nodes which should
> be on during boot or no module driver in kernel will initialize it.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>

I applied this with some slight modifications.
- it seemed to be based on your dclk_ops series - fixed that
- remove the flag from the uart2 on the cortex-a9 too
- let DCLK_VOPx and HCLK_VOPx be autodisabled on rk3288
  [tested by Doug]


Heiko
