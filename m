From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Mar 2015 22:55:47 +0100
Subject: [PATCH v3 01/15] scripts: link-vmlinux: Don't pass page offset to
 kallsyms if XIP Kernel
In-Reply-To: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1426197361-19290-2-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Coquelin <mcoquelin.stm32@gmail.com>

When Kernel is executed in place from ROM, the symbol addresses can be
lower than the page offset.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 86a4fe7..b055d9d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -82,7 +82,7 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if [ -n "${CONFIG_ARM}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
+	if [ -n "${CONFIG_ARM}" ] && [ -z "${CONFIG_XIP_KERNEL}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
 		kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
 	fi
 
-- 
1.9.1
