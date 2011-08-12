From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Aug 2011 10:46:24 -0700
Subject: Relinking zImage when nothing changes
Message-ID: <4E4566F0.4020001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was hoping with the recent patch e78e8f2 (kernel: prevent unnecessary
rebuilding due to config_data.gz, 2011-07-05) compiling ARM linux a
second time would amount to no more linking. This doesn't seem to be the
case though. Doing a make V=2 I see that lib1funcs.S is shipped and thus
we have to recompile it although nothing actually changed. This in turn
requires us to relink the compressed vmlinux and then recreate the zImage.

  Kernel: arch/arm/boot/Image is ready
  SHIPPED arch/arm/boot/compressed/lib1funcs.S - due to missing .cmd file
  AS      arch/arm/boot/compressed/lib1funcs.o - due to: arch/arm/boot/compressed/lib1funcs.S
  LD      arch/arm/boot/compressed/vmlinux - due to: arch/arm/boot/compressed/lib1funcs.o
  OBJCOPY arch/arm/boot/zImage - due to: arch/arm/boot/compressed/vmlinux
  Kernel: arch/arm/boot/zImage is ready


Is there any way to avoid this? Perhaps the shipped command could become
a bit wiser?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
