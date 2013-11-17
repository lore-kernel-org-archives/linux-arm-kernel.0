From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 17 Nov 2013 15:06:28 +0100
Subject: [Cocci] Warning masked by BUG() when CONFIG_BUG is enabled
In-Reply-To: <87a9h4559j.fsf@natisbad.org>
References: <87a9h4559j.fsf@natisbad.org>
Message-ID: <20131117140627.GA6744@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> As a side note, I noticed quite some instances of that pattern (switch
> statement w/ a 'default' calling BUG()) while more carefully looking at
> compilation output. I may get slapped for this, but just in case this
> is indeed something which deserves to be fixed and can be fixed
> automagically via some semantic patch, I have CC'ed Coccinelle people.

I don't think this can be fixed in a generic way. This driver, for
example, should IMO return -EINVAL when hitting default in probe and
simply get rid of the other BUG() calls. No need to halt the kernel
because of a broken match->data.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131117/ec18a9f3/attachment.sig>
