From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon, 10 Nov 2014 09:56:16 +0100
Subject: [PATCH v2 00/01] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20141107115225.72bc6cbf@gandalf.local.home>
References: <20141107115225.72bc6cbf@gandalf.local.home>
Message-ID: <1415609777-18525-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for ftrace operations on the ARM architecture.
This support is needed by kgraft and possibly other ftrace-based tools.
My goal is to have kgraft working on ARM and aarch64.

I tested this patch with a toy implementation of kgraft for ARM and basic
usage of function and function_graph tracers
It doesn't show any problem with the ftrace selftests and the tests found
today in branch ftrace/testing-mystuff of linux-trace repository
(git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git)


change since v1:
 - changed the title and the commit log of the patch to make it more
   understandable

Jean-Jacques Hiblot (1):
  arm: ftrace: Adds support for CONFIG_DYNAMIC_FTRACE_WITH_REGS

 arch/arm/Kconfig               |  2 ++
 arch/arm/include/asm/ftrace.h  |  3 ++
 arch/arm/kernel/entry-common.S | 68 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/kernel/ftrace.c       | 34 +++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)

-- 
2.1.3
