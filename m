From: marex@denx.de (Marek Vasut)
Date: Sun, 28 Dec 2014 19:30:17 +0100
Subject: [PATCH V2] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
References: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <201412281930.17676.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 28, 2014 at 11:26:42 AM, Stefan Wahren wrote:
> According to i.MX23 and i.MX28 reference manual the fractional
> clock control registers must be addressed by byte instructions.
> 
> This patch fixes the erroneous 32-bit access to these registers
> and extends the comment in the init functions.
> 
> Btw the imx23 init now uses a R-M-W sequence just like imx28 init
> to avoid any clock glitches.
> 
> The changes has been tested only with a i.MX28 board, because i don't
> have access to an i.MX23 board.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

I don't see a problem,

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
