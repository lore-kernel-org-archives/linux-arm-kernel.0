From: rabin@rab.in (Rabin Vincent)
Date: Sun, 2 Jan 2011 10:08:11 +0530
Subject: [PATCH] mmci: call flush_dcache_page() outside of atomic kmap
In-Reply-To: <20110101221309.GA2653@n2100.arm.linux.org.uk>
References: <1293878168-12741-1-git-send-email-rabin@rab.in>
	<20110101120539.GA25924@n2100.arm.linux.org.uk>
	<AANLkTimhoS6iNVH-GMWJkyaLYarBapD3eL-OXVS58Xm-@mail.gmail.com>
	<20110101221309.GA2653@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikr6DFqq44aYuur_p5mJ0r3=d93ATBp=z71Aayz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 2, 2011 at 3:43 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Err, hang on. ?The sg iter API uses flush_kernel_dcache_page(), not
> flush_dcache_page(). ?flush_kernel_dcache_page() is not expected to
> touch userspace mappings.

This email thread was never about the flush_kernel_dcache_page() in the
sg_miter API.  It's about the flush_dcache_page() in MMCI.
