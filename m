From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 06 Jan 2010 23:43:00 +0000
Subject: Sending UTF-8 patches (was: [PATCH 2/2] Remove now-defunct
	ts7250 nand driver)
In-Reply-To: <20100106232128.GE24250@shareable.org>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
	<20100106180705.GC11773@shareable.org>
	<1262803010.3181.8484.camel@macbook.infradead.org>
	<20100106232128.GE24250@shareable.org>
Message-ID: <1262821380.3181.8838.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-06 at 23:21 +0000, Jamie Lokier wrote:
> > Personally, I suspect you're right, and it should be converted too.
> 
> It would need to optional for git users whose source code isn't UTF-8 -
> possibly converting the other way for them.  But yeah I think it'd make
> sense to be on by default.

It's silly to talk of 'converting the other way'. The tool converts from
the charset of the email, to the charset that the git repository is
configured for (which is UTF-8 by default and in all sane cases).

Why would you want to convert the other way?

It is currently optional, but I suspect that's the wrong approach. The
only reason you'd ever want that is if the mail it's interpreting is
mislabelled -- and in that case surely the best workaround is an option
which lets you override the Content-Type: header, not just disable the
charset conversion altogether. Obviously if you override the input
charset to be equal to your repository configuration, that means that no
conversion is done. But that's just a fairly unimportant special case of
the override, surely?

> Section 4.1.2, Charset Parameter, final paragraph:
> 
> >>   In general, composition software should always use the "lowest common
> >>   denominator" character set possible.  For example, if a body contains
> >>   only US-ASCII characters, it SHOULD be marked as being in the US-
> >>   ASCII character set, not ISO-8859-1, which, like all the ISO-8859
> >>   family of character sets, is a superset of US-ASCII.  More generally,
> >>   if a widely-used character set is a subset of another character set,
> >>   and a body contains only characters in the widely-used subset, it
> >>   should be labelled as being in that subset.  This will increase the
> >>   chances that the recipient will be able to view the resulting entity
> >>   correctly.
> 
> It's a SHOULD, but it's still a good idea.  ISO-8859-1 is still very
> widely-used for email.

That might have made sense 13 years ago, but today I would suggest that
we ought to be applying a general principle that UTF-8 SHOULD be used
everywhere.

By doing so, we mostly sidestep the need for the whole charset labelling
and conversion clusterfuck that nobody ever quite managed to get right
anyway. If everything on the system is UTF-8, all the time, then it
doesn't _matter_ that nobody ever really managed to get labelling to
work.

>From RFC2119:
3. SHOULD   This word, or the adjective "RECOMMENDED", mean that there
   may exist valid reasons in particular circumstances to ignore a
   particular item, but the full implications must be understood and
   carefully weighed before choosing a different course.

I understand the full implications of not using legacy character sets,
and have carefully weighed them before choosing to send UTF-8.

What's the down-side? That some Luddite out there might have a system
which _still_ can't render UTF-8 email in 2010, so they're only seeing
the 99.999% of the email which is readable as ASCII?

-- 
dwmw2
