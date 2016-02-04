From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 4 Feb 2016 13:19:59 +1100
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
References: <20160112164034.0fe945a7@canb.auug.org.au>
 <20160112163835.GD347@kvack.org>
 <20160127134024.0fababf6@canb.auug.org.au>
 <20160129113056.GP10826@n2100.arm.linux.org.uk>
 <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
Message-ID: <20160204131959.6695c7bf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On Fri, 29 Jan 2016 13:03:39 +0100 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Fri, Jan 29, 2016 at 12:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> Background: new aio code is adding __get_user() calls referencing 64
> >> bit quantities (__u64 and __s64).  
> >
> > There's lots more architectures which do not support 64-bit get_user()
> > _or_ __get_user(): avr32, blackfin, metag for example, and m68k which
> > has this interesting thing "/* case 8: disabled because gcc-4.1 has a
> > broken typeof \" in its *get_user() implementation.  
> 
> And if you enable it again, you get lots of "warning: cast to pointer from
> integer of different size", like you mentioned.

Any thoughts?  I am still using the version of tha aio tree from
next-20160111.

-- 
Cheers,
Stephen Rothwell
