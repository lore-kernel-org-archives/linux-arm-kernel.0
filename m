From: cl@linux.com (Christoph Lameter)
Date: Mon, 2 Nov 2015 10:48:17 -0600 (CST)
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu
 area setup
In-Reply-To: <20151102162236.GB7637@e104818-lin.cambridge.arm.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
 <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
 <20151102162236.GB7637@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.20.1511021047420.28255@east.gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Nov 2015, Catalin Marinas wrote:

> I haven't looked at the patch 3/3 in detail but I'm pretty sure I'll NAK
> the approach (and the definition of PERCPU_ATOM_SIZE), therefore
> rendering this patch unnecessary. IIUC, this is used to enforce some
> alignment of the per-CPU IRQ stack to be able to check whether the
> current stack is process or IRQ on exception entry. But there are other,
> less intrusive ways to achieve the same (e.g. x86).

The percpu allocator allows the specification of alignment requirements.
