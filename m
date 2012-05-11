From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 11 May 2012 03:22:47 -0600 (MDT)
Subject: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
In-Reply-To: <4FACD255.3080702@ti.com>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172918.13418.64781.stgit@dusk> <4FACD255.3080702@ti.com>
Message-ID: <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t

On Fri, 11 May 2012, Cousson, Benoit wrote:

> I do not have any clue about that chip, but is this clock really what it is
> supposed to be? I mean, isn't the uart1_fck the parent of all the UART fck or
> something like that. Don't we just have an issue becasue the clock names are
> not accurate?

I guess that's what I'm trying to find out.

According to the AM3517 TRM rev. B (SPRUGR0B) Figure 14-20 "UART 
Functional Integration" and Table 14-11 "UART Clocks", all of the UARTs 
appear to have independent functional clocks.  The table even mentions a 
CM_FCLKEN1_CORE.EN_UART4 bit.  But the PRCM chapter of this TRM doesn't 
mention that at all.  So the documentation is not too useful here.

On the rest of the OMAPs, as far as I know, the UART clocks are all 
separate.


- Paul
