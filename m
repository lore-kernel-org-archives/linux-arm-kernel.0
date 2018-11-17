From: willy@infradead.org (Matthew Wilcox)
Date: Sat, 17 Nov 2018 06:37:42 -0800
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx>
 <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
Message-ID: <20181117143742.GB7861@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2018 at 12:26:38PM +0530, Souptick Joarder wrote:
> On Fri, Nov 16, 2018 at 11:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > + * vm_insert_range - insert range of kernel pages into user vma
> > > + * @vma: user vma to map to
> > > + * @addr: target user address of this page
> > > + * @pages: pointer to array of source kernel pages
> > > + * @page_count: no. of pages need to insert into user vma
> > > + *
> > > + * This allows drivers to insert range of kernel pages they've allocated
> > > + * into a user vma. This is a generic function which drivers can use
> > > + * rather than using their own way of mapping range of kernel pages into
> > > + * user vma.
> >
> > Please add the return value and context descriptions.
> >
> 
> Sure I will wait for some time to get additional review comments and
> add all of those requested changes in v2.

You could send your proposed wording now which might remove the need
for a v3 if we end up arguing about the wording.
