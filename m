From: william.kucharski@oracle.com (William Kucharski)
Date: Wed, 21 Nov 2018 07:29:37 -0700
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <20181121123513.GF3065@bombadil.infradead.org>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx>
 <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
 <20181117143742.GB7861@bombadil.infradead.org>
 <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
 <833B5050-DEF6-44A0-9832-276F86671212@oracle.com>
 <20181121123513.GF3065@bombadil.infradead.org>
Message-ID: <D13F3DA0-1CD3-43AF-BAF6-5103FE7C4B5A@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Nov 21, 2018, at 5:35 AM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> It's probably better to be more explicit and answer Randy's question:
> 
> * If we fail to insert any page into the vma, the function will return
> * immediately leaving any previously-inserted pages present.  Callers
> * from the mmap handler may immediately return the error as their
> * caller will destroy the vma, removing any successfully-inserted pages.
> * Other callers should make their own arrangements for calling unmap_region().

That works for me as well.
