From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:20:41 +0100
Subject: [PATCH v7 2/8] Documentation: arm: define DT idle states bindings
In-Reply-To: <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140818142041.GC20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 04:52:01PM +0100, Lorenzo Pieralisi wrote:
> ARM based platforms implement a variety of power management schemes that
> allow processors to enter idle states at run-time.
> The parameters defining these idle states vary on a per-platform basis forcing
> the OS to hardcode the state parameters in platform specific static tables
> whose size grows as the number of platforms supported in the kernel increases
> and hampers device drivers standardization.
> 
> Therefore, this patch aims at standardizing idle state device tree bindings
> for ARM platforms. Bindings define idle state parameters inclusive of entry
> methods and state latencies, to allow operating systems to retrieve the
> configuration entries from the device tree and initialize the related power
> management drivers, paving the way for common code in the kernel to deal with
> idle states and removing the need for static data in current and previous
> kernel versions.
> 
> ARM64 platforms require the DT to define an entry-method property
> for idle states.
> 
> On system implementing PSCI as an enable-method to enter low-power
> states the PSCI CPU suspend method requires the power_state parameter to
> be passed to the PSCI CPU suspend function.
> 
> This parameter is specific to a power state and platform specific,
> therefore must be provided by firmware to the OS in order to enable
> proper call sequence.
> 
> Thus, this patch also adds a property in the PSCI bindings that
> describes how the PSCI CPU suspend power_state parameter should be
> defined in DT in all device nodes that rely on PSCI CPU suspend method usage.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
>  .../devicetree/bindings/arm/idle-states.txt        | 679 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/psci.txt     |  14 +-
>  3 files changed, 700 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
