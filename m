From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 11 Sep 2017 08:26:27 -0700
Subject: [PATCH v3 0/3] arm64: Add CONFIG_KUSER_HELPERS
Message-ID: <20170911152635.95367-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to disable the kuser helpers by adding a KUSER_HELPERS
config option (enabled by default). When disabled, all kuser
helpers-related code is removed from the kernel and no mapping is done
at the fixed high address (0xffff0000); any attempt to use a kuser
helper from a 32-bit process will result in a segfault.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2:
- vectors_page and compat_vdso_spec as array of 2
- free sigpage if vectors allocation failed
- adjust makefile so one line for each of the assembler source modules
- split off assembler changes to a new previous patch in series to reduce churn
- modify slightly the feature documentation to reduce its reach
- modify slightly the feature documentation to rationalize the yes default.
- There are more ifdefs as a result of the rebase.

v3:
- rebase (minor conflicts)
