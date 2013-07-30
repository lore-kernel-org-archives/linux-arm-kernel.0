From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 Jul 2013 10:40:22 +0200
Subject: [PATCH 4/4] ARM: dove: add initial DT file for Globalscale D2Plug
In-Reply-To: <51F7736C.5040701@gmail.com>
References: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1375100946-28521-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130729184520.GI24782@lunn.ch> <51F7736C.5040701@gmail.com>
Message-ID: <20130730084022.GO24782@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:03:56AM +0200, Sebastian Hesselbarth wrote:
> On 07/29/2013 08:45 PM, Andrew Lunn wrote:
> >On Mon, Jul 29, 2013 at 02:29:06PM +0200, Sebastian Hesselbarth wrote:
> >>This adds an initial DT file for the Globalscale D2Plug with Dove SoC.
> >>Currently, one LED is missing and I have not been able to get SD8787 driver
> >>working. Those will be taken care of later.
> >
> >I took a hard look at SDIO and failed to get it working when doing
> >DMA. Polled IO does however work. I guess we need some help from
> >Marvell engineers before we get stable SDIO with DMA.
> 
> Andrew,
> 
> have you tried this on the Dove D2Plug or any other Marvell SoC?

Hi Sebastian

I only tried it on Kirkwood. I've had similar bug reports for 370,
which appears to shares the same IP core.

> Dove is using a different SDHCI compatible SDIO controller.

Ah, O.K. Didn't know. It will be interesting to see if this core has
the same problems, i.e. shares the same DMA engine as the MVSDIO core.

> Also, the DMA issue is not holding back this patch, is it?

No, not at all. I just wanted to point out, there are known problems
with the in kernel driver for MVSDIO.

     Andrew
