From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Jan 2016 12:18:36 +0000
Subject: next-20160128 build: 4 failures 9 warnings (next-20160128)
In-Reply-To: <E1aOjcQ-0007JT-Fl@optimist>
References: <E1aOjcQ-0007JT-Fl@optimist>
Message-ID: <20160128121836.GD6078@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 10:16:02AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build at all on arm64 due to lots and lots of:

> ../arch/arm64/include/asm/page.h:64:28: error: 'READ_IMPLIES_EXEC' undeclared (first use in this function)

which looks to be due to the removal of an implicit inclusion, probably
triggered by the cleanups from "mm: warn about VmData over RLIMIT_DATA"
but I didn't investigate properly since I already identified a fairly
obvious fix.  Patch incoming.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/33ed1124/attachment.sig>
