From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 14:58:17 +0000
Subject: [RFC PATCH 0/2] ARM: pmu: provide a registration mechanism for IRQs
Message-ID: <1268233099-28965-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC patch was prompted by a discussion with Russell about the PMU IRQs
for the new Versatile Express platform:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/010921.html

The set contains two patches, the second of which is intended purely as an
example to illustrate the usage of the new framework.

All comments welcome.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jamie Iles <jamie.iles@picochip.com>

Will Deacon (2):
  ARM: pmu: register IRQs at runtime
  ARM: Realview-PBX: register PMU IRQs during board initialisation

 arch/arm/include/asm/pmu.h            |   36 ++++++++---
 arch/arm/kernel/perf_event.c          |    6 +-
 arch/arm/kernel/pmu.c                 |  103 ++++++++++++++++++---------------
 arch/arm/mach-realview/realview_pbx.c |   15 +++++
 4 files changed, 101 insertions(+), 59 deletions(-)
