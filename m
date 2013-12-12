From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Dec 2013 11:55:55 +0000
Subject: ARM64: Domain Equivalent support in ARMv8
In-Reply-To: <CAFpQJXVsuT2XU4F9FmQbqYm-82Qbs-yVCD+N+Qc7eY-z-h1NJQ@mail.gmail.com>
References: <CAFpQJXXpO7NmtHJoU0uHYQ_BPQqS+qn3ZgZcQkckWDv1ZjBtTQ@mail.gmail.com>
 <CAFpQJXVsuT2XU4F9FmQbqYm-82Qbs-yVCD+N+Qc7eY-z-h1NJQ@mail.gmail.com>
Message-ID: <20131212115555.GA3382@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 07:48:19AM +0000, Ganapat Rao P Kulkarni wrote:
> On Tue, Dec 10, 2013 at 1:17 PM, Ganapat Rao P Kulkarni
> <gpkulkarni@gmail.com> wrote:
> > I want to make kernel code ( all sections/blocks mapped to kernel
> > code) as RO and change to R/W,  when ever hot-patch of kernel code is
> > required.
> > Also, R/W access changes should be available/visible to the core which
> > sets R/W and all other cores continue to have RO access.
> >
> > This was easily done using Domain feature(by making Kernel Domain as
> > Manager, using DACR) on ARMv7.
> > However, on ARMv8, i see there is no domain support(in AARCH64) and
> > not able to find the alternative optimal way.

Note that even on ARMv7, if you use LPAE domains are no longer
available.

So I'm not aware of any way other than creating a temporary mapping in a
per-CPU pgd. You could use a low address and TTBR0 so that it doesn't
interfere with the real kernel mapping.

-- 
Catalin
