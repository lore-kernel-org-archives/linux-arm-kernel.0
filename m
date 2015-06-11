From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Jun 2015 17:08:56 +0100
Subject: [PATCH] arm64: fix bug for reloading FPSIMD state after CPU
 hotplug.
In-Reply-To: <1433995365-6043-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1433995365-6043-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20150611160856.GC29305@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 12:02:45PM +0800, Chunyan Zhang wrote:
> From: Janet Liu <janet.liu@spreadtrum.com>
> 
> Now FPSIMD don't handle HOTPLUG_CPU. This introduces bug after cpu down/up process.
> 
> After cpu down/up process, the FPSMID hardware register is default value, not any
> process's fpsimd context. when CPU_DEAD set cpu's fpsimd_state to NULL, it will force
> to load the fpsimd context for the thread, to avoid the chance to skip to load the context.
> If process A is the last user process on CPU N before cpu down, and the first user process
> on the same CPU N after cpu up, A's fpsimd_state.cpu is the current cpu id,
> and per_cpu(fpsimd_last_state) points A's fpsimd_state, so kernel will not reload the
> context during it return to user space.
> 
> Signed-off-by: Janet Liu <janet.liu@spreadtrum.com>
> Signed-off-by: Xiongshan An <xiongshan.an@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

Applied. Thanks.

-- 
Catalin
