From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Dec 2013 08:21:13 +0800
Subject: [PATCH V1 1/7] ARM: dts: imx: pinfunc: add
 MX6QDL_PAD_GPIO_6__ENET_IRQ
In-Reply-To: <52B34079.4000302@boundarydevices.com>
References: <1387406497-26430-1-git-send-email-troy.kisky@boundarydevices.com>
 <1387406497-26430-2-git-send-email-troy.kisky@boundarydevices.com>
 <20131219050430.GS6691@S2101-09.ap.freescale.net>
 <52B34079.4000302@boundarydevices.com>
Message-ID: <20131220002111.GE7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:52:41AM -0700, Troy Kisky wrote:
> On 12/18/2013 10:04 PM, Shawn Guo wrote:
> >On Wed, Dec 18, 2013 at 03:41:31PM -0700, Troy Kisky wrote:
> >>Quoting from Ranjani Vaidyanathan
> >>
> >>All of the interrupts from the ENET block are not routed to
> >>the GPC block. Hence ENET interrupts are not able to wake
> >>up the SOC when the system is in WAIT mode. And the ENET
> >>interrupt gets serviced only when another interrupt causes
> >>the SOC to exit WAIT mode. This impacts the ENET performance.
> >We should probably also quote the IMX6Q errata document below.
> >
> >  http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf?fpsp=1
> >
> >ERR006687 ENET: Only the ENET wake-up interrupt request can wake the
> >system from Wait mode.
> 
> Thanks for the link, I didn't know about rev 3. But since they say
> pretty much the same
> things, should I only quote the manual ?

Sounds good.

> 
> >>Adding MX6QDL_PAD_GPIO_6__ENET_IRQ is the 1st step to
> >>workaround this problem.
> >>
> >>The input reg is set to 0x3c to set IOMUX_OBSRV_MUX1 to ENET_IRQ.
> >It seems this is an undocumented register?  Is the info available
> >somewhere?
> 
> I'm the wrong person to ask. The only reference I've seen are patches.
> Mode 1 for GPIO_6 isn't documented either.

Ok.  Just make sure I do not miss any public document.

Shawn
