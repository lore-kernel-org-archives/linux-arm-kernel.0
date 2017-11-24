From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Nov 2017 15:26:27 +0100
Subject: [PATCH 2/5] gpio: pca953x: Name the gpiochip after the I2C address
In-Reply-To: <20171124093045.5961-3-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
 <20171124093045.5961-3-linus.walleij@linaro.org>
Message-ID: <20171124142627.GG30167@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 10:30:42AM +0100, Linus Walleij wrote:
> Just putting the name of the I2C device as name for the
> GPIO chip (label) is ambigous, and makes it hard for us
> to use GPIO descriptor tables on systems such as DaVinci
> DA850EVM which has two chips but on I2C address 0x20 and 0x21.
> 
> Instead, append "-XX" to the GPIOchip name using the I2C
> address so we get a unique chip name that can be used
> in descriptor tables, such as "tca6416-20" and
> "tca6416-21" on the DaVinci DA850EVM.

Hi Linus

Are you making the assumption that there are not two devices at the
same address but on different I2C busses?

How safe is that assumption? Can you include the adapter ID in the
string?

	Andrew
