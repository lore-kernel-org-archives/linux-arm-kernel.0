From: opendmb@gmail.com (Doug Berger)
Date: Tue, 28 Mar 2017 14:34:25 -0700
Subject: [PATCH v2 2/8] arm64: mm: mark fault_info __ro_after_init
In-Reply-To: <20170328213431.10904-1-opendmb@gmail.com>
References: <20170328213431.10904-1-opendmb@gmail.com>
Message-ID: <20170328213431.10904-3-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fault_info table must be made writeable to allow installation
of custom memory abort handlers, but it can be made read-only
after initialization to provide some protection.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index cdf1260f1005..43319ed58a47 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -493,7 +493,7 @@ static struct fault_info {
 	int	sig;
 	int	code;
 	const char *name;
-} fault_info[] = {
+} fault_info[] __ro_after_init = {
 	{ do_bad,		SIGBUS,  0,		"ttbr address size fault"	},
 	{ do_bad,		SIGBUS,  0,		"level 1 address size fault"	},
 	{ do_bad,		SIGBUS,  0,		"level 2 address size fault"	},
-- 
2.12.0
