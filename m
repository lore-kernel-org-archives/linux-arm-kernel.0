From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Dec 2013 10:41:28 +0000
Subject: [PATCH 3/8] regmap: Add support for using regmap over ssbi
In-Reply-To: <52AA42FD.4040503@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
 <20131210235000.GK11468@sirena.org.uk>
 <52A7AE1B.3040201@codeaurora.org>
 <20131211005106.GL11468@sirena.org.uk>
 <52A7C0C3.2070805@codeaurora.org>
 <20131211132729.GT11468@sirena.org.uk>
 <52AA42FD.4040503@codeaurora.org>
Message-ID: <20131213104128.GT11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:13:01PM -0800, Stephen Boyd wrote:

> > bulk_read() should decay to individual reads if there isn't a block
> > operaton and it's not like the hardware actually supports bulk reads
> > anyway.

> So regmap_bulk_read() should work if I don't have a map->bus? To make it
> work with reg_read/write I had to do this. I'm not sure how to make
> bulk_write work.

Yes, I'd expect the operation to work.  Your changes below are mostly
fine (we should add an additional check for values that aren't integer
numbers of bytes, I can add that) - can you send as a signed off patch
please and I'll apply?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/89b5bcdc/attachment.sig>
