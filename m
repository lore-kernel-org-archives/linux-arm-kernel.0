From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Jan 2016 14:32:11 -0200
Subject: imxfb does not turn on automatically
In-Reply-To: <20160111071631.GI13058@pengutronix.de>
References: <CAOMZO5CZ3aFGbfb39XoXpFvbn4TTrCbTHOXtQKruruCis3Ptvw@mail.gmail.com>
 <CAD7j7Q8gANUxM5zGmn3YyhUr9yZv02x4oxi_WWLnxCYemBRYZA@mail.gmail.com>
 <20160111071631.GI13058@pengutronix.de>
Message-ID: <CAOMZO5C9MtteWQMaXUF2M+BLr5=PgWUSgrYn1gES2S8jzDhdFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Jan 11, 2016 at 5:16 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Unfortunately this LCD controller does not have an enable bit. The
> controller starts directly when the clocks are enabled. If the clocks
> are enabled when the controller is not yet programmed with proper
> register values then it just goes into some undefined state. What I
> suspect is that the clocks already were enabled before driver probe,
> presumably by the bootloader, so the controller is already in undefined
> state when entering Linux. Now by dis/enabling the ipg clock you
> effectively reset the controller. Since you have programmed it with
> valid register values in the mean time it starts working after this
> reset.
> To verify you could try to disable the LCDC related clock gates with
> direct register writes in drivers/clk/imx/clk-imx25.c.

Excellent! I did as you suggested and now the LCD turns on by default.

U-boot was enabling the LCD IPG clock.

Will submit a formal patch soon.

Thanks!
