From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jul 2018 21:36:34 +0200
Subject: [PATCH 7/7] net: phy: Add pm support for scan ctrl register to
 bcm mdio mux
In-Reply-To: <170a4731-b091-aef4-2d66-2950114e41fc@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-8-git-send-email-arun.parameswaran@broadcom.com>
 <20180726192050.GJ10686@lunn.ch>
 <170a4731-b091-aef4-2d66-2950114e41fc@broadcom.com>
Message-ID: <20180726193634.GM10686@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 12:33:05PM -0700, Arun Parameswaran wrote:
> 
> 
> On 18-07-26 12:20 PM, Andrew Lunn wrote:
> > On Thu, Jul 26, 2018 at 11:36:24AM -0700, Arun Parameswaran wrote:
> >> Add support for saving and restoring the 'scan control' register
> >> in the Broadcom iProc mdio mux driver.
> > 
> > Hi Arun
> > 
> > I don't see anything setting this register. So why is it necessary to
> > save it over suspend/resume?
> > 
> >      Andrew
> > 
> Hi Andrew
> In the Omega SoC (only), this register was defaulted incorrectly (to use
> a test mode) by the hardware. So we added the setup of the register to
> the early bootloader (ATF).
> 
> We still need to restore this register while resuming from sleep.

Hi Arun

It is better to not rely on the bootloader and have the driver do it.
That makes it easier for people to swap to alternative bootloaders.

     Andrew
