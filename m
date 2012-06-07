From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jun 2012 01:07:39 -0600 (MDT)
Subject: [PATCH] ARM: omap: clock: Get rid of unwanted clkdm assocations
 within clks
In-Reply-To: <4FD04A2A.4080207@ti.com>
References: <1337250245-29274-1-git-send-email-rnayak@ti.com>
 <4FD04A2A.4080207@ti.com>
Message-ID: <alpine.DEB.2.00.1206070104060.6684@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 7 Jun 2012, Rajendra Nayak wrote:

> On Thursday 17 May 2012 03:54 PM, Rajendra Nayak wrote:
> > clkdm assocations with clocks in the clock framework are useful
> > only for 'gate' clocks which have enable/disable ops populated.
> > Get rid of the clkdm_names populated in any other type of clocks.

I don't really see the point in changing this before the common clock 
conversion.  The design of most of the current low-level OMAP PM layers 
was predicated on each clock belonging to a clockdomain.  The testing 
overhead of changing this before the common clock conversion is something 
that I don't have time for, and almost no one else seems interested in 
doing.

Your common clock conversion moots this patch anyway, right?

- Paul
