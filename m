From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Apr 2016 11:44:28 +0100
Subject: [PATCH v8 06/13] arm64: kernel: Rework finisher callback out of
 __cpu_suspend_enter()
In-Reply-To: <1461604250-12789-7-git-send-email-james.morse@arm.com>
References: <1461604250-12789-1-git-send-email-james.morse@arm.com>
 <1461604250-12789-7-git-send-email-james.morse@arm.com>
Message-ID: <20160426104427.GC8525@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 06:10:43PM +0100, James Morse wrote:
> Hibernate could make use of the cpu_suspend() code to save/restore cpu
> state, however it needs to be able to return '0' from the 'finisher'.
> 
> Rework cpu_suspend() so that the finisher is called from C code,
> independently from the save/restore of cpu state. Space to save the context
> in is allocated in the caller's stack frame, and passed into
> __cpu_suspend_enter().
> 
> Hibernate's use of this API will look like a copy of the cpu_suspend()
> function.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

With the push/pop macros gone:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
