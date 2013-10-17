From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 17 Oct 2013 22:18:06 +0800
Subject: [RFC/query] ARM: enable AUTO_ZRELADDR at 16MB aligned of RAM ?
Message-ID: <20131017221806.514ca45a@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I need your help about where the 128MB limitation of AUTO_ZRELADDR comes from? IOW,
why 
                mov     r4, pc
                and     r4, r4, #0xf8000000

rather than
                mov     r4, pc
                and     r4, r4, #0xff000000


Can we make the following change to arch/arm/boot/compressed/head.S?

 		@ determine final kernel image address
 		mov	r4, pc
-		and	r4, r4, #0xf8000000
+		and	r4, r4, #0xff000000
 		add	r4, r4, #TEXT_OFFSET
 #else
 		ldr	r4, =zreladdr


Thanks in advance,
Jisheng
