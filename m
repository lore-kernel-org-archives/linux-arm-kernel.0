From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 24 Apr 2013 18:58:24 +0800
Subject: [PATCH v3] arm64: compiling issue, need add include/asm/vga.h file
In-Reply-To: <20130424102327.GF21850@mudshark.cambridge.arm.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
 <5177B1F0.10106@asianux.com>
 <20130424102327.GF21850@mudshark.cambridge.arm.com>
Message-ID: <5177BAD0.9000500@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


For compiling with allmodconfig, need vga.h file, so generate it which
just only include the asm-generic one.

It is firstly used by drivers/gpu/drm/drm_irq.c.

The related error:
include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/include/asm/Kbuild |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index a13a4a4..79a642d 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -48,4 +48,5 @@ generic-y += trace_clock.h
 generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
+generic-y += vga.h
 generic-y += xor.h
-- 
1.7.7.6
