From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Mar 2017 10:21:59 +0100
Subject: [PATCH v2 0/6] ARM: dts: renesas: Add INTC-SYS clock to device
 tree
In-Reply-To: <1488819491-26097-1-git-send-email-geert+renesas@glider.be>
References: <1488819491-26097-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170310092159.GE21820@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 05:58:05PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series improves the topology description in DT of the ARM GIC
> on Renesas SoCs using the legacy CPG/MSTP bindings (R-Mobile APE6 and
> R-Car Gen2).  It describes the INTC-SYS clock, links the GIC to its
> module clock, and adds the GIC to the SYSC "always on" PM Domain.
> 
> Note that currently the GIC-400 driver doesn't support module clocks nor
> Runtime PM, so this must be handled as a critical clock.  Hence this
> series depends on commit e34084fb9a023d1d ("clk: renesas: mstp: Make
> INTC-SYS a critical clock"), which is in v4.11-rc1.
> 
> This series is the counterpart of "[PATCH 0/4] ARM/arm64: dts: renesas:
> Link ARM GIC to clock and clock domain" for SoCs not yet migrated to the
> new CPG/MSSR driver.  The latter is already part of v4.11-rc1 as it had
> less dependencies.
> 
> Changes compared to v1:
>   - Add missing "power-domains" property,
>   - Add clock-names property,
>   - Rebased on top of CPG Clock Domain and R-Car SYSC PM Domain support,
>   - Add r8a7792 patch,
>   - Please refer to the individual patch changelogs for more details
>     (v1 dates back to 2014).
> 
> Thanks for applying!

Thanks, done.
