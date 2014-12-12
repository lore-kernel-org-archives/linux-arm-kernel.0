From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 12 Dec 2014 09:59:36 +0000
Subject: [PATCH v2 1/1] net/macb: add TX multiqueue support for gem
In-Reply-To: <548AAE66.8070501@atmel.com>
References: <cover.1418291637.git.cyrille.pitchen@atmel.com>
 <87a3098203ee6eaa7a60607713a293d3258e2b58.1418291637.git.cyrille.pitchen@atmel.com>
 <20141211203103.4191887a@free-electrons.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CA0BA36@AcuExch.aculab.com>
 <548AAE66.8070501@atmel.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CA0BA7D@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen [...
> > It will probably add a lot of object code and, depending on how often
> > the registers are accesses, might have performance impact.
> >
> > Having:
> > #define GEM_ISR(n) (0x400 + (n) << 4)
> > will save source code.
> >
> > 	David
> >
> >
> >
> So you suggest that we keep the unsigned int fields ISR, IMR, IER, IDR, TBQP in
> the struct macb_queue and initialize them once for all in macb_probe() like
> patch v2 does but only replace the GEM_ISR1 .. GEM_ISR7 defines by GEM_ISR(n)
> in macb.h?
> 
> This way there would be to test at run time and we can handle the special
> register mapping of queue0.
> 
> Is it what you meant?

In one word, yes.

	David
