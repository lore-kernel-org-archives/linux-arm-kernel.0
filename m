From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Jan 2014 15:07:37 +0000
Subject: [PATCH 1/2] spi: clps711x: Driver refactor
In-Reply-To: <1388583851.810843204@f301.i.mail.ru>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <20140101132334.GP31886@sirena.org.uk>
 <1388583851.810843204@f301.i.mail.ru>
Message-ID: <20140101150737.GR31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 01, 2014 at 05:44:11PM +0400, Alexander Shiyan wrote:

> I wrote that this is a complex patch. This is not a fix, but new driver,
> many things are done differently.
> I do not see a way to separate these changes.

I already mentioned one thing that could be done incrementally (the
conversion to devm), from the glance I took through the code there's
several other things that jump out and like I said at least splitting
the hardware.h removal from the device tree changes would be a start. 

Nothing in what you said the change did nor in the change itself
suggested that it would be impossible to break things up, I'm not
convinced that any attempt has been made to split anything out.

> As an alternative, I can create patch to remove current driver,
> then re-adding new one.  Will be more convenient to watch. Is it better? 

No, that's really not good.  It's very rare that we just completely
rewrite a driver especially not one that's been around for a while -
there needs to be a really good reason for it.  This is a key part of
how the development process works, incremental improvements and code
review.  Doing this both helps improve quality control on changes and
allows collaboration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140101/520fd267/attachment.sig>
