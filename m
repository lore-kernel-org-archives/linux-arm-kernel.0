From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 13:18:33 +0100
Subject: [PATCH 0/1] ARM: kirkwood: Convert the mplcec4 board to pinctrl
In-Reply-To: <50AA2118.7050700@mpl.ch>
References: <cover.1353319919.git.s.peter@mpl.ch>
 <20121119111838.GH10259@lunn.ch> <50AA2118.7050700@mpl.ch>
Message-ID: <20121119121833.GI10259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > What do you see in /debug/pinctrl/f1010000.pinctrl/pinmux-pins contain?
> > 
> > Since i have a second UART on my board i have:
> > 
> > pin 13 (PIN13): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp13
> > pin 14 (PIN14): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp14
> > 
> > but i would expect to see function sdio.
> 
> No, I see
> 
> pin 12 (PIN12): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 13 (PIN13): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 14 (PIN14): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 15 (PIN15): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 16 (PIN16): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 17 (PIN17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> 
> However, there is a phandle in pinctrl at 10000/pmx-sdio/

Humm..

Try enabling CONFIG_DEBUG_PINCTRL. It prints out a lot of debug as the
driver loads.

       Andrew
