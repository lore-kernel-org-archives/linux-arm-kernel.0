From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Mar 2010 10:58:05 +0000
Subject: [PATCH 2/4] mmp: support ssp in pxa168
In-Reply-To: <f17812d71003110020g67bb7fd6tfe1381294b6cfe8f@mail.gmail.com>
References: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
	<20100310142832.GB24422@rakim.wolfsonmicro.main>
	<f17812d71003110020g67bb7fd6tfe1381294b6cfe8f@mail.gmail.com>
Message-ID: <20100311105804.GD2585@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 04:20:35PM +0800, Eric Miao wrote:
> On Wed, Mar 10, 2010 at 10:28 PM, Mark Brown

> > cycle? ?I can apply the patches on a branch by themselves which can also
> > be pulled into the PXA tree if needed.

> I'd expect there to be some merge conflicts I need to solve along with
> my cleaning up of the SSP code. That said, it's better to go via -pxa
> tree and get the multi-codec work solved in linux-next?

That's not going to be possible with at least the machine driver - if
it's only present in one tree we can't do fixups in the other.  This is
why I'm saying put it on a branch and merge it into both trees, that way
both trees have the code in them as though things had been merged into
mainline already so problems are much less likely.

> Mark, could you please point me the reference to the multi-codec work
> so I can have a rough feeling of the possible merge issues?

There's a branch in Liam's git tree (still sketching out the goal rather
than the finished product):

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

Big thing is that there's most likely going to be at least cosmetic
changes to how cards are registered.
