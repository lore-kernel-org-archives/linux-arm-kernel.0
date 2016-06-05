From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 5 Jun 2016 14:04:29 -0500
Subject: [PATCH 2/3] tty: serial: msm: Only configure MND registers on hw
 that has it
In-Reply-To: <20160512010228.21548-3-sboyd@codeaurora.org>
References: <20160512010228.21548-1-sboyd@codeaurora.org>
 <20160512010228.21548-3-sboyd@codeaurora.org>
Message-ID: <20160605190429.GH13357@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 06:02:27PM -0700, Stephen Boyd wrote:
> The registers that msm_serial_set_mnd_regs() writes only exist on
> the non-uartdm hardware, so let's return early here if this
> function is called on uartdm hardware. This also prevents us from
> messing up the uartclk variable if the uartclk rate happens to be
> 19.2 or 4.8 MHz.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
