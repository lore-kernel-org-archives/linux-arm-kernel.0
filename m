From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 04 Dec 2009 08:46:28 +0100
Subject: [PATCH 01/20] ARM: S5PC100: use 0x30008000 as memory base
In-Reply-To: <1b68c6790911200642j792834e9q47d605b80c2e36d2@mail.gmail.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258724572-19176-2-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911200642j792834e9q47d605b80c2e36d2@mail.gmail.com>
Message-ID: <004601ca74b5$e5d84920$b188db60$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, November 20, 2009 3:43 PM jassi brar wrote:

> On Fri, Nov 20, 2009 at 10:42 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > We decided to use 0x3000'0000 as base memory address on S5PC1XX SoCs
> > (s5pc100 and s5pc110).
> you might as well want to explain the reason behind it, if any?

We decided to change the base memory address to 0x30000000 to be able to
support systems with 512MB in the second bank (DRAM1) without using HIMEM.
In first bank (DRAM0), which is integrated with SOC (POP) we would always
have no more than 256MB of memory. If we would leave the first bank at
0x2000'0000, we would lose 256MB of kernel virtual address space for
useless memory hole. With this patch (and proper u-boot) we can run kernel
on systems with max 256MB + 512MB of memory in 1GB kernel/3GB userspace
address space configuration.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
