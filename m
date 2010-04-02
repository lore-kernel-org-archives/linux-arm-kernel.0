From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 2 Apr 2010 09:06:29 +0200
Subject: [Question] race condition in mm/page_alloc.c regarding page->lru?
In-Reply-To: <g2g5f4a33681004012051wedea9538w9da89e210b731422@mail.gmail.com>
References: <i2i5f4a33681003312105m4cd42e9ayfe35cc0988c401b6@mail.gmail.com>
	<g2g5f4a33681004012051wedea9538w9da89e210b731422@mail.gmail.com>
Message-ID: <20100402070629.GT30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 11:51:33AM +0800, TAO HU wrote:
> On Thu, Apr 1, 2010 at 12:05 PM, TAO HU <tghk48@motorola.com> wrote:
> > We got a panic on our ARM (OMAP) based HW.
> > Our code is based on 2.6.29 kernel (last commit for mm/page_alloc.c is
> > cc2559bccc72767cb446f79b071d96c30c26439b)
> >
> > It appears to crash while going through pcp->list in
> > buffered_rmqueue() of mm/page_alloc.c after checking vmlinux.
> > "00100100" implies LIST_POISON1 that suggests a race condition between
> > list_add() and list_del() in my personal view.
> > However we not yet figure out locking problem regarding page.lru.

I'm sure this is just a memory corruption which is unrelated to code in
the the memory management area. The code there just happens to trigger
it as it is called frequently and is very sensitive to bogus data

Did you see the other thread I started off yesterday?

  http://lkml.indiana.edu/hypermail/linux/kernel/1004.0/00157.html

We could well see the same problem here. Not sure though as any kind of
memory corruption ends up in Ooopses like the ones you see, but it could
be a hint.

Daniel
