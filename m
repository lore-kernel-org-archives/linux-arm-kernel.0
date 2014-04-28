From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 28 Apr 2014 13:55:40 +0200
Subject: [PATCH 3/5] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
Message-ID: <CAPDyKFoboE4iKyom86+EwHHTQAGpgKxGq969yrjQVpqizk-SLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 April 2014 15:29, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> The PMU device contains an interrupt controller, power control and
> resets.  The interrupt controller is a little sub-standard in that
> there is no race free way to clear down pending interrupts, so we try
> to avoid problems by reducing the window as much as possible, and
> clearing as infrequently as possible.
>
> The interrupt support is implemented using an IRQ domain, and the
> parent interrupt referenced in the standard DT way.
>
> The power domains and reset support is closely related - there is a
> defined sequence for powering down a domain which is tightly coupled
> with asserting the reset.  Hence, it makes sense to group these two
> together.
>
> This patch adds the core PMU driver: power domains must be defined in
> the DT file in order to make use of them.  The reset controller can
> be referenced in the standard way for reset controllers.

Hi Russell,

This patch would be simplified if this was based upon the not yet
merged patchset from Tomasz Figa, "[PATCH v3 0/3] Generic Device Tree
based power domain look-up".

For example you would likely not need to add some of the marvel
specific DT bindings, and you wouldn?t need the bus_notifiers to add
devices to the power domain. I guess I just though it could be useful
input to consider while going forward, unless you already knew.

Kind regards
Ulf Hansson
