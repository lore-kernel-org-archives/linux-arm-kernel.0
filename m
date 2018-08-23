From: kedare06@gmail.com (Kedareswararao Appana)
Date: Thu, 23 Aug 2018 20:20:36 +0530
Subject: Query on dma_set_mask_and_coherent() Usage
Message-ID: <CANdmM3O_q_dAzVAd5Lk+u_OHqgEkHR2p1ucgEZ5v_tLQ6G+3Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

              On arm64 platform I have booted Linux only with > 32-bit
Address i.e from 0x800000000 (reg =  <0x8 0x00000000 0x0 0x80000000>)

In my driver, I am using dma_set_mask_and_coherent(&pdev->dev,
DMA_BIT_MASK(32)); which should fail if I boot Linux
with the above configuration but the API is returning success.

I have debugged it further and observed that, in the arm64
dma-mapping.c swiotlb is zero resulting dma_supported ops always
returning 1

https://elixir.bootlin.com/linux/v4.17.8/source/arch/arm64/mm/dma-mapping.c#L321

 I will be grateful if someone can send me some pointers for fixing this issue

Regards,
Kedar.
