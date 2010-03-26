From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 26 Mar 2010 12:02:08 +0900
Subject: [C/R ARM][PATCH 3/3] c/r: ARM implementation of checkpoint/restart
In-Reply-To: <20100326024759.GN19308@shareable.org>
References: <1269219965-23923-1-git-send-email-christofferdall@christofferdall.dk>
	<1269219965-23923-4-git-send-email-christofferdall@christofferdall.dk>
	<20100323211843.GC19572@n2100.arm.linux.org.uk>
	<7d08b87d1003241348g347f092k1142318490e0bdcc@mail.gmail.com>
	<20100326024759.GN19308@shareable.org>
Message-ID: <20100326030208.GA5815@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 02:47:59AM +0000, Jamie Lokier wrote:
> Christoffer Dall wrote:
> > >> We checkpoint whether the system is running with CONFIG_MMU or not and
> > >> require the same configuration for the system on which we restore the
> > >> process. It might be possible to allow something more fine-grained,
> > >> if it's worth the energy. Input on this item is also very welcome,
> > >> specifically from someone who knows the exact meaning of the end_brk
> > >> field.
> > >
> > > Processes which run on MMU and non-MMU CPUs are unlikely to be
> > > interchangable - the run time environments are quite different. ?I
> > > think this is a sane check.
> > >
> > thanks.
> 
> It's possible in principle to run many non-MMU binaries on MMU
> kernels, but I've never heard of anyone doing it.
> 
FDPIC supports running the same binaries with or without MMU depending on
your ABI, it's not really that uncommon, even if it's mostly just used
for prototyping.
