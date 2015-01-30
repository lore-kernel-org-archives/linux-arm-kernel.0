From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Jan 2015 17:28:32 -0200
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5CTaqzs2bwXL4V9boMSjOw6TcGBLXe9U=9-wEvwfvGYeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 5:20 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> According to i.MX23 and i.MX28 reference manual [1],[2] the fractional
> clock control register is 32-bit wide, but is separated in 4 parts.
> So write instructions must not apply to more than 1 part at once.
>
> The clk init for the i.MX28 violates this restriction and all the other
> accesses on that register suggest that there isn't such a restriction.
>
> This patch restricts the access to this register to byte instructions and
> extends the comment in the init functions.
>
> Btw the imx23 init now uses a R-M-W sequence just like imx28 init
> to avoid any clock glitches.
>
> The changes has been tested with a i.MX23 and a i.MX28 board.
>
> [1] - http://cache.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
> [2] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
