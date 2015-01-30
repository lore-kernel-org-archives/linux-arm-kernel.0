From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 30 Jan 2015 07:13:10 +0100
Subject: [PATCH v2 12/15] spi/xilinx: Remove iowrite/ioread wrappers
In-Reply-To: <1422447834-23116-13-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422447834-23116-13-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <CAPybu_24k6v3GJG9G2adYL08X-Uv-S4CYs3Kit0k=9emDCcuUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark

This patch has caused a lot of issues on linux-next :S, sorry.

The root of the issue is that iowrite/ioread behaves differently in
different arches.

1) It does not necesary need to be a symbol in all the arches. It can
be declared as a function macro:

#define iowrite32(a,b) iowrite32(a,b)

2) Sometimes, even the function has a different prototype.

 include/asm-generic/iomap.h
 extern unsigned int ioread16be(void __iomem *);

 include/asm-generic/io.h
 extern unsigned int ioread16be(void __iomem *);

Until this is fixed, please revert this patch.

Sorry for the mess.

-- 
Ricardo Ribalda
