From: okuno.kohji@jp.panasonic.com (Kohji Okuno)
Date: Tue, 9 Jan 2018 20:12:21 +0900
Subject: arm: Is VFP hotplug notifiers wrong?
Message-ID: <20180109.201221.1319754994300492102.okuno.kohji@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thomas and all,

Could you please confirm about the following commit, again?

http://git.armlinux.org.uk/cgit/linux-arm.git/commit/arch/arm/vfp/vfpmodule.c?id=e5b61bafe70477e05e1dce0d6ca4ec181e23cb2a


The avobe commit eliminated the following fix, I think.

http://git.armlinux.org.uk/cgit/linux-arm.git/commit/arch/arm/vfp/vfpmodule.c?id=384b38b66947b06999b3e39a596d4f2fb94f77e4


vfp_force_reload() called from vfp_dying_cpu() does not clear
vfp_current_hw_state[cpu], because cpu stopper task does not own the
context held in the VFP hardware.

Best regards,
 Kohji Okuno
