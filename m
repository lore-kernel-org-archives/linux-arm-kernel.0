From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 20:01:37 +0100
Subject: [RFC PATCH 06/11] dma: amba-pl08x: Keep LLIs aligned to 4-word
 boundary
In-Reply-To: <CACRpkdYzag=sKo87i6H3M_fSQuRiTX3_2-ZhQA+4S7ejZN5j4A@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-7-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdYzag=sKo87i6H3M_fSQuRiTX3_2-ZhQA+4S7ejZN5j4A@mail.gmail.com>
Message-ID: <20130617190137.GQ2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 03:51:20PM +0200, Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> > index eb10eb8..0da5539 100644
> > --- a/drivers/dma/amba-pl08x.c
> > +++ b/drivers/dma/amba-pl08x.c
> > @@ -127,6 +127,7 @@ struct pl08x_lli {
> >         u32 lli;
> >         u32 cctl;
> >         u32 cctl1;
> > +       u32 dummy[3];
> 
> Atleast put a comment into the code explaining what this is all
> about. Or someone will add another member to the struct and
> all is lost. Call it "padding" rather than dummy.

Another solution to that is to use __attribute__((__aligned__(16)))
if you want it aligned to 16 byte boundaries.
