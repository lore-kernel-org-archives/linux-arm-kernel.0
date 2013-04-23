From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 22 Apr 2013 19:05:02 -0700
Subject: [PATCH] KVM: ARM: Fix API documentation for ONE_REG encoding
Message-ID: <1366682702-23947-1-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unless I'm mistaken, the size field was encoded 4 bits off and a wrong
value was used for 64-bit FP registers.

Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 Documentation/virtual/kvm/api.txt |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 976eb65..7145ee9 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1797,22 +1797,22 @@ ARM registers are mapped using the lower 32 bits.  The upper 16 of that
 is the register group type, or coprocessor number:
 
 ARM core registers have the following id bit patterns:
-  0x4002 0000 0010 <index into the kvm_regs struct:16>
+  0x4020 0000 0010 <index into the kvm_regs struct:16>
 
 ARM 32-bit CP15 registers have the following id bit patterns:
-  0x4002 0000 000F <zero:1> <crn:4> <crm:4> <opc1:4> <opc2:3>
+  0x4020 0000 000F <zero:1> <crn:4> <crm:4> <opc1:4> <opc2:3>
 
 ARM 64-bit CP15 registers have the following id bit patterns:
-  0x4003 0000 000F <zero:1> <zero:4> <crm:4> <opc1:4> <zero:3>
+  0x4030 0000 000F <zero:1> <zero:4> <crm:4> <opc1:4> <zero:3>
 
 ARM CCSIDR registers are demultiplexed by CSSELR value:
-  0x4002 0000 0011 00 <csselr:8>
+  0x4020 0000 0011 00 <csselr:8>
 
 ARM 32-bit VFP control registers have the following id bit patterns:
-  0x4002 0000 0012 1 <regno:12>
+  0x4020 0000 0012 1 <regno:12>
 
 ARM 64-bit FP registers have the following id bit patterns:
-  0x4002 0000 0012 0 <regno:12>
+  0x4030 0000 0012 0 <regno:12>
 
 4.69 KVM_GET_ONE_REG
 
-- 
1.7.10.4
