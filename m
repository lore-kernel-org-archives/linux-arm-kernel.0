From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Aug 2014 16:53:15 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add bootargs setting the correct
 serial console
In-Reply-To: <2705570.zMztYghUV0@diego>
References: <5084600.YbBVvXy6Ug@diego> <201408041929.36275.arnd@arndb.de>
 <2705570.zMztYghUV0@diego>
Message-ID: <201408051653.16054.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 August 2014, Heiko St?bner wrote:
> Am Montag, 4. August 2014, 19:29:36 schrieb Arnd Bergmann:
> > On Monday 04 August 2014, Heiko St?bner wrote:
> > > Uart2 seems to be designated debug uart for all Rockchip platforms.
> > > On all rk30xx and rk31xx boards I've seen so far, this uart was used
> > > for the console and the rk3288 TRM even describes it as debug uart.
> > > 
> > > Thus add it to the core SoC dtsi files to not duplicate the same
> > > information on every board.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > Shouldn't this be done through the /aliases node for the port selection
> > and the current-speed property for the bit rate?
> 
> hmm, I'm not sure I understand this ... especially how this would relate to 
> aliases.
> 
> From reading around a bit I guess teaching the 8250_dw about 
> add_preferred_console and using "linux,stdout-path" would be the better way?
> 

I didn't realize this was 8250_dw rather than the regular of_serial/8250
driver. Yes, it should use "linux,stdout-path". Ideally we'd do this from
common code somewhere. At the time when I wrote of_serial for PowerPC, we
didn't have to worry about UARTS that are something other than 8250, but
of course now we have plenty of different ones.

	Arnd
