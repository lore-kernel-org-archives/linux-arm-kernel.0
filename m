From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 19 Sep 2011 20:06:03 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919185809.GA16381@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919184027.GZ16381@n2100.arm.linux.org.uk>
	<20110919184230.GF540@opensource.wolfsonmicro.com>
	<20110919185809.GA16381@n2100.arm.linux.org.uk>
Message-ID: <20110919190602.GG540@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 07:58:09PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 19, 2011 at 07:42:30PM +0100, Mark Brown wrote:

> > > > I'm wondering if we need something like 7c8a25 (CRIS: Discard exit.text
> > > > and .data at runtime) but figuring it out is a bit beyond my ld skills
> > > > right now.

> Pleas elook at the error message again.  >>>ambiguous<<<.  That means
> git knows about the ID but more than one commit matches it:

Oh, right - sorry.

> So there's IDs 7c8a251 and 7c8a25b in existence, and git doesn't know
> which one to use.  So using that, I can track down the commit you
> actually meant.

> What you're actually after is:

> 	7c8a25b (CRIS: Discard exit.text and .data at runtime)

Yup.

> which is what you'd get from git if you ask it to give you the shortened
> git ID.  (Git knows when the shortened git ID clashes and will add
> additional digits to make up a unique ID.)

> You can use "git log --pretty='%h (%s)'" to get a log already formatted
> with parens around the summary line.

Yeah, it's a shame it doesn't include the disambiguated short ID in the
standard git log output (which is what I always grep if I'm trying to
search commit messages).  I've never seen a way to tell git to use %H
instead of %h there by default that doesn't require me to start copying
scripts or whatever between machines all the time.
