From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 10 Feb 2014 12:19:48 -0800
Subject: [PATCH v2] ARM: asm: rename logical shift macros push pull into
 lspush lspull
Message-ID: <1392063589-24111-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

This patch renames 'push' and 'pull' logical shift macros in arm 
assembler.h, so it could be included into .S file that use 'push' 
as instruction. That was discussed on [1]. Will Deacon suggested
the idea of the patch.

As far as code change concerned - the change is really only macros
rename and change in all places where macros are used. Even if diff
may seem big it is very simple change.

Changes from previous version:
   - Now instead of changing kvm .S files that use push instruction
   patch rename push and pull
   - This patch is submitted separately from ARM V7 BE KVM series

Testing:
   - Was tested on rmk/for-next branch. TC2 LE and BE images were built
   and run
   - Verified build of all 118 images under arch/arm/configs and 
   with objdump dump verified that images text segment do not change
   compared with base line (modulo buildid (disabled), some initramfs
   addresses)

Will, I added your name under 'Suggested-by:', please let me know if
you object to this.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/227318.html

Victor Kamensky (1):
  ARM: asm: rename logical shift macros push pull into lspush lspull

 arch/arm/include/asm/assembler.h      |   8 +-
 arch/arm/lib/copy_template.S          |  36 +++----
 arch/arm/lib/csumpartialcopygeneric.S |  96 ++++++++---------
 arch/arm/lib/io-readsl.S              |  12 +--
 arch/arm/lib/io-writesl.S             |  12 +--
 arch/arm/lib/memmove.S                |  36 +++----
 arch/arm/lib/uaccess.S                | 192 +++++++++++++++++-----------------
 7 files changed, 196 insertions(+), 196 deletions(-)

-- 
1.8.1.4
