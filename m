From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 May 2018 11:44:27 -0700
Subject: [PATCH] ARM: Fix i2c-gpio GPIO descriptor tables
In-Reply-To: <20180526163734.30098-1-linus.walleij@linaro.org>
References: <20180526163734.30098-1-linus.walleij@linaro.org>
Message-ID: <20180526184427.72kopk2u2ncexxbs@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2018 at 06:37:34PM +0200, Linus Walleij wrote:
> I used bad names in my clumsiness when rewriting many board
> files to use GPIO descriptors instead of platform data. A few
> had the platform_device ID set to -1 which would indeed give
> the device name "i2c-gpio".
> 
> But several had it set to >=0 which gives the names
> "i2c-gpio.0", "i2c-gpio.1" ...
> 
> Fix the offending instances in the ARM tree. Sorry for the
> mess.
> 
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Simon Guinot <simon.guinot@sequanux.org>
> Reported-by: Simon Guinot <simon.guinot@sequanux.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for fixes if
> it check out fine.
> (The fact that it took so long to discover tells us something
> about how used these board files are.)

Applied to fixes, I've got one last batch going in today so I'll include it
there.



-Olof
