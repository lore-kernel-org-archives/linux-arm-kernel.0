From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Oct 2015 19:02:15 +0100
Subject: [PATCH v3] arm64: Synchronise dump_backtrace() with perf callchain
In-Reply-To: <1445092091-12373-1-git-send-email-jungseoklee85@gmail.com>
References: <1445092091-12373-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20151019180214.GH11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 02:28:11PM +0000, Jungseok Lee wrote:
> Note that this patch does not cover a case where MMU is disabled. The
> last stack frame of swapper, for example, has PC in a form of physical
> address. Unfortunately, a simple conversion using phys_to_virt() cannot
> cover all scenarios since PC is retrieved from LR - 4, not LR. It is
> a big tradeoff to change both head.S and unwind_frame() for only a few
> of symbols in *.S. Thus, this hunk does not take care of the case.

That's fine, I think we can cope with a physical address as the last
entry in the trace.

Patch queued for 4.4. Thanks.

-- 
Catalin
