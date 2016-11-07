From: eric@anholt.net (Eric Anholt)
Date: Mon, 07 Nov 2016 08:29:24 -0800
Subject: [PATCH v2] staging: vc04_services: add vchiq_pagelist_info
 structure
In-Reply-To: <20161107140603.14125-1-mzoran@crowfest.net>
References: <20161107140603.14125-1-mzoran@crowfest.net>
Message-ID: <8760nzz21n.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Zoran <mzoran@crowfest.net> writes:

> The current dma_map_sg based implementation for bulk messages
> computes many offsets into a single allocation multiple times in
> both the create and free code paths.  This is inefficient,
> error prone and in fact still has a few lingering issues
> with arm64.
>
> This change replaces a small portion of that inplementation with
> new code that uses a new struct vchiq_pagelist_info to store the
> needed information rather then complex offset calculations.
>
> This improved implementation should be more efficient and easier
> to understand and maintain.
>
> Tests Run(Both Pass):
> vchiq_test -p 1
> vchiq_test -f 10

Looks good, and it's a nice cleanup.  Thanks!

Reviewed-by: Eric Anholt <eric@anholt.net>

I had one style note, which was that you're using an int and 0/1 for a
boolean value, but we like to use proper bools and true/false instead.
However, you're modifying code that was already using an int for related
booleans, so that can be a separate cleanup.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/cd4b1063/attachment.sig>
