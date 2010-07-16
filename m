From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 16 Jul 2010 12:18:29 -0600
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <20100716180701.GA26854@n2100.arm.linux.org.uk>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<20100716180701.GA26854@n2100.arm.linux.org.uk>
Message-ID: <AANLkTilfgiQyvcBhEmdc5P8HXSUHgAG7SUa0Mz4ev6ze@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 12:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 16, 2010 at 11:57:55AM -0600, Grant Likely wrote:
>> Last missing piece is being able to do "select FOO = n", which Stephen
>> is currently working on.
>
> I thought Linus' idea was to use:
>
> KBUILD_KCONFIG=file make allnoconfig

That was more a prototype of the idea; but it's a pretty cumbersome
user interface.  :-)  By changing the makefile to look for kconfig
fragments in the configs directory, the user interface for choosing a
config remains exactly the same.

As for the allnoconfig bit....

> in which case any option which would be presented to the user which hasn't
> been selected by 'file' ends up being set to n. ?That means there's no
> need for a special "select FOO=n" construct.

...Linus chimed in on this that he doesn't actually care much.  I
think defconfig with an empty initial config file makes a lot more
sense than allnoconfig so that we're using the default values from the
normal Kconfig files.

> See one of Linus' replies on June 3:
> Message-ID: <alpine.LFD.2.00.1006031317410.8175@i5.linux-foundation.org>

See this response:
Message-ID: <AANLkTik-QCXFnjma3J28B9h27uajOcDhthTGz99zKgVi@mail.gmail.com>

http://news.gmane.org/find-root.php?message_id=%3cAANLkTik%2dQCXFnjma3J28B9h27uajOcDhthTGz99zKgVi%40mail.gmail.com%3e

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
