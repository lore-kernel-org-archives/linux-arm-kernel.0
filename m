From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 9 Jul 2018 11:40:27 +0100
Subject: [PATCH] arm64: neon: This is a bug
In-Reply-To: <1531023561-24195-1-git-send-email-yandong77520@gmail.com>
References: <1531023561-24195-1-git-send-email-yandong77520@gmail.com>
Message-ID: <20180709104027.GB9486@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 08, 2018 at 12:19:21PM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> Dear, Dave.Martin
> 
> This is a bug that calls may_use_busy() when preemption is enabled.
> 
> We encountered a ?sysdump? problem on Kernel 4.14 code, calling
> may_use_simd() in the function kernel_neon_begin() return null.
> Our analysis concludes that the thread is migrating while executing
> raw_cpu_read(kernel_neon_busy).
> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>

(Duplicate patch, see [1] for discussion.)

[...]

Cheers
---Dave

[1] [PATCH] arm64: neon: Do not access kernel_neon_busy with preemption enabled
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/589259.html
