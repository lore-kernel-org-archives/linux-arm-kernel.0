From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 22:07:44 +0800
Subject: [PATCH v3 1/1] ARM: dts: imx7d: add cortex-a7 coresight component
In-Reply-To: <1435676291-27720-1-git-send-email-Frank.Li@freescale.com>
References: <1435676291-27720-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150713140744.GS23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 10:58:11PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Added etm, etb, funnel and replicator
> 
> usage example:
> 
>     echo 1 >/sys/bus/coresight/devices/30086000.etr/enable_sink
>     echo 1 >/sys/bus/coresight/devices/3007c000.etm/enable_source
> 
>         coresight-tmc 30086000.etr: TMC enabled
>         coresight-replicator replicator.1: REPLICATOR enabled
>         coresight-tmc 30084000.tmc: TMC enabled
>         coresight-funnel 30083000.funnel: FUNNEL inport 0 enabled
>         coresight-funnel 30041000.funnel: FUNNEL inport 0 enabled
>         coresight-etm3x 3007c000.etm: ETM tracing enabled
> 
>     etm enable here.
>     trace data save at /dev/30086000.etr
> 
>     cat /dev/30086000.etr > trace.data
> 
>         coresight-tmc 30086000.etr: TMC read start
>         coresight-tmc 30086000.etr: TMC read end
> 
>     use ptm2human(https://github.com/hwangcc23/ptm2human) to show trace data
> 
>     ptm2human -i trace.data
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Mathieu gave his ACK on your v2 of the patch.  You should add his ACK on
v3.  Applied with Mathieu's ACK added.

Shawn
