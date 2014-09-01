From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Sep 2014 10:34:28 +0100
Subject: [PATCH v2] arm64: fix bug for reloading FPSIMD state after cpu
 power off
In-Reply-To: <1409540991-7573-1-git-send-email-leoy@marvell.com>
References: <1409540991-7573-1-git-send-email-leoy@marvell.com>
Message-ID: <20140901093427.GC608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 04:09:51AM +0100, Leo Yan wrote:
> Now arm64 defers reloading FPSIMD state, but this optimization also
> introduces the bug after cpu resume back from low power mode.
> 
> The reason is after the cpu has been powered off, s/w need set the
> cpu's fpsimd_last_state to NULL so that it will force to reload
> FPSIMD state for the thread, otherwise there has the chance to meet
> the condition for both the task's fpsimd_state.cpu field contains the
> id of the current cpu, and the cpu's fpsimd_last_state per-cpu variable
> points to the task's fpsimd_state, so finally kernel will skip to reload
> the context during it return back to userland.
> 
> Signed-off-by: Leo Yan <leoy@marvell.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(and cc'ing Will to pick it up since he's handling the 3.17 release)

Thanks.
