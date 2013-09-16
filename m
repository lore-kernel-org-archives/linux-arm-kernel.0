From: alexander.tarasikov@gmail.com (Alexander Tarasikov)
Date: Tue, 17 Sep 2013 02:56:30 +0400
Subject: RFD on DMA_BIT_MASK and LPAE
Message-ID: <CAMChaFyeY9+gQDqHTgHxUC95gUnLstyvpekNdactq=rs76pHiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, linux hackers!

I've tried enabling LPAE (for the purpose of using KVM on A15) and
have found out that many drivers break because of the DMA_BIT_MASK.
I've found some patches and a discussion on the mailing list, but have
not found what the final verdict on the problem was.

What is the proposed solution to fixing the DMA stuff? Currently, I've
hacked the of/platform and all omap drivers to use a 64-bit mask and
that made my board boot, but this will surely break the devices that
are not 64-bit-dma-capable.

Do you think it is a good idea to define a generic initializer macro
like the following (probably not, but my question is whether it is
possible to somehow fix the situation so that we can boot with and
without LPAE without falling into tons of idfeffery)?

+#ifdef CONFIG_ARCH_PHYS_ADDR_T_64BIT
+#define DMA_BIT_MASK_FULL DMA_BIT_MASK(64)
+#else
+#define DMA_BIT_MASK_FULL DMA_BIT_MASK(32)
+#endif

P.S. I am extremely sorry for sending the email separately to rmk and
mailing list, my web client accidentially enabled HTML in mail and it
was not delivered from the first attempt.

-- 
Regards, Alexander
