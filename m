From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:21:02 +0900
Subject: [PATCH 00/04] ARM: shmobile: KZM9D legacy board code removal
Message-ID: <20131106232102.8081.20523.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: KZM9D legacy board code removal

[PATCH 01/04] ARM: shmobile: Add shared EMEV2 code for ->init_machine()
[PATCH 02/04] ARM: shmobile: Use ->init_late() in shared EMEV2 case
[PATCH 03/04] ARM: shmobile: Remove legacy KZM9D board code
[PATCH 04/04] ARM: shmobile: Remove legacy platform devices from EMEV2 SoC code 

With this patch set applied it is possible to use DT for KZM9D board support.
Because of this is the KZM9D legacy C board code removed together with EMEV2
platform devices. All these devices are available via DT anyway, so there is
no need to keep the C version. This saves some lines of code and shows where
mach-shmobile is heading in the future for all the SoCs.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.12-rc7-20131101

 arch/arm/mach-shmobile/Kconfig              |    6 -
 arch/arm/mach-shmobile/Makefile             |    1 
 arch/arm/mach-shmobile/Makefile.boot        |    1 
 arch/arm/mach-shmobile/board-kzm9d.c        |   92 ---------------
 arch/arm/mach-shmobile/include/mach/emev2.h |    5 
 arch/arm/mach-shmobile/setup-emev2.c        |  161 ++-------------------------
 6 files changed, 13 insertions(+), 253 deletions(-)
