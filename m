From: js@sig21.net (Johannes Stezenbach)
Date: Sat, 26 Mar 2016 00:50:24 +0100
Subject: dmaengine: ARM pl080 misidentified as Samsung pl080s
In-Reply-To: <CA+Ln22Ea-cVS1Cgq1TFKktMCiQ3OGqJ=Bjx3q1qxeGr3LSMXGQ@mail.gmail.com>
References: <20160324105651.GA20489@sig21.net>
 <CA+Ln22Ea-cVS1Cgq1TFKktMCiQ3OGqJ=Bjx3q1qxeGr3LSMXGQ@mail.gmail.com>
Message-ID: <20160325235024.GA13621@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 26, 2016 at 12:08:00AM +0100, Tomasz Figa wrote:
> 2016-03-24 11:56 GMT+01:00 Johannes Stezenbach <js@sig21.net>:
> >
> > commit da1b6c05b8b5bd ("dmaengine: PL08x: Add support for PL080S variant")
> > added this hunk:
> >
> >  static struct amba_id pl08x_ids[] = {
> > +       /* Samsung PL080S variant */
> > +       {
> > +               .id     = 0x0a141080,
> > +               .mask   = 0xffffffff,
> > +               .data   = &vendor_pl080s,
> > +       },
> >         /* PL080 */
> >
> > However, 0x0a141080 happens to be the ID of the
> > ARM PL080, too:
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0196g/I54627.html
> 
> It can be, assuming that 0xa1 is an existing revision of original
> PL080. AFAIK when we were figuring out what to do with this broken
> Samsung's controller, we found out that there was no platform with
> such revision. Is your concern related to any actual hardware already
> supported by upstream?

It isn't upstream and likely won't.  I reported it because
this is ARM IP probably used by others, for me it was
easy enough to fix locally but I wasted two hours until
I figured out what went wrong.

Johannes
