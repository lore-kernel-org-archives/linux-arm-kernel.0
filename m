From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 11 May 2012 11:31:15 +0200
Subject: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
In-Reply-To: <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172918.13418.64781.stgit@dusk> <4FACD255.3080702@ti.com>
 <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com>
Message-ID: <4FACDC63.7060605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/11/2012 11:22 AM, Paul Walmsley wrote:
> Hi Beno?t
>
> On Fri, 11 May 2012, Cousson, Benoit wrote:
>
>> I do not have any clue about that chip, but is this clock really what it is
>> supposed to be? I mean, isn't the uart1_fck the parent of all the UART fck or
>> something like that. Don't we just have an issue becasue the clock names are
>> not accurate?
>
> I guess that's what I'm trying to find out.
>
> According to the AM3517 TRM rev. B (SPRUGR0B) Figure 14-20 "UART
> Functional Integration" and Table 14-11 "UART Clocks", all of the UARTs
> appear to have independent functional clocks.  The table even mentions a
> CM_FCLKEN1_CORE.EN_UART4 bit.  But the PRCM chapter of this TRM doesn't
> mention that at all.  So the documentation is not too useful here.
>
> On the rest of the OMAPs, as far as I know, the UART clocks are all
> separate.

In fact, not really. The same PER_48M_GFCLK clock is used for every UART 
instances in OMAP4. We do have a separate modulemode for each UART but 
as far as clocks are concerned, the source clock is the same.

Regards,
Benoit
