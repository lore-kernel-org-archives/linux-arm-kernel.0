From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 22 Sep 2010 12:48:46 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20100922104846.GQ32018@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:31 Wed 22 Sep     , Peter Korsgaard wrote:
> Use a correct udelay value to get bus speed around 100KHz. The udelay
> value was most likely copied from the older devices, but the 9g45
> is signicantly faster (400MHz, DDR, ..), so a udelay of 2 gives a
> bus speed of around 190KHz, which is too fast for some devices.
> A udelay value of 5 gives a bus speed of around 90KHz here.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
in this case it will be better to overwite it at board than force it for all
of them

Best Regards,
J.
