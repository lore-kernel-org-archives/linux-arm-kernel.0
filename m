From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Nov 2011 14:30:40 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <20111122132055.GA32572@mudshark.cambridge.arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
 <20111122085834.GB19986@pengutronix.de>
 <20111122115017.GK20518@mudshark.cambridge.arm.com>
 <20111122130233.GF19986@pengutronix.de>
 <20111122132055.GA32572@mudshark.cambridge.arm.com>
Message-ID: <20111122133040.GG19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 01:20:55PM +0000, Will Deacon wrote:
> On Tue, Nov 22, 2011 at 01:02:33PM +0000, Uwe Kleine-K?nig wrote:
> > On Tue, Nov 22, 2011 at 11:50:17AM +0000, Will Deacon wrote:
> > > In the end I'd like to remove DEBUG_LL_UART_NONE. It's only there to service
> > > the platforms which have not yet added an entry to the choice.
> > Why not remove it already now? If I remove it together with the entry
> > for my machine and modify mach/debug-macro.S to do the right thing
> > for my machine even without DEBUG_IMX25_UART, my build just works.
> 
> I'm fairly sure this will break the build for everybody who doesn't have an
> entry in Kconfig.debug choice if they try and select DEBUG_LL.
Ah, I see the problem. It's more subtile than just failure to build: it
autoselects DEBUG_ICEDCC then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
