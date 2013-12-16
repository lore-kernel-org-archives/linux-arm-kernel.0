From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 20:57:11 +0000
Subject: [PATCH] regmap: Allow regmap_bulk_read() to work for "no-bus"
 regmaps
In-Reply-To: <20131213171407.GN21983@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
 <20131210235000.GK11468@sirena.org.uk>
 <52A7AE1B.3040201@codeaurora.org>
 <20131211005106.GL11468@sirena.org.uk>
 <52A7C0C3.2070805@codeaurora.org>
 <20131211132729.GT11468@sirena.org.uk>
 <52AA42FD.4040503@codeaurora.org>
 <20131213104128.GT11044@sirena.org.uk>
 <20131213171407.GN21983@codeaurora.org>
Message-ID: <20131216205711.GZ3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:14:07AM -0800, Stephen Boyd wrote:

> regmap_bulk_read() should decay to performing individual reads if
> we're using a "no-bus" regmap. Unfortunately, it returns an
> error because there is no map->bus pointer. Fix it.

Applied, thanks.

> > Yes, I'd expect the operation to work.  Your changes below are mostly
> > fine (we should add an additional check for values that aren't integer
> > numbers of bytes, I can add that) - can you send as a signed off patch
> > please and I'll apply?

> Here you go. Do you have any suggestions on how to make regmap_bulk_write()
> work?

Off the top of my head I'd expect it to just fall back onto
regmap_write() if it can't do raw I/O.  Or perhaps just change that loop
to do regmap_write() all the time since it's hardly the fast path.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/edc8d5c2/attachment.sig>
