From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Jun 2016 09:33:11 -0500
Subject: [PATCH v2 1/2] ARM: imx6: disable deeper idle states when FEC is
 active w/o HW workaround
In-Reply-To: <1464971480-9203-1-git-send-email-l.stach@pengutronix.de>
References: <1464971480-9203-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160606143311.GA21103@rob-hp-laptop>
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
> ---
> v2: Spell out "workaround" to avoid confusion.
> ---
>  Documentation/devicetree/bindings/net/fsl-fec.txt |  3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-imx/cpuidle-imx6q.c                 | 16 +++++++++++++++
>  drivers/net/ethernet/freescale/fec.h              |  2 ++
>  drivers/net/ethernet/freescale/fec_main.c         | 12 +++++++++++
>  include/soc/imx/cpuidle.h                         | 25 +++++++++++++++++++++++
>  5 files changed, 58 insertions(+)
>  create mode 100644 include/soc/imx/cpuidle.h
