From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 3 Oct 2013 08:23:07 -0400
Subject: [PATCH v2] clk: armada-370: fix tclk frequencies
In-Reply-To: <1380794702-6191-1-git-send-email-simon.guinot@sequanux.org>
References: <1380794702-6191-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20131003122307.GV31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

On Thu, Oct 03, 2013 at 12:05:02PM +0200, Simon Guinot wrote:
> This patch fixes the tclk frequency array for the Armada-370 SoC.
> This bug has been introduced by commit 6b72333d
> ("clk: mvebu: add Armada 370 SoC-centric clock init").
> 
> A wrong tclk frequency affects the following drivers: mvsdio, mvneta,
> i2c-mv64xxx and mvebu-devbus. This list may be incomplete.
> 
> About the mvneta Ethernet driver, note that the tclk frequency is used
> to compute the Rx time coalescence. Then, this bug harms the coalescence
> configuration and also degrades the networking performances with the
> default values.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: stable at vger.kernel.org
> ---
>  drivers/clk/mvebu/armada-370.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Much better, thanks!

Acked-by: Jason Cooper <jason@lakedaemon.net>

This can be applied to v3.11 onwards.

thx,

Jason.
