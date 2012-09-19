From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Sep 2012 11:43:20 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <20120919031526.GC6460@S2100-06.ap.freescale.net>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <20120919031526.GC6460@S2100-06.ap.freescale.net>
Message-ID: <201209191143.20508.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Wed, Sep 19, 2012 at 12:37:17AM +0200, Marek Vasut wrote:
> > Don't load the FEC MAC address from OCOTP, but use the one supplied
> > via device tree by U-Boot. This is the preferred way, every DT-capable
> > bootloader does set up "mac-address" and "local-mac-address" properties
> > into the DT passed to the kernel.
> 
> Ok, since you are the maintainer of m28evk board, it could be your call
> to do so.  While for imx28-evk, the kernel at least runs with bootlets
> which is not DT capable.

I believe most of the mx28evks run mainline U-Boot these days. Especially since 
there is much better support in upstream u-boot than in freescale one. So what 
about dropping this function altogether or make it DT-configurable?

[...]

Best regards,
Marek Vasut
