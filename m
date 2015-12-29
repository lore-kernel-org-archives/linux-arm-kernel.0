From: robh@kernel.org (Rob Herring)
Date: Tue, 29 Dec 2015 12:35:21 -0600
Subject: [PATCH] arm64: Add DT support for Juno r2 board
In-Reply-To: <1450872611-15326-1-git-send-email-sudeep.holla@arm.com>
References: <1450872611-15326-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20151229183521.GL12450@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 12:10:11PM +0000, Sudeep Holla wrote:
> Juno r2 is identical to Juno r1 with Cortex A57 cores replaced by
> Cortex A72 cores.

That's a bigger change than I'd expect...

> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm-boards |   1 +
>  Documentation/devicetree/bindings/arm/cpus.txt   |   1 +

This should probably be a separate patch, but I already have a patch in 
my tree for 4.5 adding arm,cortex-a72. So just drop this hunk.

>  arch/arm64/boot/dts/arm/Makefile                 |   2 +-
>  arch/arm64/boot/dts/arm/juno-r2.dts              | 200 +++++++++++++++++++++++
>  4 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/arm/juno-r2.dts

[...]

> +	pmu_a72 {
> +		compatible = "arm,cortex-a72-pmu";

This needs to be documented.


> +	pcie-controller at 40000000 {
> +		compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";

Is this common with r1?

Rob
