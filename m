From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Apr 2017 14:13:22 +0100
Subject: next-20170410 build: 2 failures 3 warnings (next-20170410)
In-Reply-To: <E1cxXQe-0006cv-TG@optimist>
References: <E1cxXQe-0006cv-TG@optimist>
Message-ID: <20170410131322.iriugmcym4zbqceg@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 12:24:17PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../mm/hmm.c:816:2: error: implicit declaration of function 'arch_remove_memory' [-Werror=implicit-function-declaration]

due to the recently added HMM support.  There's no such function for
arm64 but HMM is unconditionally available for all 64 bit architectures
with a MMU.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170410/e482b49b/attachment.sig>
