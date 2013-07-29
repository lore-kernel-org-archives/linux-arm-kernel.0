From: matt.porter@linaro.org (Matt Porter)
Date: Mon, 29 Jul 2013 11:32:05 -0400
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130726144047.GH9858@sirena.org.uk>
References: <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726132709.GH29916@titan.lakedaemon.net>
 <1374846070.14574.92.camel@i7.infradead.org>
 <CAKON4OzrkHzUzKkULWCgiEpAtJ5gLxUm78R5ctd7p6trqq_gCA@mail.gmail.com>
 <20130726142140.GR24642@n2100.arm.linux.org.uk>
 <20130726144047.GH9858@sirena.org.uk>
Message-ID: <20130729153204.GJ5022@ohporter.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 03:40:47PM +0100, Mark Brown wrote:
> On Fri, Jul 26, 2013 at 03:21:40PM +0100, Russell King - ARM Linux wrote:
> 
> > So this is why I'm seeing patches just a short time ago removing existing
> > compatible strings from the DT descriptions and associated driver, and
> > replacing them with new ones... meaning that the old DT files won't work
> > with newer kernels.
> 
> The big question is if you're seeing such patches merged.  People making
> mistakes on submissions is totally normal.

Over in the bcm53xx thread, we've discussed such a patch to fix
inconsistencies. The problem here is that there is no canonical answer
to what a mistake is. I can make a strong argument that the support for
these parts is in such an early stage that the bindings (in this case
specifically the two different compatible strings for one vendor) should
be considered unstable and ok to fix the consistency issue. Mark Rutland
suggests we should change nothing and possibly add a third vendor prefix
for new bindings. I'm having trouble accepting that just because these
bindings made it into a final kernel during a period where
scrutinization of these things was not very high that we need to forever
carry this inconsistency in the "specification".

http://www.spinics.net/lists/arm-kernel/msg262059.html

> 
> If it's the case I think you mean TBH I'm not sure anyone cares, I don't
> think anyone is using that stuff in production yet as those chips go
> almost exclusively into Android phones.

At least the bcm281xx stuff falls into this category as you describe.
There's simply nobody that would be upset if its bindings changed from
bcm-><something_else> as there's just nobody using the DT-based upstream
work except for internal Broadcom and a couple people external working
closely with them.

This situation seems to illustrate the strong need for an unstable
binding period that's longer than just inclusion in a final kernel
release.

-Matt
