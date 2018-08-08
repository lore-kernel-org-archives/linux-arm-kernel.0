From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 8 Aug 2018 18:55:32 +0200
Subject: [PATCH v1 3/7] drivers: gpio: Add support for Turris Mox SFP GPIOs
In-Reply-To: <20180808152706.21727-4-marek.behun@nic.cz>
References: <20180808152706.21727-1-marek.behun@nic.cz>
 <20180808152706.21727-4-marek.behun@nic.cz>
Message-ID: <20180808165532.GJ7275@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 05:27:02PM +0200, Marek Beh?n wrote:
> The SFP cage GPIOs on the SFP cage module of Turris Mox can be
> configured via the moxtet bus.
> 
> This driver supports those GPIOs so that they can be used by phylink.

I don't see anything in this driver which is specific to SFP. It is
just a GPIO driver for 3 lines. So i would drop all references to SFP.
You can then use it to blink LEDs on some other module, etc.

     Andrew
