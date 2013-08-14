From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 14 Aug 2013 00:08:53 -0700
Subject: [PATCH v2 0/1] ARM: signal: sigreturn_codes should be endian neutral
 to work in BE8
Message-ID: <1376464134-23029-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is second version of patch that fixes rt_sig* ltp failures
in case of big endian V7 kernel. It make sigreturn_codes snippets
endian neutral. In this version of the patch problem is fixed by
using separate .S file with snippets written with regular asm
mnemonic. With such change compiler/linker take care of all needed
byteswaps in case of BE8 mode.

This approach was suggested on the following thread:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191543.html

Changes were tested on V7 in both BE and LE modes

Changes from v1:
  Use separate .S file rather than <asm/opcodes.h> instruction
  byteswaping macros

Victor Kamensky (1):
  ARM: signal: sigreturn_codes should be endian neutral to work in BE8

 arch/arm/kernel/Makefile          |  3 +-
 arch/arm/kernel/signal.c          | 29 +++---------------
 arch/arm/kernel/sigreturn_codes.S | 64 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/kernel/sigreturn_codes.S

-- 
1.8.1.4
