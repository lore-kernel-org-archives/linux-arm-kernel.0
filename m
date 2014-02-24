From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 13:26:48 +0100
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <12776368.fUp5TWIUAS@wuerfel>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <1786282.mNUF0ZaUg2@wuerfel>
 <20140212161206.GD25957@e106331-lin.cambridge.arm.com>
 <12776368.fUp5TWIUAS@wuerfel>
Message-ID: <CACRpkdYKOTn9+6c6hJaoUq8pCJBpZrC_JF1AZJyt=Gt67WE4Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 5:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Ok. Both ssp{0,1}clk and spi{0,1,2,3}clk /only/ appear in
> arch/arm/boot/dts/ste-dbx5x0.dtsi and are clearly a bug, so unless
> Linus Walleij has objections, I'd declare those to be bugs that
> should be fixed by changing the DT file to spi_clk.

OK I'll fix. But didn't Mark just say that the preferred name should be
SSPCLK?

Here is the PL022 TRM:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0194g/index.html

The clock name on the silicon side is clearly "SSPCLK" so let's
stick with this.

Yours,
Linus Walleij
