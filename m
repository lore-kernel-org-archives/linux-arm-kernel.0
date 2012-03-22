From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Mar 2012 11:23:26 +0800
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <20120320224021.GF29317@pengutronix.de>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
 <20120320072018.GC32469@S2101-09.ap.freescale.net>
 <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
 <20120320094031.GI3852@pengutronix.de>
 <e22898bc8b69e85f1e6390d7d858f85c.squirrel@www.codeaurora.org>
 <20120320181441.GO3852@pengutronix.de>
 <4F68E53B.7040800@codeaurora.org>
 <20120320224021.GF29317@pengutronix.de>
Message-ID: <20120322032323.GA2213@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 11:40:21PM +0100, Sascha Hauer wrote:
> On Tue, Mar 20, 2012 at 01:14:51PM -0700, Saravana Kannan wrote:
...
> > Ah, I see. That's a lot of functions calls. I think it would be much
> > more efficient if you just have an array and loop over it. With my
> > patch, you can just call a single register function for all these
> > clocks.
> 
> I was curious and gave it a try. I registered a fixed clock and 100
> gates as child clocks. I tried both DEFINE_CLK_GATE and
> clk_register_gate. It turned out there was no difference in speed.
> 
While there is no difference in speed efficiency, I think we will
gain space efficiency if we can have Saravana's patch to copy the
clk_hw fields and make the static array __initdata as you mentioned.

-- 
Regards,
Shawn
