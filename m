From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 6 Jan 2010 18:07:05 +0000
Subject: Sending UTF-8 patches (was: [PATCH 2/2] Remove now-defunct ts7250
	nand driver)
In-Reply-To: <1262784693.3181.8034.camel@macbook.infradead.org>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
Message-ID: <20100106180705.GC11773@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Woodhouse wrote:
> It looks like your patch has legacy garbage in it:
> 
> > - *   Copyright (C) 2004 Marius Gr<F6>ger (mag at sysgo.de)
> 
> It fails to apply because the ? (correctly represented as 0xc3 0xb6) has
> been converted into a single byte 0xf6 in some legacy character set.
>
> When applying patches, git-am does look at the Content-Type: header and
> convert legacy crap into UTF-8 for the changelog, but it leaves the
> patch itself alone.

That's unfortunate.  An option to git-am or it's subsidiary tools to
convert the patch as well as the commit would be useful.  After all it
_is_ made clear in the MIME header how it's formatted.

> Care to join us in the 21st century?

You mean send the mail in UTF-8 format when it only contains
characters in ISO-8859-1?  To make that the default behaviour of an
email sender would possibly violate RFC2045, which as far as I can
tell is still the prevailing standard, which is I guess why Mutt does
not do that in its default configuration, and recodes the text from
UTF-8 to 8859-1 when it can.  That's what 21st century tools do :-)

I guess it's time for a "send-hook" to use a different setting
specially for Linux mailing lists.

Do you instead mean send the patch in UTF-8 embedded in a mail encoded
as 8859-1?  That sounds quite difficult, if the patch is inline rather
than attached.

An option to git-am to DTRT sounds infinitely better to me.  Shame
it's not there; unfortunately it doesn't emit enough information to
make it easy with a wrapper script.

What settings do you use to get this right?

Thanks,
-- Jamie
