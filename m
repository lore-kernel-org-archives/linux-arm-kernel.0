From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 30 May 2013 17:18:28 +0100
Subject: [PATCH RFC 1/6] [HACK!] arm64/xen: create links to arch/arm include
 files and Xen code
In-Reply-To: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
Message-ID: <1369930713-6063-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of Xen support for ARM is common between ARMv7 and ARMv8.
Create links to the code under arch/arm (bleah).

Other, probably better alternatives:

- move the code to a different location, maybe the header files to
include/xen/arm and the code to drivers/xen/arm (still pretty ugly)?

- create a copy of the code to arch/arm64 (even worse);

Please advice on how you would like me to move forward on this.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm64/include/asm/xen   |    1 +
 arch/arm64/xen/enlighten.c   |    1 +
 arch/arm64/xen/grant-table.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)
 create mode 120000 arch/arm64/include/asm/xen
 create mode 120000 arch/arm64/xen/enlighten.c
 create mode 120000 arch/arm64/xen/grant-table.c

diff --git a/arch/arm64/include/asm/xen b/arch/arm64/include/asm/xen
new file mode 120000
index 0000000..c27d6980
--- /dev/null
+++ b/arch/arm64/include/asm/xen
@@ -0,0 +1 @@
+../../../arm/include/asm/xen
\ No newline at end of file
diff --git a/arch/arm64/xen/enlighten.c b/arch/arm64/xen/enlighten.c
new file mode 120000
index 0000000..cb31b7c
--- /dev/null
+++ b/arch/arm64/xen/enlighten.c
@@ -0,0 +1 @@
+../../arm/xen/enlighten.c
\ No newline at end of file
diff --git a/arch/arm64/xen/grant-table.c b/arch/arm64/xen/grant-table.c
new file mode 120000
index 0000000..5494f6c
--- /dev/null
+++ b/arch/arm64/xen/grant-table.c
@@ -0,0 +1 @@
+../../arm/xen/grant-table.c
\ No newline at end of file
-- 
1.7.2.5
