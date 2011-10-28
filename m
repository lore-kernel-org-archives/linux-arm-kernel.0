From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Oct 2011 16:17:51 -0500
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4EA5DADC.7030805@gmail.com>
References: <4EA5DADC.7030805@gmail.com>
Message-ID: <4EAB1BFF.3070406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 10/24/2011 04:38 PM, Rob Herring wrote:
> Arnd,
> 
> I'm not sure if you want a rebased branch to fix merge conflicts or not.
> If that's okay, please pull. I've also fixed the msm compile failure.
> 
> The dependencies are v3.1-rc9 and rmk's devel-stable.
> 

Here's an updated pull request to fix missing export.h include. Now it's
also dependent on module.h clean-up branch:

git://openlinux.windriver.com/people/paulg/linux-next for-sfr


The following changes since commit fa1d6d372245a160eecf5f57d64d2b21ea248e08:

  Merge branch 'for-sfr' of
git://openlinux.windriver.com/people/paulg/linux-next into HEAD
(2011-10-28 15:51:07 -0500)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git gic-dt

Rob Herring (5):
      of/irq: introduce of_irq_init
      irq: support domains with non-zero hwirq base
      ARM: gic: add irq_domain support
      ARM: gic: add OF based initialization
      ARM: gic: fix irq_alloc_descs handling for sparse irq

 Documentation/devicetree/bindings/arm/gic.txt |   55 +++++++
 arch/arm/common/Kconfig                       |    1 +
 arch/arm/common/gic.c                         |  188
++++++++++++++++--------
 arch/arm/include/asm/hardware/gic.h           |   10 +-
 drivers/of/irq.c                              |  107 ++++++++++++++
 include/linux/irqdomain.h                     |   16 ++-
 include/linux/of_irq.h                        |    3 +
 kernel/irq/irqdomain.c                        |   12 +-
 8 files changed, 320 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

Rob
