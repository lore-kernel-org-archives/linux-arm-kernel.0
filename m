From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Aug 2010 18:18:37 +0100
Subject: [PATCH] arm: remove backtrace.s when ARM_UNWIND enable
In-Reply-To: <20100811160810.GA6792@localhost.localdomain>
References: <20100811160810.GA6792@localhost.localdomain>
Message-ID: <1281547117.30665.39.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-08-11 at 17:08 +0100, janboe wrote:
> backtrace.s can only work with FRAME_POINTER, so disable when
> ARM_UNWIND enabled
> 
> Signed-off-by: janboe <janboe.ye@gmail.com>
[...]
> +ifneq ($(CONFIG_ARM_UNWIND),y)
> +  lib-y        += backtrace.o
> +endif

Could we use CONFIG_FRAME_POINTER (and negate the conditions in your
patch)? The above would be:

lib-$(CONFIG_FRAME_POINTER) += backtrace.o

-- 
Catalin
