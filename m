From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Jan 2014 18:48:09 +0000
Subject: [PATCH v7 2/7] arm64: introduce interfaces to hotpatch kernel
 and module code
In-Reply-To: <1387725944-810-3-git-send-email-liuj97@gmail.com>
References: <1387725944-810-1-git-send-email-liuj97@gmail.com>
 <1387725944-810-3-git-send-email-liuj97@gmail.com>
Message-ID: <20140106184808.GJ1096@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 22, 2013 at 03:25:38PM +0000, Jiang Liu wrote:
> Introduce three interfaces to patch kernel and module code:
> aarch64_insn_patch_text_nosync():
> 	patch code without synchronization, it's caller's responsibility
> 	to synchronize all CPUs if needed.
> aarch64_insn_patch_text_sync():
> 	patch code and always synchronize with stop_machine()
> aarch64_insn_patch_text():
> 	patch code and synchronize with stop_machine() if needed
> 
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/arm64/include/asm/insn.h |  10 +++-
>  arch/arm64/kernel/insn.c      | 119 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 128 insertions(+), 1 deletion(-)

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks!

Will
