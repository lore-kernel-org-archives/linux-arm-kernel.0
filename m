From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 12 Dec 2014 09:45:30 +0000
Subject: [PATCH v2 1/1] net/macb: add TX multiqueue support for gem
In-Reply-To: <20141211203103.4191887a@free-electrons.com>
References: <cover.1418291637.git.cyrille.pitchen@atmel.com>
 <87a3098203ee6eaa7a60607713a293d3258e2b58.1418291637.git.cyrille.pitchen@atmel.com>
 <20141211203103.4191887a@free-electrons.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CA0BA36@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni
> On Thu, 11 Dec 2014 11:16:51 +0100, Cyrille Pitchen wrote:
> 
> > +#define GEM_ISR1				0x0400
> > +#define GEM_ISR2				0x0404
> > +#define GEM_ISR3				0x0408
> > +#define GEM_ISR4				0x040c
> > +#define GEM_ISR5				0x0410
> > +#define GEM_ISR6				0x0414
> > +#define GEM_ISR7				0x0418
> 
> What about doing instead:
> 
> #define GEM_ISR(q)				((q) == 0 ? MACB_ISR : 0x400 + (q) << 2)
> 
> And ditto for all other registers, which will save a lot of boring repeated code.

It will probably add a lot of object code and, depending on how often
the registers are accesses, might have performance impact.

Having:
#define GEM_ISR(n) (0x400 + (n) << 4)
will save source code.

	David
