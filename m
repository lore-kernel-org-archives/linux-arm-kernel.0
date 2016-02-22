From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Feb 2016 19:08:32 +0900
Subject: next-20160222 build: 5 failures 9 warnings (next-20160222)
In-Reply-To: <E1aXlz4-000486-Pb@optimist>
References: <E1aXlz4-000486-Pb@optimist>
Message-ID: <20160222100832.GX18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 08:36:46AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build on arm64 due to:

> 	arm64-allnoconfig
> ../arch/arm64/include/asm/kvm_host.h:338:2: error: implicit declaration of function 'kvm_call_hyp' [-Werror=implicit-function-declaration]
> 
> 	arm64-allmodconfig
> ../arch/arm64/include/asm/kvm_host.h:338:2: error: implicit declaration of function 'kvm_call_hyp' [-Werror=implicit-function-declaration]

> 	arm64-defconfig
> ../arch/arm64/include/asm/kvm_host.h:338:2: error: implicit declaration of function 'kvm_call_hyp' [-Werror=implicit-function-declaration]

triggered by the merge of the kvm-arm tree with -next today, it looks
like changes in that tree and arm64 aren't playing nicely with each
other (bisect came down to the merge and visual inspection of the
changes didn't immediately show anything else though the issue is
obvious in the code).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/c72925ef/attachment.sig>
