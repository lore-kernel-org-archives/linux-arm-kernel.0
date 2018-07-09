From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 9 Jul 2018 11:40:41 +0100
Subject: [PATCH] arm64: neon: Add preemption protection for
 kernel_neon_busy
In-Reply-To: <1531125935-19999-1-git-send-email-yandong77520@gmail.com>
References: <1531125935-19999-1-git-send-email-yandong77520@gmail.com>
Message-ID: <20180709104041.GC9486@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 04:45:35PM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> may_use_simd() can be called in any case and access kernel_neon_busy,
> for example: BUG_ON(!may_use_simd()).  This patch ensures that
> migration will not occur during program access to kernel_neon_busy.
> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>

(Duplicate patch, see [1] for discussion.)

[...]

Cheers
---Dave

[1] [PATCH] arm64: neon: Do not access kernel_neon_busy with preemption enabled                                       http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/589259.html
