From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 17 Aug 2011 15:12:59 +0100
Subject: [RFC PATCH 00/15] ARM: perf: support multiple PMUs
In-Reply-To: <1313416516-8006-1-git-send-email-mark.rutland@arm.com>
References: <1313416516-8006-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20110817141259.GC6586@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Aug 15, 2011 at 02:55:01PM +0100, Mark Rutland wrote:
> System (AKA nest or uncore) PMUs exist on devices which are not affine
> to a single CPU. They usually cannot be directly associated with
> individual tasks and are asynchronous with respect to the current
> execution. Examples of devices which could have system PMUs include L2
> cache controllers, GPUs and memory buses.
> 
> The following patch series refactors the ARM PMU backend, enabling
> new PMUs to reuse the existing code. This should allow for system PMUs
> to be supported in future. Further work will be required to get perf to
> fully understand system PMUs, but this provides something usable.
> 
> The framework is intended to be used by system PMUs which hang off core
> platform components (e.g. L2 cache, AXI bus). If a device is complex
> enough or separate enough from core functionality to have its own
> driver, it should implement its own PMU handling using the core perf
> API directly.

Looks like a nice series to me.

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
