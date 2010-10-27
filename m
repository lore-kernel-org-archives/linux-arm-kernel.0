From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 27 Oct 2010 16:01:37 +0200
Subject: [RFC] change the dma_unmap_single for arm
Message-ID: <AANLkTimO9m13=nLeYdS0+2Z2K_9MRfzR=VYtCDfV573s@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
      latest versions invalidates the buffer in order to overcome the
speculative prefetch. however, in some cases, specially network, the
data that DMAed can be much less that the buffer size, so it would be
more efficient - and correct for arm case - to use the received bytes
count rather than the buffer size. however, the linux API restricts
the size to be the same as the one passed to the dma_map_single -
which is the buffer size.
    the simplest solution that I can think of is to change the API
restriction, and make the drivers pass the received bytes count
instead of buffer size, the kernel also will provide a function to the
drivers  to permit using this hack.

saeed
