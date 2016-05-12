From: briannorris@chromium.org (Brian Norris)
Date: Thu, 12 May 2016 15:22:23 -0700
Subject: [PATCH 1/2] ARM64: dts: rockchip: add sdhci/emmc for rk3399
In-Reply-To: <3e257ce2-056a-592a-9481-970da1fe0627@rock-chips.com>
References: <1462924975-69072-1-git-send-email-briannorris@chromium.org>
 <3e257ce2-056a-592a-9481-970da1fe0627@rock-chips.com>
Message-ID: <20160512222223.GA57835@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 09:17:38AM +0800, Shawn Lin wrote:
> How about adding these?
> 
> assigned-clocks = <&cru SCLK_EMMC>;
> assigned-clock-parents = <&cru PLL_CPLL>; //may not need

BTW, even if I assign the parent here, it's not actually taking effect
on my system. Presumably the common clock framework is finding a
"better" way to satisfy 200 MHz through GPLL instead. So I'm dropping
the assigned-clock-parents for v2.

> assigned-clock-rates = <200000000>;

Brian
