From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Feb 2017 11:21:13 +0000
Subject: next-20170217 build: 2 failures 7 warnings (next-20170217)
In-Reply-To: <E1ceeuE-0004r2-HY@optimist>
References: <E1ceeuE-0004r2-HY@optimist>
Message-ID: <20170217112113.mlkmgogbqg6nzd24@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 09:32:46AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build at least arm and arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../kernel/sched/core.c:198:25: error: 'paravirt_steal_rq_enabled' undeclared (first use in this function)
> ../kernel/sched/core.c:199:11: error: implicit declaration of function 'paravirt_steal_clock' [-Werror=implicit-function-declaration]
> 
> 	arm-allmodconfig
> ../kernel/sched/core.c:198:25: error: 'paravirt_steal_rq_enabled' undeclared (first use in this function)
> ../kernel/sched/core.c:199:11: error: implicit declaration of function 'paravirt_steal_clock' [-Werror=implicit-function-declaration]

due to 004172bdad64432 (sched/core: Remove unnecessary #include
headers).  asm/paravirt.h was one of the removed headers, it must be
included implicitly on x86 but clearly isn't on at least the two ARM
architectures and definitions from it are used directly.  I've sent a
patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170217/00e1d64c/attachment.sig>
