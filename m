From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 21:01:53 +0000
Subject: [PATCH 3/8] regmap: Add support for using regmap over ssbi
In-Reply-To: <20131213213707.GO21983@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
 <20131210235000.GK11468@sirena.org.uk>
 <52A7AE1B.3040201@codeaurora.org>
 <20131211005106.GL11468@sirena.org.uk>
 <52A7C0C3.2070805@codeaurora.org>
 <20131211132729.GT11468@sirena.org.uk>
 <52AA42FD.4040503@codeaurora.org>
 <20131213104128.GT11044@sirena.org.uk>
 <20131213213707.GO21983@codeaurora.org>
Message-ID: <20131216210153.GA3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 01:37:07PM -0800, Stephen Boyd wrote:

> I came up with this (possibly ugly) patch. It works for my
> specific case but I'm not sure if unpacking the val bits into an
> unsigned int and passing that to _regmap_write() is sane. What do
> you think?

It's not lovely but it's about as good as it gets.  I'd probaly just
drop the raw single write case so it's simpler - just either raw write
the lot or write a register at a time with unpacking (and so refactor
the the loop that does the in place formatting into the raw case only
and not bother for the single write).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/cf637c61/attachment.sig>
