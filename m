From: broonie@kernel.org (Mark Brown)
Date: Fri, 8 Aug 2014 15:32:27 +0100
Subject: master build: 1 failures 16 warnings (v3.16-8695-ga7d7a14)
In-Reply-To: <E1XFj9r-0003ZJ-40@cassiel.sirena.org.uk>
References: <E1XFj9r-0003ZJ-40@cassiel.sirena.org.uk>
Message-ID: <20140808143227.GR17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 01:20:31PM +0100, Build bot for Mark Brown wrote:

> Failed defconfigs:
> 	arm64-allmodconfig
#
> Errors:

> 	arm64-allmodconfig
> ../arch/arm64/xen/../../arm/xen/grant-table.c:53:5: error: conflicting types for 'arch_gnttab_init'

This build failure which was present in -next has now appeared in Linus'
tree too.  It appears to be the result of a mismerge, we have two
definitions of the function, one from b7dd0e350e0bd (x86/xen: safely map
and unmap grant frames when in atomic context) with the old signature
and one from 438b33c7145ca8a5131 (xen/grant-table: remove support for V2
tables).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140808/97b646b2/attachment.sig>
