From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 4 May 2018 19:14:25 +0200
Subject: [PATCH net-next v2 03/13] net: phy: sfp: warn the user when no
 tx_disable pin is available
In-Reply-To: <ed267042-1a61-7fcc-13ee-3cad2c05c658@gmail.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-4-antoine.tenart@bootlin.com>
 <ed267042-1a61-7fcc-13ee-3cad2c05c658@gmail.com>
Message-ID: <20180504171425.GA17233@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 10:07:53AM -0700, Florian Fainelli wrote:
> On 05/04/2018 06:56 AM, Antoine Tenart wrote:
> > In case no Tx disable pin is available the SFP modules will always be
> > emitting. This could be an issue when using modules using laser as their
> > light source as we would have no way to disable it when the fiber is
> > removed. This patch adds a warning when registering an SFP cage which do
> > not have its tx_disable pin wired or available.
> 
> Is this something that was done in a possibly earlier revision of a
> given board design and which was finally fixed? Nothing wrong with the
> patch, but this seems like a pretty serious board design mistake, that
> needs to be addressed.

Hi Florian

Zii Devel B is like this. Only the "Signal Detect" pin is wired to a
GPIO.

	Andrew
