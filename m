From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Aug 2013 16:07:32 +0100
Subject: [PATCH v2] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <20130820150731.GB27819@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 06:19:59PM +0100, Punit Agrawal wrote:
> The CCI PMU can profile bus transactions at the master and slave
> interfaces of the CCI. The PMU can be used to observe an aggregated view
> of the bus traffic between the various components connected to the CCI.
> 
> Extend the existing CCI driver to support the PMU by registering a perf
> backend for it.
> 
> Document the device tree binding to describe the CCI PMU.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
> 
> Hi,
> 
> This is the second version of the CCI PMU driver. The changes incorporate review
> comments on device tree bindings and corresponding update to the driver.
> 
> Cheers,
> Punit
> 
> Will, I've dropped your reviewed-by tag due to the changes. Let me know if you are
> ok with the changes and I'll add the tag.

I'm not the right person to review the DT binding, but the actual driver
code is fine. You can either:

  1. Add my reviewed-by once you have an Ack from a DT maintainer

or

  2. Split the patch in two (binding + driver) and add my reviewed-by to the
     driver part

Either way, once you have the DT part sorted out, please send a fresh
version with the relevant tags and stick me on CC.

Cheers,

Will
