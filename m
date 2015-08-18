From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Aug 2015 13:18:00 -0700
Subject: [PATCH 1/2] ARM: dts: vexpress: Use assigned-clock-parents for
 sp810
In-Reply-To: <1439343411-29168-1-git-send-email-sboyd@codeaurora.org>
References: <1439343411-29168-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150818201800.GD4732@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 06:36:50PM -0700, Stephen Boyd wrote:
> The sp810 clk driver is calling the clk consumer APIs from
> clk_prepare ops to change the parent to a 1 MHz fixed rate clock
> for each of the clocks that the driver provides. Use
> assigned-clock-parents for this instead of doing it in the driver
> to avoid using the consumer API in provider code. This also
> allows us to remove the usage of clk provider APIs that take a
> struct clk as an argument from the sp810 driver.
> 
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> This came out of a larger series to change this binding[1]. This
> patch can go through arm-soc independently though, so please apply.

Applied, thanks.


-Olof
