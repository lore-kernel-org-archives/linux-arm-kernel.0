From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 3 Dec 2017 17:06:58 +0100
Subject: [PATCH v2] ARM: dts: Add ethernet PHYs to the a bunch of Geminis
In-Reply-To: <20171203150457.21774-1-linus.walleij@linaro.org>
References: <20171203150457.21774-1-linus.walleij@linaro.org>
Message-ID: <20171203160658.GB7878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 03, 2017 at 04:04:57PM +0100, Linus Walleij wrote:
> These Gemini boards have Ethernet PHY on GPIO bit-banged
> MDIO, clearly defined in the corresponding OpenWRT
> ethernet patches since ages. Add them in accordance with
> the OpenWRT patch so we can use them when we add ethernet
> support.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This is good as is, but i just wonder if the mdio node can be moved
into the .dtsi file. Four from six have the exact same setup. So i'm
guessing the reference design has been copied. So it is likely the
other two at the same. So you could move the mdio, set it to status
disable, and have these board enable it in their .dts file.

    Andrew
