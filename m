From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 13:44:02 +0200
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver
 code
In-Reply-To: <20160426111532.GA5457@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <6161197.8XCk69TI60@wuerfel>
 <20160426111532.GA5457@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <5608365.uloflbeuqO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 12:15:32 Peter Griffin wrote:
> > 
> > > If not what would you recommend instead? 
> > 
> > It's still not clear to me what that bit in the syscfg register
> > is for. Given the error message about "sti-audio-clk-glue",
> > I suspect that this is actually a clock controller and that
> > it should be using the clock binding with a separate driver
> > instead of manipulating the regmap directly from the audio driver.
> 
> Luckily I do have the datasheet for the audio-glue sysconf register.
> 
> It says: -
> 
> [11:8] PCM_CLK_SEL: Selects the frequency synthesizer clock or the external
> PCM clock for each channel.
> 
> The driver only ever sets this to 1 which selects the frequency synthesizer
> clock. So the bitfield of the register which the driver is using (PCM_CLK_SEL)
> is a clock mux.

Ok, that sounds like it could be either a really simple clock driver
with just a few lines, or integrated into an existing clock driver
if you already have one for this syscon node.

	Arnd
