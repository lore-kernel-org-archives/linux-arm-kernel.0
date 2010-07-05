From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  5 Jul 2010 16:15:19 +0200
Subject: [PATCH 01/11] ARM: zImage: don't hard code the stack size twice
In-Reply-To: <20100705141344.GA25407@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
Message-ID: <1278339329-23739-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Eric Miao <eric.miao@canonical.com>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index c5191b1..390aa92 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -315,7 +315,7 @@ LC0:		.word	LC0			@ r1
 		.word	_image_size		@ r6
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
-		.word	user_stack+4096		@ sp
+		.word	user_stack_end		@ sp
 LC1:		.word	reloc_end - reloc_start
 		.size	LC0, . - LC0
 
@@ -1070,3 +1070,4 @@ reloc_end:
 		.align
 		.section ".stack", "w"
 user_stack:	.space	4096
+user_stack_end:
-- 
1.7.1
