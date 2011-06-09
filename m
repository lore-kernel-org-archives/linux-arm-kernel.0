From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 9 Jun 2011 10:55:47 +0100
Subject: [PATCH 1/2] ARM: pmu: refactor reservation
In-Reply-To: <1307546911-2714-2-git-send-email-mark.rutland@arm.com>
References: <1307546911-2714-1-git-send-email-mark.rutland@arm.com>
	<1307546911-2714-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20110609095547.GA3711@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 04:28:30PM +0100, Mark Rutland wrote:
> Currently, PMU platform_device reservation relies on some minor abuse
> of the platform_device::id field for determining the type of PMU. This
> is problematic for device tree based probing, where the ID cannot be
> controlled.
> 
> This patch removes reliance on the id field, and depends on each PMU's
> platform driver to figure out which type it is. As all PMUs handled by
> the current platform_driver name "arm-pmu" are CPU PMUs, this
> convention is hardcoded. New PMU types will require the addition of new
> platform drivers (e.g. "arm-pmu-l2cc").
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Looks good to me.

Acked-by: Jamie Iles <jamie@jamieiles.com>

As a slight aside, when we have more PMU types could we key off of an ID 
table rather than creating a new platform driver for each type?

Jamie
