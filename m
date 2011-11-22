From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Nov 2011 14:02:33 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <20111122115017.GK20518@mudshark.cambridge.arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
 <20111122085834.GB19986@pengutronix.de>
 <20111122115017.GK20518@mudshark.cambridge.arm.com>
Message-ID: <20111122130233.GF19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 11:50:17AM +0000, Will Deacon wrote:
> Hi Uwe,
> 
> On Tue, Nov 22, 2011 at 08:58:34AM +0000, Uwe Kleine-K?nig wrote:
> > On Fri, Aug 19, 2011 at 12:56:59PM +0800, Shawn Guo wrote:
> > > Now that the DEBUG_LL UART can be selected by a Kconfig choice,
> > > simplify the #ifdefery in debug-macro.S and add entries to the
> > > top-level Kconfig.debug instead.
> > now that this patch is in Linus' tree as
> > f350b86121c7a004a5f866333fa1d23fe30263a6, this breaks the build when
> > selecting DEBUG_LL_UART_NONE (as our autobuilder did somehow). Maybe
> > that is OK because DEBUG_LL is an expert option? If not, either the
> > autoselection has to return or DEBUG_LL_UART_NONE shouldn't be
> > selectable for imx.
> 
> In the end I'd like to remove DEBUG_LL_UART_NONE. It's only there to service
> the platforms which have not yet added an entry to the choice.
Why not remove it already now? If I remove it together with the entry
for my machine and modify mach/debug-macro.S to do the right thing
for my machine even without DEBUG_IMX25_UART, my build just works.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
