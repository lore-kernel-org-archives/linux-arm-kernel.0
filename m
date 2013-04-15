From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Apr 2013 16:50:40 +0100
Subject: [RFC v1] regulator: core: introduce regulator chain locking scheme
In-Reply-To: <1366031015-17073-2-git-send-email-grygorii.strashko@ti.com>
References: <1366031015-17073-1-git-send-email-grygorii.strashko@ti.com>
 <1366031015-17073-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20130415155040.GD15837@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 04:03:35PM +0300, Grygorii Strashko wrote:

> To achieve this goal:
> - abstract regulator locking out into helper functions;
> - use the root Regulator (which has no supply defined, like regA) in chain to
>   protect the whole chain;
> - implement regulator chain locking scheme as proposed by Thomas Gleixner for CCF
>   re-entrance in https://lkml.org/lkml/2013/3/27/171 and in the similar way as
>   it is done for CCF by Mike Turquette in https://lkml.org/lkml/2013/3/28/512

Split this into separate refactoring and other change commits - one
change per commit.

> In addition, such locking scheme allows to have access to the supplier
> regulator API from inside child's (consumer) regulator API.

I've still not seen any use case articulated for doing this...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130415/b87dbd6a/attachment.sig>
