From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Aug 2011 11:08:59 +0100
Subject: [PATCH] ARM: GIC: Add device tree interrupt specifier
	translation support
In-Reply-To: <1312532353-8772-1-git-send-email-thomas.abraham@linaro.org>
References: <1312532353-8772-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20110805100859.GE20575@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 09:19:13AM +0100, Thomas Abraham wrote:
> Add support for translation of hardware interrupt numbers specified in device
> tree nodes to linux irq number.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> Notes:
> 1. The translation of SGI/PPI interrupts is supported only for CPU0.
> 2. The documentation is derived from the following patch submitted
>    earlier by Rob Herring.
>    [PATCH 2/3] ARM: gic: add OF based initialization

Ignore SGIs for the purposes of DT.  SGIs aren't part of the hardware
setup of a SoC or device, and are specific to the internals of SMP.
