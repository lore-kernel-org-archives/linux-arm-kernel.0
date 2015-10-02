From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Oct 2015 13:42:41 +0100
Subject: [PATCH] arm64: ftrace: fix function_graph tracer panic
In-Reply-To: <560E38C0.7080409@linaro.org>
References: <1443581395-30088-1-git-send-email-huawei.libin@huawei.com>
 <560CCE91.3020407@linaro.org>
 <20151001152739.GI6963@e104818-lin.cambridge.arm.com>
 <560E38C0.7080409@linaro.org>
Message-ID: <20151002124240.GK6963@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 04:56:48PM +0900, AKASHI Takahiro wrote:
> >>On 09/30/2015 11:49 AM, Li Bin wrote:
> >>>This is because when using function graph tracer, if the traced
> >>>function return value is in multi regs ([0x-07]), return_to_handler
> 
> typo: 0x-07 => x0-x7

I fixed this up.

> and pre/post-indexed addressing stp&ldp may save add&sub instructions, but
> it's a matter of preference.

Doing it this way is more efficient in general as it avoids updating the
sp and writing in reverse order. That's the reason we recently changed
the kernel_entry/exit macros (see commit 63648dd20fa0 "arm64: entry:
use ldp/stp instead of push/pop when saving/restoring regs").

Thanks.

-- 
Catalin
