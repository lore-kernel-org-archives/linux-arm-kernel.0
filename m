From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Oct 2011 20:45:14 -0500
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <201110310131.53251.arnd@arndb.de>
References: <4EA5DADC.7030805@gmail.com> <4EAB1BFF.3070406@gmail.com>
	<201110310131.53251.arnd@arndb.de>
Message-ID: <4EADFDAA.4000808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 10/30/2011 07:31 PM, Arnd Bergmann wrote:
> On Friday 28 October 2011, Rob Herring wrote:
>>   Merge branch 'for-sfr' of
>> git://openlinux.windriver.com/people/paulg/linux-next into HEAD
>> (2011-10-28 15:51:07 -0500)
>>
> 
> Rob, I think there is no chance that this is working out.
> 
> I've just spent a few hours trying to resolve all the dependencies from this,
> but I don't think it will work out, unless Linus pulls that tree very soon,
> which I think is very unlikely.
> 
> Have you made sure that Paul even considers this branch stable?

No.

> Normally this kind of change gets pushed *last* in the merge window, to make
> it possible to fix up all the stuff that breaks. This means I cannot
> wait for the branch to get merged upstream before send a pull request for
> my next/dt and next/soc branches.
> 
> Do you even depend on that branch? It seems to me that you merely have a
> conflict, not a dependency, so why do you even try fixing it up?

Sorry about this. I thought I needed to fix the linux-next build
breakage. I only depend on it when export.h gets introduced, so I can
drop that out. All the other dependencies are in Linus' master now. I
pushed out a branch without Paul's branch:

I get to Connect around 2PM tomorrow, we can discuss further then if
necessary.

The following changes since commit ce949717b559709423c1ef716a9db16d1dcadaed:

  Merge git://github.com/rustyrussell/linux (2011-10-29 07:52:16 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git gic-dt-v2

Rob Herring (5):
      of/irq: introduce of_irq_init
      irq: support domains with non-zero hwirq base
      ARM: gic: add irq_domain support
      ARM: gic: add OF based initialization
      ARM: gic: fix irq_alloc_descs handling for sparse irq

 Documentation/devicetree/bindings/arm/gic.txt |   55 +++++++
 arch/arm/common/Kconfig                       |    1 +
 arch/arm/common/gic.c                         |  187
++++++++++++++++---------
 arch/arm/include/asm/hardware/gic.h           |   10 +-
 drivers/of/irq.c                              |  107 ++++++++++++++
 include/linux/irqdomain.h                     |   16 ++-
 include/linux/of_irq.h                        |    3 +
 kernel/irq/irqdomain.c                        |   12 +-
 8 files changed, 319 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

Rob
