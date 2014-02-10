From: monstr@monstr.eu (Michal Simek)
Date: Mon, 10 Feb 2014 13:17:26 +0100
Subject: [GIT PULL] Xilinx Zynq fix for v3.14
Message-ID: <52F8C356.8060209@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please consider to queue this bug fix for v3.14.

Bug was reported here:
https://lkml.org/lkml/2014/1/27/212

I have also discussed this with Rob regarding memreserve DT feature.
Here is thread with Rob:
https://lkml.org/lkml/2014/1/31/105

Moving kernel start is currently enabled by:
"ARM: ignore memory below PHYS_OFFSET"
(sha1: 571b14375019c3a66ef70d4d4a7083f4238aca30)

Thanks,
Michal


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-fixes-for-3.14

for you to fetch changes up to a73cbb758171c34cc3d58f3dfb80feef501a2079:

  ARM: zynq: Reserve not DMAable space in front of the kernel (2014-02-10 13:04:35 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq fixes for v3.14

- Protect DMA buffer allocation below
  kernel start address

----------------------------------------------------------------
Michal Simek (1):
      ARM: zynq: Reserve not DMAable space in front of the kernel

 arch/arm/mach-zynq/common.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/bbac3ae6/attachment.sig>
