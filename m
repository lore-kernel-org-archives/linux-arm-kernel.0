From: kauppi@papupata.org (Ari Kauppi)
Date: Thu, 20 Jan 2011 20:57:17 +0200
Subject: [PATCH v2 0/3] oprofile: ARM backtraces and few minors
Message-ID: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset re-enables ARM backtraces with non-PMU capable CPUs.

In V2 I have tried to address the comments received for the V1
patches. arch/sh/oprofile/common.c is untouched but should work
as earlier.

Compile tested with arm/omap2plus_defconfig (with and without
CONFIG_HW_PERF_EVENTS).

Ari Kauppi (3):
  oprofile: Use CONFIG_HW_PERF_EVENTS for oprofile_perf_init and
    friends
  oprofile: Provide stubs for oprofile_perf_{init,exit}
  ARM: oprofile: Always allow backtraces

 arch/arm/oprofile/common.c |   12 ++----------
 include/linux/oprofile.h   |   13 +++++++++++--
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
1.7.4.rc2.3.g60a2e
