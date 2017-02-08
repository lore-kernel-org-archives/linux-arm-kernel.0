From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Feb 2017 17:22:50 +0000
Subject: next-20170208 build: 1 failures 16 warnings (next-20170208)
In-Reply-To: <E1cbPtA-00012m-9J@optimist>
References: <E1cbPtA-00012m-9J@optimist>
Message-ID: <20170208172250.rnqxq7g77ekuo2pv@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 10:54:16AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig due to:

>       arm64-allmodconfig
> ../arch/arm64/kernel/armv8_deprecated.c:359:31: error: expected '=',
> ',', ';',
+'asm' or '__attribute__' before 'aarch32_check_condition'
> ../arch/arm64/kernel/armv8_deprecated.c:386:10: error: implicit
> declaration of
+function 'aarch32_check_condition'
[-Werror=implicit-function-declaration]

triggered by 1930faf201e83f6 (kprobes: move kprobe declarations to
asm-generic/kprobes.h) according to a bisect, though I didn't
immediately see how.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/2fd25d1f/attachment-0001.sig>
