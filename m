From: richard@nod.at (Richard Weinberger)
Date: Sun, 13 Jul 2014 16:58:56 +0200
Subject: [RFC] Remove remaining users of exec domains
Message-ID: <1405263538-27589-1-git-send-email-richard@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches remove the last two in-tree users of exec domains.
Both seem to be abandoned and historical.
Russel, Tony, are you fine with that? 

The plan is to get rid of exec domains at all. IOW no more register_exec_domain,
no signal translation.
I have a follow up series for that already in my local tree.

Thanks,
//richard

[PATCH 1/2] arm: Remove RISC OS personality
[PATCH 2/2] ia64: Remove Linux/x86 domain support

 arch/arm/kernel/arthur.c          |   94 ------------------------------------
 arch/arm/Kconfig                  |   12 ----
 arch/arm/configs/badge4_defconfig |    1 
 arch/arm/kernel/Makefile          |    1 
 arch/ia64/mm/init.c               |   25 ---------
 5 files changed, 133 deletions(-)
