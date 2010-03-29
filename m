From: imre.deak@nokia.com (imre.deak at nokia.com)
Date: Mon, 29 Mar 2010 19:17:37 +0300
Subject: [RFC PATCH v3 0/3] ARM: VFP: Save / restore VFP state on the signal
	handler path
In-Reply-To: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
Message-ID: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a VFP corruption problem in a process's main thread, when
both the main thread and a signal handler triggered for the process
uses floating point ops.

Changes since v2 according to Russell's comments and patches:
- refactor vfp_sync_state to make it clearer
- break vfp_sync_state into vfp_{save/restore}_hwstate for efficiency
- Keep the additional VFP exception registers in a separate struct. This
  way we'll keep the existing ABI intact.

--Imre
