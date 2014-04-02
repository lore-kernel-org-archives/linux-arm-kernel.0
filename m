From: jwboyer@fedoraproject.org (Josh Boyer)
Date: Wed, 2 Apr 2014 10:40:20 -0400
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <CAKohpok3gKyOWD0=pSv0yQLNqJcNPNZagRGFXNFHW+3J7E=mOg@mail.gmail.com>
References: <CA+5PVA6awqaSHQboqdv9nynV9Xjp46VeqijDWxZX1v5wDK0NWQ@mail.gmail.com>
 <CAKohpok3gKyOWD0=pSv0yQLNqJcNPNZagRGFXNFHW+3J7E=mOg@mail.gmail.com>
Message-ID: <20140402144020.GA20438@zod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 74397174989e5f70 attempted to clean up the power management options
for arm64, but when things were merged it didn't fully take effect.  Fix
it again.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
---
 arch/arm64/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07aa3556952c..8033b9b8a2df 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -321,12 +321,6 @@ menu "CPU Power Management"
 
 source "drivers/cpuidle/Kconfig"
 
-source "drivers/cpufreq/Kconfig"
-
-endmenu
-
-menu "Power management options"
-
 source "kernel/power/Kconfig"
 
 source "drivers/cpufreq/Kconfig"
-- 
1.8.5.3
