From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Mar 2012 20:34:51 -0500
Subject: [PATCH v4 0/2] ARM: Exynos: Add irq_domain and device tree support
 for combiner
In-Reply-To: <1329798806-32482-1-git-send-email-thomas.abraham@linaro.org>
References: <1329798806-32482-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F5EA43B.8040802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2012 10:33 PM, Thomas Abraham wrote:
> Changes since v3:
> - In dt case, the use of fixed gic linux irq number to map the combiner
>   interrupt output is removed. This is replaced with the interrupt number
>   obtained from the gic irq domain. (Thanks to Rob Herring and Grant
>   Likely for this suggestion).
> - Split the patch into two parts - irq_domain and device tree support
>   addition.
> 
> Changes since v2:
> - Rebased to Grant's irqdomain/next branch.
> 
> Changes since v1:
> - Includes all changes suggested by Rob Herring.
> - Tested with SPARSE_IRQ enabled.
> 
> This patchset adds irq_domain and device tree support for the Exynos Interrupt
> Combiner controller.
> 
> The first patch adds a common irq domain for the interrupts managed by the
> interrupt combiners. All the instances of irq combiner reference the common irq
> domain for translating hardware interrupts to linux irq number.
> 
> The second patch adds a interrupt specifier translator to support device tree
> based instantiation. It can translate interrupt specifiers for device nodes
> which use combiner as their interrupt parent.
> 
> This patchset is based on
> http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git [for-next]
> 
> with all irq_domain (v5) patches merged from
> http://git.secretlab.ca/git/linux-2.6.git [irqdomain/next]
> 
> Thomas Abraham (2):
>   ARM: Exynos: Add irq_domain support for interrupt combiner
>   ARM: Exynos: Add device tree support for interrupt combiner
> 
>  .../bindings/arm/samsung/interrupt-combiner.txt    |   48 +++++++++
>  arch/arm/mach-exynos/common.c                      |  112 ++++++++++++++++----
>  2 files changed, 140 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob
