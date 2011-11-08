From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Nov 2011 22:36:18 +0000
Subject: [PATCH] ARM: mm: update CONTEXTIDR register to contain PID of
 current process
In-Reply-To: <1320764414-12599-1-git-send-email-will.deacon@arm.com>
References: <1320764414-12599-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk7g+c8UGRaLo-dgkHo6zin0nF+O49QMku7RF2EWJDeF7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2011 15:00, Will Deacon <will.deacon@arm.com> wrote:
> This patch introduces a new Kconfig option which, when enabled, causes
> the kernel to write the PID of the current task into the PROCID field
> of the CONTEXTIDR on context switch. This is useful when analysing
> hardware trace, since writes to this register can be configured to emit
> an event into the trace stream.
>
> The thread notifier for writing the PID is deliberately kept separate
> from the ASID code, so that we can easily support newer processors (A15
> onwards) which store the ASID in TTBR0. As such, the switch_mm code is
> updated to perform a read-modify-write sequence to ensure that we don't
> clobber the PID on older CPUs.
>
> Cc: Wolfgang Betz <wolfgang.betz@st.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Looks fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
