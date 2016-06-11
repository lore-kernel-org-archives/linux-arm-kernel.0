From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 17:04:38 +0800
Subject: [PATCH v2 1/2] ARM: imx6: disable deeper idle states when FEC is
 active w/o HW workaround
In-Reply-To: <1464971480-9203-1-git-send-email-l.stach@pengutronix.de>
References: <1464971480-9203-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160611090438.GG20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 06:31:19PM +0200, Lucas Stach wrote:
> The i.MX6 Q/DL has an erratum (ERR006687) that prevents the FEC from
> waking the CPUs when they are in wait(unclocked) state. As the hardware
> workaround isn't applicable to all boards, disable the deeper idle state
> when the workaround isn't present and the FEC is in use.
> 
> This allows to safely run a kernel with CPUidle enabled on all i.MX6
> boards.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: David S. Miller <davem@davemloft.net> (for network changes)

Applied both, thanks.
