From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 28 Aug 2013 12:01:22 +0200
Subject: [PATCH v4 2/4] ARM: Add atomic_io_modify optimized routines
In-Reply-To: <20130828094907.GB2343@localhost>
References: <1377358532-23802-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377358532-23802-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130828085340.GB58219@MacBook-Pro.local>
 <20130828094907.GB2343@localhost>
Message-ID: <20130828120122.487e6ed6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 28 Aug 2013 06:49:08 -0300, Ezequiel Garcia wrote:

> > Is this any different from the generic one introduced in patch 1/4? I
> > would rather just use the generic definition.
> 
> Well, according to Will Deacon (and as documented in the commit log)
> we can optimize in ARM by using readl_relaxed instead of readl.
> 
> Now, I'm sure you now better than me if that results (or not) in any
> significant optimization.
> 
> > Similarly, a generic
> > atomic_io_modify_relaxed() but guarded with something like
> > __HAVE_ARCH_RELAXED_IO.
> > 
> 
> No, that's not possible. As far as I understand, there's no guarantee
> of _relaxed variants to be available architecture-wide.

I think what Catalin was suggesting is that atomic_io_modify() should
use readl() and writel() (i.e *not* the relaxed variants), and that a
separate atomic_io_modify_relaxed() could be added on architectures
that define __HAVE_ARCH_RELAXED_IO.

I think you misread Catalin's comment when you say there's no guarantee
of _relaxed variants to be available architecture-wide, since Catalin
precisely suggested to guard that with __HAVE_ARCH_RELAXED_IO, which
indicates that _relaxed variants are available.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
