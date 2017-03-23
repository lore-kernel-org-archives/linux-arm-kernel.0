From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Mar 2017 17:02:06 +0000
Subject: [PATCH V13 04/10] arm64: exception: handle Synchronous External
 Abort
In-Reply-To: <1490136425-4324-5-git-send-email-tbaicar@codeaurora.org>
References: <1490136425-4324-1-git-send-email-tbaicar@codeaurora.org>
 <1490136425-4324-5-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170323170206.GA32309@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:46:59PM -0600, Tyler Baicar wrote:
> SEA exceptions are often caused by an uncorrected hardware
> error, and are handled when data abort and instruction abort
> exception classes have specific values for their Fault Status
> Code.
> When SEA occurs, before killing the process, report the error
> in the kernel logs.
> Update fault_info[] with specific SEA faults so that the
> new SEA handler is used.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> CC: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/esr.h |  1 +
>  arch/arm64/mm/fault.c        | 43 +++++++++++++++++++++++++++++++++----------

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
