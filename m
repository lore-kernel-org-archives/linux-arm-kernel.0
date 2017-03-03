From: monstr@monstr.eu (Michal Simek)
Date: Fri, 3 Mar 2017 13:09:51 +0100
Subject: PSCI reset support - specification
Message-ID: <c460a695-1ed3-8926-68c6-09bafb582064@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have read psci 1.0 specification available here.
http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf

I have looked at SYSTEM_RESET where only the first parameter is setup
which is Function ID (0x8400 0009) and the rest of parameters are not
setup.

In Linux kernel we have psci_sys_reset

static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
{
	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
}

where others parameters are zeros.
Is this done by purpose that these zeros are there?
Because based on spec these are not used and value is not specified.

For example u-boot is allocating regs on the stack and others parameters
have random values.

Thanks,
Michal
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170303/d9760dc8/attachment.sig>
