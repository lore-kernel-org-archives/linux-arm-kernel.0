From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 27 Jul 2010 19:54:42 +0900
Subject: S5PC110 should be used the correct VIC number
Message-ID: <AANLkTikh7mt30gEQU0_Wr7n-jZrG0iUmd1Hw17Ni7UNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Can you post the VIC patch from correct VIC number from vic code at
suspend & resume?
If not, it has to modify it after release. or can you fix it as below.

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 0a34c81..0ac3d81 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -6,6 +6,7 @@ config ARM_VIC

 config ARM_VIC_NR
        int
+       default 4 if ARCH_S5PV210
        default 2
        depends on ARM_VIC
        help

I hope anyone should be included at this rc window.

Thank you,
Kyungmin Park
