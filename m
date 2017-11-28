From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Nov 2017 07:16:29 +0000
Subject: [PATCH] irqchip/gic-v3: Support MSIs via aliases and distributor
In-Reply-To: <20171127102408.6631-1-sboyd@codeaurora.org>
References: <20171127102408.6631-1-sboyd@codeaurora.org>
Message-ID: <c77120d6-a3b9-02e6-f578-52e1d13b92d0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen,

Thanks for the patch.
On 27/11/17 10:24, Stephen Boyd wrote:
> Some GIC configurations don't have an accessible ITS, but they
> want to support MSIs through the distributor's SETSPI registers
> or through the IMPLEMENTATION DEFINED message-based interrupt
> request register region. This mode of operation is similar to the
> v2m support on gic-400, but we don't necessarily know what
> particular SPIs are supported as MSIs so we need some help from
> firmware to know what to do.
> 
> Introduce an "arm,spi-ranges" property for this, similar to the
> "marvell,spi-ranges" property, that indicates the base and size
> of each MSI range. This property applies equally to the
> distributor and alias registers. In either case, we detect this
> mode of operation by looking for a node with the "msi-controller"
> property and then probe the v2m frame code on top of it. Assume
> these nodes will have the "arm,spi-ranges" property in them so
> that the v2m code works mostly unmodified.
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Tested it on DB820c board.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
