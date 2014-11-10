From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 12:39:23 -0800
Subject: [PATCH] ARM: dts: dra7-evm: Keep all VDD rails always-on
In-Reply-To: <54579476.10702@ti.com>
References: <1413902290-304-1-git-send-email-nm@ti.com> <54579476.10702@ti.com>
Message-ID: <20141110203922.GX31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [141103 06:44]:
> Hi Nishant,
> 
> On 10/21/2014 05:38 PM, Nishanth Menon wrote:
> > DRA7 Data Manual (SPRS857L - August 2014) section 4.1.1 states: "All
> > unused power supply balls must be supplied with the voltages specified
> > in the Section 5.2, Recommended Operating Conditions".
> > 
> > This implies that all unused voltage rails for Vayu can never be
> > switched off even if the hardware blocks inside that voltage domain is
> > unused. Switching off these unused rails may result in stability issues
> > on other domains and increased leakage and power-on-hour impacts.
> > 
> > J6eco-evm dts file already considers this, however j6evm-dts file needs
> > to be fixed to consider this constraint of the SoC.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>
> 
> I'm assuming that vddshv8 (MMC1 power group) can be switched off.

Applying into omap-for-v3.19/dt thanks.

Tony
