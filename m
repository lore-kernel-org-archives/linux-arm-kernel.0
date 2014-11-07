From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Fri,  7 Nov 2014 15:59:11 +0100
Subject: [PATCH] arm: ftrace: Adds support for ftrace operations
Message-ID: <1415372352-15664-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch adds support for ftrace operations on the ARM architecture.
This support is needed by kgraft and possibly other ftrace-based tools.
My goal is to have kgraft working on ARM and aarch64.

I tested this patch with a toy implementation of kgraft for ARM and basic
usage of function and function_graph tracers
It doesn't show any problem with the ftrace selftests and the tests found
today in branch ftrace/testing-mystuff of linux-trace repository
(git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git)

Jean-Jacques Hiblot (1):
  arm: ftrace: Adds support for ftrace operations

 arch/arm/Kconfig               |  2 ++
 arch/arm/include/asm/ftrace.h  |  3 ++
 arch/arm/kernel/entry-common.S | 68 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/kernel/ftrace.c       | 34 +++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)

-- 
2.1.3
