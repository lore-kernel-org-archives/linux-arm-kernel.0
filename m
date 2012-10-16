From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 15 Oct 2012 17:37:56 -0700
Subject: [PATCH v10 0/4] ARM: KDB FIQ debugger
Message-ID: <20121016003756.GA23146@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

The KDB/NMI core support has been merged into v3.7-rc1, so the only ARM
bits are pending now. I believe I addressed all your previous comments,
but surely there might be something else to improve, thus would be great
if you could take a look at this.

The patches were rebased onto v3.7-rc1, and this is the only change in
v10.

Old changelogs and rationale for these patches can be found here:

	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
	v6: http://lkml.org/lkml/2012/9/10/2
	v7: http://lkml.org/lkml/2012/9/13/367
	v8: http://lkml.org/lkml/2012/9/19/525
	v9: http://lkml.org/lkml/2012/9/24/538

Thanks!
Anton.

--
 arch/arm/Kconfig                    |  19 ++++
 arch/arm/common/vic.c               |  28 +++++
 arch/arm/include/asm/hardware/vic.h |   2 +
 arch/arm/include/asm/kgdb.h         |   8 ++
 arch/arm/kernel/Makefile            |   1 +
 arch/arm/kernel/entry-armv.S        | 167 +---------------------------
 arch/arm/kernel/entry-header.S      | 170 +++++++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq.c          | 124 +++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S    |  87 +++++++++++++++
 arch/arm/mach-versatile/Makefile    |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c  |  31 ++++++
 11 files changed, 472 insertions(+), 166 deletions(-)
