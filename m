From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 1 Sep 2012 10:53:40 +0200
Subject: [PATCH 1/3] ARM: move debug macros to common location
Message-ID: <20120901085340.GA20497@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Based on suggestion by Russell King, create a common location for debug
> macros and select the included debug macro file using config option.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/Kconfig.debug          |    5 +++
>  arch/arm/include/debug/icedcc.S |   90 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/debug.S         |   87 ++-----------------------------------
>  arch/arm/kernel/head.S          |    4 +-
>  4 files changed, 100 insertions(+), 86 deletions(-)
>  create mode 100644 arch/arm/include/debug/icedcc.S

Hi Rob

What about arch/arm/include/asm/hardware/debug-8250.S and
arch/arm/include/asm/hardware/debug-pl01x.S?

Might be nice to have these two also in arch/arm/include/debug/, or
follow the naming convention set by these two and have
arch/arm/include/asm/hardware/debug-icedcc.S?

Andrew
