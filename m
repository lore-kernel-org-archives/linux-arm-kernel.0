From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 8 Oct 2011 19:34:29 +0530
Subject: [PATCH 0/3] GIC OF bindings
In-Reply-To: <1317410880-24828-1-git-send-email-robherring2@gmail.com>
References: <1317410880-24828-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAJuYYwRLqdfagj7KxbdmvPBz2J1LWwphew+0eTkxWDZtW8Zh7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2011 00:57, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Another round of GIC devicetree support.
>
> This moves the tracking of the starting hwirq number into the irq domain
> code. Doing this makes hwirq == GIC interrupt ID and simplifies the GIC
> code removing irq_offset.
>
> The full series is available here. This includes Russell's devel-stable and
> for-next branches and Nico's vmalloc branch:
>
> git://git.jdl.com/software/linux-3.0.git gic-v2
>
> Tested on highbank and Realview 11MPCore qemu (2 GICs).
>
> Rob
>
> Rob Herring (3):
> ?irq: support domains with non-zero hwirq base
> ?ARM: gic: add irq_domain support
> ?ARM: gic: add OF based initialization

For Exynos4 GIC and Interrupt Combiner Controllers:

Tested-by: Thomas Abraham <thomas.abraham@linaro.org>

>
> ?Documentation/devicetree/bindings/arm/gic.txt | ? 55 ++++++++++
> ?arch/arm/common/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/common/gic.c ? ? ? ? ? ? ? ? ? ? ? ? | ?142 +++++++++++++++++++------
> ?arch/arm/include/asm/hardware/gic.h ? ? ? ? ? | ? ?5 +-
> ?include/linux/irqdomain.h ? ? ? ? ? ? ? ? ? ? | ? 16 +++-
> ?kernel/irq/irqdomain.c ? ? ? ? ? ? ? ? ? ? ? ?| ? 12 +-
> ?6 files changed, 189 insertions(+), 42 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
>
> --
> 1.7.5.4
>
>
