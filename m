From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 May 2010 15:26:40 +0100
Subject: pxa-devel back-merge / cherry pick request
In-Reply-To: <20100531132233.GC14195@sirena.org.uk>
References: <20100531114815.GF2695@buzzloop.caiaq.de>
	<20100531124750.GA21679@n2100.arm.linux.org.uk>
	<20100531131317.GF2698@buzzloop.caiaq.de>
	<20100531132233.GC14195@sirena.org.uk>
Message-ID: <20100531142639.GA30051@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 02:22:34PM +0100, Mark Brown wrote:
> On Mon, May 31, 2010 at 03:13:17PM +0200, Daniel Mack wrote:
> 
> > Just out of interest - why would cherry-picking be frowned upon?
> > Shouldn't git just ignore the commits it already knows when things are
> > pulled?
> 
> No, git is content based.  The merge should be a noop merge if the two
> sides end up being the same but you still end up with two different
> copies of the change in history.

Sometimes it actually causes merge conflicts if there are changes in
the same part of the file as the picked patch touches which aren't
also cherry-picked.

It's best to avoid cherry-picking commits into two different git
threads and then try to merge them.
