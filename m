From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Apr 2014 22:58:19 +0100
Subject: [PATCH] ARM: dts: imx27-pdk: Add PMIC support
In-Reply-To: <1397598912-5464-1-git-send-email-festevam@gmail.com>
References: <1397598912-5464-1-git-send-email-festevam@gmail.com>
Message-ID: <20140415215819.GA24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 06:55:12PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx27-pdk has a MC13783 PMIC connected to CSPI2 port.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

The issue I referred to in my reply to your oops does still need fixing
(and testing whether it fixes the oops.)

It's really not on to code drivers such that it's possible to use
resources before they are initialised.  That means mutexes and locks
must be initialised before requesting (threaded) IRQs if they're used
by those functions.

In your case, that mutex *definitely* needs initialisation before the
threaded IRQ handler is requested.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
