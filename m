From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Thu, 3 Dec 2015 12:36:50 +0100
Subject: [PATCH v6 05/19] arm64:uapi: set __BITS_PER_LONG correctly for
 ILP32 and LP64
In-Reply-To: <20151203113157.GI10747@e104818-lin.cambridge.arm.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-6-git-send-email-ynorov@caviumnetworks.com>
 <20151203113157.GI10747@e104818-lin.cambridge.arm.com>
Message-ID: <20345DE6-4D42-46E3-BA5F-58FB9741F78A@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

> Quick question: IIRC, earlier aarch64 gcc versions did not generate
> __ILP32__ when -mabi=ilp32, they only removed __LP64__. When did the
> change happen? Could we assume that all compiler versions used to
> generate ILP32 would define this?

The __ILP32__ define has been supported since 
> commit b01b37f5768911598640cf8a8c82beacb4200c13
> Author: yufeng <yufeng@138bc75d-0d04-0410-961f-82ee72b054a4>
> Date:   Tue Jul 23 12:26:33 2013 +0000
> 
>     [AArch64, ILP32] 4/6 Define _ILP32 and __ILP32__.
>     
>     gcc/
>     
>         * config/aarch64/aarch64.h (TARGET_CPU_CPP_BUILTINS): Define _ILP32
>         and __ILP32__ when the ILP32 model is in use.
>     
>     
>     git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk at 201167 138bc75d-0d04-0410-961f-82ee72b054a4

Best regards,
Philipp.
