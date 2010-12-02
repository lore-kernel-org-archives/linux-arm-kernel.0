From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Thu, 2 Dec 2010 17:39:58 +0100
Subject: Cache maintenance on page table updates
Message-ID: <AANLkTikHpQLh53JN4OhjS2_T9XC=66Lk1MMPh2y1jc3u@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin.

I am hoping you can help me understand the following observed behavior in KVM.

When I update the page table mappings' AP bits, it is for some reason
not enough to clean caches, but I must also invalidate them for the
changes to take effect. The system runs on an arm1136 processor and I
was under the impression that page table walks never read from the L1
cache. If this is true, I cannot understand why an invalidation of
caches would make a difference.

In the course of understanding this behavior I have come across the
RGN, S and C bits in the TTBR0. I don't quite understand how these
bits affect the memory system - should they simply match the way that
the page tables themselves are mapped in virtual memory or do they
somehow control how the page table walk mechanism behaves?

Thanks,
Christoffer
