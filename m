From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 06 Jan 2010 17:42:17 +0000
Subject: [PATCH 2/2] Remove now-defunct ts7250 nand driver
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020893C9@mi8nycmail19.Mi8.com>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
	<BD79186B4FD85F4B8E60E381CAEE1909020893C9@mi8nycmail19.Mi8.com>
Message-ID: <1262799737.3181.8388.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-06 at 12:26 -0500, H Hartley Sweeten wrote:
> Ok, that's really strange.  I just looked at the email I sent and that line
> is:
> 
> - *   Copyright (C) 2004 Marius Gr?ger (mag at sysgo.de)

Your previous email was in iso8859-1, a legacy charset that really has
no business being used this century. You can see the charset in its
Content-Type: header:
	Content-type: text/plain; charset="iso-8859-1"

The ? was therefore encoded as a single byte 0xf6. When we save the mail
to disk and apply it as a patch, that 0xf6 doesn't actually match what's
in the file you were patching -- and thus the patch didn't apply.

> The character must have been converted as the message left my outbox.

Probably, yes.

> Hmmmm.. What should my default character set be?  It looks like my mailer is
> setup to use these (in this order):

Did you change anything already? Although your older mail was iso8859-1,
the mail to which I'm replying now is different. It's:
	Content-type: text/plain; charset="utf-8"

So this time the ? is encoded as two bytes (0xc3, 0xb6) and _does_ match
what's in the kernel source files. If you'd included the patch in _this_
mail, it would have applied.

> us-ascii
> iso-8859-1
> utf-8 (locale)
> utf-8

It's iso-8859-1 which is causing the problem. Because your mail only
used characters which can be represented in iso8859-1, it got converted
to that. Drop iso8859-1 and it should be fine. ASCII is fine because
it's a subset of UTF-8. Any ASCII text is also valid UTF-8.

-- 
dwmw2
