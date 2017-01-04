From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed, 4 Jan 2017 17:19:59 +0300
Subject: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
In-Reply-To: <CALCETrW3=SsQeC-gWOVqwTtg022+gHei=xfUc2ei3kkX0CACpg@mail.gmail.com>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
 <2736959.3MfCab47fD@wuerfel>
 <CALCETrV_qejd-Ozqo4vTqz=LuukMUPeQ7EVUQbfTxs_xNbO3oQ@mail.gmail.com>
 <20170103160457.GB17319@node.shutemov.name>
 <CALCETrW3=SsQeC-gWOVqwTtg022+gHei=xfUc2ei3kkX0CACpg@mail.gmail.com>
Message-ID: <20170104141959.GC17319@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 10:27:22AM -0800, Andy Lutomirski wrote:
> On Tue, Jan 3, 2017 at 8:04 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > And what about stack? I'm not sure that everybody would be happy with
> > stack in the middle of address space.
> 
> I would, personally.  I think that, for very large address spaces, we
> should allocate a large block of stack and get rid of the "stack grows
> down forever" legacy idea.  Then we would never need to worry about
> the stack eventually hitting some other allocation.  And 2^57 bytes is
> hilariously large for a default stack.

The stack in the middle of address space can prevent creating other huuuge
contiguous mapping. Databases may want this.

-- 
 Kirill A. Shutemov
