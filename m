From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jul 2012 19:09:51 +0200
Subject: [PATCH v2 08/12] Kirkwood: Add basic device tree support for
 QNAP TS219.
In-Reply-To: <5219791.0WtDlTNBEQ@flexo>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-9-git-send-email-andrew@lunn.ch>
 <5219791.0WtDlTNBEQ@flexo>
Message-ID: <20120703170951.GC1519@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 05:47:57PM +0200, Florian Fainelli wrote:
> Hi Andrew,
> 
> On Tuesday 03 July 2012 16:22:41 Andrew Lunn wrote:
> > The two different variants of QNAP TS devices, varying by SoC, put the
> > GPIO keys on different GPIO lines. Hence we need two different DT
> > board descriptions, which share the same board-ts219.c file.
> 
> Why don't you reorder this patch to be after patch 11/12 so that you do not 
> need to update this file in patch 11/12?

It just reflects the order i did the work. I can rebase it, but what
is the advantage? It should be fully bisectable as is.

> 
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> [snip]
> >  
> > +config MACH_TS219_DT
> > +	bool "Device Tree for QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, 
> TS-219P and TS-219P+ Turbo NAS"
> 
> This looks too long, how about just "Device Tree for QNAP TS-11x, TS-21x NAS" 
> for instance?

Yes, i was not too happy with this. I copied the none DT version as a
basis, since that is what kernel builds know at the moment. Since i'm
not alone not liking it, i will change it as you suggested.

    Thanks
	Andrew
