From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Nov 2017 11:18:48 +0000
Subject: next-20171114 build: 4 failures 5 warnings (next-20171114)
In-Reply-To: <E1eEWh8-0005hK-AY@optimist>
References: <E1eEWh8-0005hK-AY@optimist>
Message-ID: <20171114111848.s3os77xlwuf7mxkx@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 08:35:46AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build on arm and arm64 due to:

> 	arm64-allmodconfig
> ../scripts/insert-sys-cert.c:28:18: fatal error: gelf.h: No such file or directory
> 
> 	arm-allmodconfig
> ../scripts/insert-sys-cert.c:28:18: fatal error: gelf.h: No such file or directory

which is due to 2dbfb74badfd3a0178 (KEYS: Add ELF class-independent
certificate insertion support) adding a requirement for libelf rather
suddenly.  I've installed that on the build box but it's a bit
surprising to see this appear after the merge window has opened.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171114/86eb311e/attachment.sig>
