From: rppt@linux.ibm.com (Mike Rapoport)
Date: Fri, 23 Nov 2018 09:19:25 +0200
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <CAFqt6zbhodAGQz-RCB3C-wt_Mvb9QDmQ8pFeP2EO+ba2k2OccA@mail.gmail.com>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx>
 <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
 <20181117143742.GB7861@bombadil.infradead.org>
 <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
 <20181119162623.GA13200@rapoport-lnx>
 <CAFqt6zbhodAGQz-RCB3C-wt_Mvb9QDmQ8pFeP2EO+ba2k2OccA@mail.gmail.com>
Message-ID: <20181123071924.GF5704@rapoport-lnx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 11:15:15PM +0530, Souptick Joarder wrote:
> On Mon, Nov 19, 2018 at 9:56 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Mon, Nov 19, 2018 at 08:43:09PM +0530, Souptick Joarder wrote:
> > > Hi Mike,
> > >
> > > On Sat, Nov 17, 2018 at 8:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Sat, Nov 17, 2018 at 12:26:38PM +0530, Souptick Joarder wrote:
> > > > > On Fri, Nov 16, 2018 at 11:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > > > > + * vm_insert_range - insert range of kernel pages into user vma
> > > > > > > + * @vma: user vma to map to
> > > > > > > + * @addr: target user address of this page
> > > > > > > + * @pages: pointer to array of source kernel pages
> > > > > > > + * @page_count: no. of pages need to insert into user vma
> > > > > > > + *
> > > > > > > + * This allows drivers to insert range of kernel pages they've allocated
> > > > > > > + * into a user vma. This is a generic function which drivers can use
> > > > > > > + * rather than using their own way of mapping range of kernel pages into
> > > > > > > + * user vma.
> > > > > >
> > > > > > Please add the return value and context descriptions.
> > > > > >
> > > > >
> > > > > Sure I will wait for some time to get additional review comments and
> > > > > add all of those requested changes in v2.
> > > >
> > > > You could send your proposed wording now which might remove the need
> > > > for a v3 if we end up arguing about the wording.
> > >
> > > Does this description looks good ?
> > >
> > > /**
> > >  * vm_insert_range - insert range of kernel pages into user vma
> > >  * @vma: user vma to map to
> > >  * @addr: target user address of this page
> > >  * @pages: pointer to array of source kernel pages
> > >  * @page_count: number of pages need to insert into user vma
> > >  *
> > >  * This allows drivers to insert range of kernel pages they've allocated
> > >  * into a user vma. This is a generic function which drivers can use
> > >  * rather than using their own way of mapping range of kernel pages into
> > >  * user vma.
> > >  *
> > >  * Context - Process context. Called by mmap handlers.
> >
> > Context:
> >
> > >  * Return - int error value
> >
> > Return:
> >
> > >  * 0                    - OK
> > >  * -EINVAL              - Invalid argument
> > >  * -ENOMEM              - No memory
> > >  * -EFAULT              - Bad address
> > >  * -EBUSY               - Device or resource busy
> >
> > I don't think that elaborate description of error values is needed, just "0
> > on success and error code otherwise" would be sufficient.
> 
> /**
>  * vm_insert_range - insert range of kernel pages into user vma
>  * @vma: user vma to map to
>  * @addr: target user address of this page
>  * @pages: pointer to array of source kernel pages
>  * @page_count: number of pages need to insert into user vma
>  *
>  * This allows drivers to insert range of kernel pages they've allocated
>  * into a user vma. This is a generic function which drivers can use
>  * rather than using their own way of mapping range of kernel pages into
>  * user vma.
>  *
>  * Context: Process context. Called by mmap handlers.
>  * Return: 0 on success and error code otherwise
>  */

Looks good to me.

-- 
Sincerely yours,
Mike.
