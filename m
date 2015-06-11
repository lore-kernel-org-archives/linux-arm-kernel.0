From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Jun 2015 15:40:43 +0100
Subject: [PATCH] arm64: kernel thread don't need to save fpsimd context.
In-Reply-To: <1433995472-6170-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1433995472-6170-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20150611144042.GB29305@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 12:04:32PM +0800, Chunyan Zhang wrote:
> From: Janet Liu <janet.liu@spreadtrum.com>
> 
> kernel thread's default fpsimd state is zero. When fork a thread, if parent is kernel thread,
>  and save hardware context to parent's fpsimd state, but this hardware context is user
> process's context, because kernel thread don't use fpsimd, it will not introduce issue,
> it add a little cost.
> 
> Signed-off-by: Janet Liu <janet.liu@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

Applied. Thanks.

-- 
Catalin
