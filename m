From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Feb 2013 08:40:05 -0800
Subject: [PATCH 3/5] arm: dts: omap4-panda: Add I2c pinctrl data
In-Reply-To: <511BBA1B.9050501@ti.com>
References: <1360747710-1532-1-git-send-email-sourav.poddar@ti.com>
 <511BB7CE.1020505@ti.com> <511BBA1B.9050501@ti.com>
Message-ID: <20130213164004.GE7144@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130213 08:10]:
> On 02/13/2013 09:57 AM, Jon Hunter wrote:
> > On 02/13/2013 03:28 AM, Sourav Poddar wrote:
> > 
> > A quick look at the data manual shows that omap4430 and omap4460 has the
> > same pin mux options for i2c. Furthermore, the data manual shows only
> > one mux option for i2c1-4. Therefore, should these mux options be placed
> > in omap4.dtsi? Boards not using specific i2c controllers can disabled
> > them in there board dts file (same way we do for mmc).
> 
> I guess for i2c, a given omap4 board may use external pull-ups and not
> use the internal ones and so putting this in the omap4.dtsi may not be
> desirable. However, it seems that a common omap4-panda.dtsi could be
> used here.

Yes the mux options need to be board specific. If something is complex
and  common, it's best to put it into omap4-i2c1.dts file that can be
included from the board specific .dts files as needed.

Regards,

Tony
