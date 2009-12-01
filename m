From: tbarr@multitech.com (Tim Barr)
Date: Tue, 1 Dec 2009 09:16:23 -0600
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
Message-ID: <1CD05B980C94AC408B37C82BBABAA3E6129306D9@mtsexchange.dc.multitech.prv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One point of interest, I have checked both Atmel EK designs
(9260 and 9G20) and they both use PA10 and PA11 for EMAC EXT2
and EXT3. Since the EK boards are built to use the RMII version
of the EMAC interface, the pin assignments of PA23 and PA24 in 
the kernel were not much of an issue. But since my design uses
MII for part cost and EMI issues, I have to change the pin
assignments.

Tim Barr
Development Engineer

Multi-Tech Systems, Inc.

> On Mon, Nov 30, 2009 at 10:04 PM, Tim Barr 
> <tbarr@multitech.com> wrote:
> > I see a bigger problem here. It is more of an issue of how to
> > handle signals that have more than one pin assignment option.
> Yes, that's the point.
> Moreover, according to my own (perhaps limited) knowledge, at 
> least the at91 machine dependent code provides a good glue 
> code almost only for boards which are quite similar to the 
> reference design. The problem is that instead each SoC allows 
> for different signal routing.
> 
