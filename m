From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 6 Jan 2010 23:21:28 +0000
Subject: Sending UTF-8 patches (was: [PATCH 2/2] Remove now-defunct ts7250
	nand driver)
In-Reply-To: <1262803010.3181.8484.camel@macbook.infradead.org>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
	<20100106180705.GC11773@shareable.org>
	<1262803010.3181.8484.camel@macbook.infradead.org>
Message-ID: <20100106232128.GE24250@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Woodhouse wrote:
> > That's unfortunate.  An option to git-am or it's subsidiary tools to
> > convert the patch as well as the commit would be useful.  After all it
> > _is_ made clear in the MIME header how it's formatted.
> 
> ISTR there was some resistance to that suggestion when git-am was first
> fixed to handle the Content-Type of mails. The idea was that the patch
> should be considered sacrosanct and shouldn't be mangled.

Looks like they forgot mailers work with text, not preservation of
octets, and mailers mangle the octets in standardised ways, so a bit
of unmangling is needed on occasions.

> Personally, I suspect you're right, and it should be converted too.

It would need to optional for git users whose source code isn't UTF-8 -
possibly converting the other way for them.  But yeah I think it'd make
sense to be on by default.

> > > Care to join us in the 21st century?
> > 
> > You mean send the mail in UTF-8 format when it only contains
> > characters in ISO-8859-1?  To make that the default behaviour of an
> > email sender would possibly violate RFC2045, 
> 
> Um, why? Can you point at the particular section you think would be
> violated?

Section 4.1.2, Charset Parameter, final paragraph:

>>   In general, composition software should always use the "lowest common
>>   denominator" character set possible.  For example, if a body contains
>>   only US-ASCII characters, it SHOULD be marked as being in the US-
>>   ASCII character set, not ISO-8859-1, which, like all the ISO-8859
>>   family of character sets, is a superset of US-ASCII.  More generally,
>>   if a widely-used character set is a subset of another character set,
>>   and a body contains only characters in the widely-used subset, it
>>   should be labelled as being in that subset.  This will increase the
>>   chances that the recipient will be able to view the resulting entity
>>   correctly.

It's a SHOULD, but it's still a good idea.  ISO-8859-1 is still very
widely-used for email.

Also in that section:

>>    (1)   US-ASCII -- as defined in ANSI X3.4-1986 [US-ASCII].
>>
>>    (2)   ISO-8859-X -- where "X" is to be replaced, as
>>          necessary, for the parts of ISO-8859 [ISO-8859].  Note
>>          that the ISO 646 character sets have deliberately been
>>          omitted in favor of their 8859 replacements, which are
>>          the designated character sets for Internet mail.  As of
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>          the publication of this document, the legitimate values
>>          for "X" are the digits 1 through 10.

> Would you advise that I send a mail as EBCDIC if it can fit into that?

Obviously not - RFC2045 does not recommend that, so mailers don't do it
in their default configurations.  But they do recode text into the
lowest common charset that can represent the text.  In practice that
means no effect on ASCII, but does affect some non-ASCII characters.

Mutt out of the box tries us-ascii / iso-8859-1 / utf-8, in that order,
to maximise the chance of recipients being able to read the mail.  Even
on a fully 21st-century-ised Linux with UTF-8 terminals etc. :-) I don't
know what other mailers do, sorry, but I'd expect them to do the same.

-- Jamie
