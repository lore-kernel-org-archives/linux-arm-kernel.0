From: Reinhard.Tartler@informatik.uni-erlangen.de (Reinhard Tartler)
Date: Tue, 24 Apr 2012 11:45:37 +0200
Subject: [PATCH] ARM: arch/arm/mach-shark/pci.c: signal errors correctly
Message-ID: <87vckpsbsu.fsf@faui43f.informatik.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

with configration-aware static analysis, we have found a gcc warning
that can be fixed easily. Please consider applying the following
patch (based on v3.4-rc4).


>From 4fd3be96ed8d35d9825d833623ddd69485ddc5ba Mon Sep 17 00:00:00 2001
From: Reinhard Tartler <siretart@tauware.de>
Date: Tue, 24 Apr 2012 11:35:16 +0200
Subject: [PATCH] ARM: arch/arm/mach-shark/pci.c: signal errors correctly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit fixes the following gcc warning:
arch/arm/mach-shark/pci.c:42: warning: ?return? with no value, in function returning non-void

Signed-off-by: Reinhard Tartler <tartler@cs.fau.de>
---
 arch/arm/mach-shark/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
index 7cb79a0..12fcc47 100644
--- a/arch/arm/mach-shark/pci.c
+++ b/arch/arm/mach-shark/pci.c
@@ -39,7 +39,7 @@ static struct hw_pci shark_pci __initdata = {
 static int __init shark_pci_init(void)
 {
        if (!machine_is_shark())
-               return;
+               return 1;
 
        pcibios_min_io = 0x6000;
        pcibios_min_mem = 0x50000000;
-- 
1.7.9.5


-- 
Reinhard Tartler                     Department of Computer Science IV
Martensstr 1, 91058 Erlangen Germany, University of Erlangen-Nuremberg
            http://www4.informatik.uni-erlangen.de/~tartler
