From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jun 2012 10:59:03 -0600 (MDT)
Subject: [PATCHv2 11/12] ARM: OMAP4: clock data: add clockdomains for
 clocks used as main clocks
In-Reply-To: <4FD61C94.4030004@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004623.20034.52760.stgit@dusk> <4FD61C94.4030004@ti.com>
Message-ID: <alpine.DEB.2.00.1206111050430.5849@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Cousson, Benoit wrote:

> In fact, neither prm_clkdm not cm_clkdm are valid clock domain on OMAP4 
> :-(.
> 
> I've just realized that you introduced that for 3.5, but this is wrong. 
> We should not start adding some fake clock domains just because the fmwk 
> is not smart enough to allow a NULL clock domain.
> 

...

> In a period of data size reduction, adding some fake information does 
> not seems to be the right approach. Don't you think so?

No, I do not.

These clockdomains are clearly documented in both the OMAP4 TRM[1]
and the NDA OMAP4 PRCM functional specifications.

I continue to be baffled as to why you assert that they are fake, given 
how clearly they are documented.


- Paul

1. See for example sections 3.6.6.1 "Overview", Figure 3-58 "CD_L4_PER 
Overview", Figure 3-59 "CD_L3_INIT Overview", Figure 3-62 "CD_EMU 
Overview", Figure 3-63 "CD_DSS Overview", Figure 3-74 "CD_L4_ALWON_CORE 
Overview" in the OMAP4 TRM Rev. AA (SWPU231AA).
