From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jul 2014 18:56:20 +0200
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20140726155659.GA22977@fifteen>
References: <20140726155659.GA22977@fifteen>
Message-ID: <20140726165620.GA29269@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 26, 2014 at 07:56:59PM +0400, Evgeniy Dushistov wrote:
> The problem is that hardware handled by arm/plat-orion/gpio.c,
> require ack for edge irq, and no ack for level irq.

Hi Evgeniy

Thanks for the problem report and patch. What device are you using?
An Orion5x based board or mv78xx0? Those are the only two left using
this code.

Thanks
	Andrew
