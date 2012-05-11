From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 11 May 2012 03:35:18 -0600 (MDT)
Subject: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
In-Reply-To: <4FACDC63.7060605@ti.com>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172918.13418.64781.stgit@dusk> <4FACD255.3080702@ti.com>
 <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com>
 <4FACDC63.7060605@ti.com>
Message-ID: <alpine.DEB.2.00.1205110333240.3201@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 May 2012, Cousson, Benoit wrote:

> On 5/11/2012 11:22 AM, Paul Walmsley wrote:
> 
> > On the rest of the OMAPs, as far as I know, the UART clocks are all
> > separate.
> 
> In fact, not really. The same PER_48M_GFCLK clock is used for every UART
> instances in OMAP4. We do have a separate modulemode for each UART but as far
> as clocks are concerned, the source clock is the same.

By "separate" I mean that they are all independently gated. This does not 
appear to be the case with AM3517.  Or perhaps it is the case and 
something isn't right with the idle management FSMs.


- Paul
