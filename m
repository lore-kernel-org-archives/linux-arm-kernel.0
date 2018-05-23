From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 13:18:00 -0500
Subject: [PATCH 06/11] dts: bindings: Restrict coresight tmc-etr
 scatter-gather mode
In-Reply-To: <1526661567-4578-7-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
 <1526661567-4578-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180523181800.GA610@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 05:39:22PM +0100, Suzuki K Poulose wrote:
> We are about to add the support for ETR builtin scatter-gather mode
> for dealing with large amount of trace buffers. However, on some of
> the platforms, using the ETR SG mode can lock up the system due to
> the way the ETR is connected to the memory subsystem.
> 
> In SG mode, the ETR performs READ from the scatter-gather table to
> fetch the next page and regular WRITE of trace data. If the READ
> operation doesn't complete(due to the memory subsystem issues,
> which we have seen on a couple of platforms) the trace WRITE
> cannot proceed leading to issues. So, we by default do not
> use the SG mode, unless it is known to be safe on the platform.
> We define a DT property for the TMC node to specify whether we
> have a proper SG mode.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Horley <john.horley@arm.com>
> Cc: Robert Walker <robert.walker@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: frowand.list at gmail.com
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
>  drivers/hwtracing/coresight/coresight-tmc.c         | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
