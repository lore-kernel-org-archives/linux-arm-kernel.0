From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 10 Aug 2018 15:36:31 +0200
Subject: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada 3700
In-Reply-To: <20180810113627.5dec5d40@xhacker.debian>
References: <20180810113627.5dec5d40@xhacker.debian>
Message-ID: <20180810133631.GA11350@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 11:36:27AM +0800, Jisheng Zhang wrote:
> The mvneta Ethernet driver is used on a few different Marvell SoCs.
> Some SoCs have per cpu interrupts for Ethernet events, the driver uses
> a per CPU napi structure for this case. Some SoCs such as armada 3700
> have a single interrupt for Ethernet events, the driver uses a global
> napi structure for this case.
> 
> Current mvneta_config_rss() always operates the per cpu napi structure.
> Fix it by operating a global napi for "single interrupt" case, and per
> cpu napi structure for remaining cases.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")

Looks reasonable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
