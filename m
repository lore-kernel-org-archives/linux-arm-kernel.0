From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Nov 2011 09:58:34 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111122085834.GB19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Aug 19, 2011 at 12:56:59PM +0800, Shawn Guo wrote:
> Now that the DEBUG_LL UART can be selected by a Kconfig choice,
> simplify the #ifdefery in debug-macro.S and add entries to the
> top-level Kconfig.debug instead.
now that this patch is in Linus' tree as
f350b86121c7a004a5f866333fa1d23fe30263a6, this breaks the build when
selecting DEBUG_LL_UART_NONE (as our autobuilder did somehow). Maybe
that is OK because DEBUG_LL is an expert option? If not, either the
autoselection has to return or DEBUG_LL_UART_NONE shouldn't be
selectable for imx.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
