From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Apr 2014 10:43:53 +0100
Subject: [PATCH 3/3] arm64: enable context tracking
In-Reply-To: <1398627854-9617-4-git-send-email-larry.bassel@linaro.org>
References: <1398627854-9617-1-git-send-email-larry.bassel@linaro.org>
 <1398627854-9617-4-git-send-email-larry.bassel@linaro.org>
Message-ID: <20140429094353.GD17007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 08:44:14PM +0100, Larry Bassel wrote:
> Make calls to ct_user_enter when the kernel is exited
> and ct_user_exit when the kernel is entered (in el0_da,
> el0_ia, el0_svc, el0_irq).
> 
> These macros expand to function calls which will only work
> properly if el0_sync and related code has been rearranged
> (in a previous patch of this series).
> 
> The calls to ct_user_exit are made after hw debugging has been
> enabled (enable_dbg).
> 
> The call to ct_user_enter is made at the end of the kernel_exit
> macro.
> 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Larry Bassel <larry.bassel@linaro.org>

You could actually merge this patch with 2/3.

-- 
Catalin
