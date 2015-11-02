From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Nov 2015 16:22:37 +0000
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu
 area setup
In-Reply-To: <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
 <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
Message-ID: <20151102162236.GB7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 10:10:23AM -0600, Christoph Lameter wrote:
> On Sun, 1 Nov 2015, Jungseok Lee wrote:
> 
> > There is no room to adjust 'atom_size' now when a generic percpu area
> > is used. It would be redundant to write down an architecture-specific
> > setup_per_cpu_areas() in order to only change the 'atom_size'. Thus,
> > this patch adds a new definition, PERCPU_ATOM_SIZE, which is PAGE_SIZE
> > by default. The value could be updated if needed by architecture.
> 
> What is atom_size? Why would you want a difference allocation size here?
> The percpu area is virtually mapped regardless. So you will have
> contiguous addresses even without atom_size.

I haven't looked at the patch 3/3 in detail but I'm pretty sure I'll NAK
the approach (and the definition of PERCPU_ATOM_SIZE), therefore
rendering this patch unnecessary. IIUC, this is used to enforce some
alignment of the per-CPU IRQ stack to be able to check whether the
current stack is process or IRQ on exception entry. But there are other,
less intrusive ways to achieve the same (e.g. x86).

-- 
Catalin
