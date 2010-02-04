From: imre.deak@nokia.com (Imre Deak)
Date: Thu, 4 Feb 2010 23:37:12 +0200
Subject: [RFC PATCH v2 0/2] ARM: VFP: Save / restore VFP state on the
	signal handler path
In-Reply-To: <1242744292-23776-1-git-send-email-imre.deak@nokia.com>
References: <1242744292-23776-1-git-send-email-imre.deak@nokia.com>
Message-ID: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a VFP corruption problem in a process's main thread, when
both the main thread and a signal handler triggered for the process
uses floating point ops.

Changes since v1:
- save / restore VFP exception registers as well, to support user
  space exception handling/VFP emulation.
- extend the existing ptrace VFP struct with the exception regs,
  so that the VFP frame is equivalent for the ptrace and signal
  handler case.

--Imre
