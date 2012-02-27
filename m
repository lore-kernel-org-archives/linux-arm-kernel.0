From: stigge@antcom.de (Roland Stigge)
Date: Mon, 27 Feb 2012 22:59:11 +0100
Subject: [PATCH v2 5/6] ARM: LPC32xx: serial.c: HW bug workaround
In-Reply-To: <083DF309106F364B939360100EC290F81F365B2AD1@eu1rdcrdc1wx030.exi.nxp.com>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
 <1330184118-10270-6-git-send-email-stigge@antcom.de>
 <20120227141430.GB3550@pengutronix.de> <4F4BA31F.8040201@antcom.de>
 <083DF309106F364B939360100EC290F81F365B2AD1@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <4F4BFCAF.4060204@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 27/02/12 20:02, Kevin Wells wrote:
> There isn't any errata related to this, but something strange was
> happening with the serial ports (only in Linux) if I didn't do this.
> I stumbled across a 'bug' comment in the pnx4008 port related to
> serial, tried the same fix, and the problem went away, so I
> (incorrectly) keyed in the errata wording.
> 
> Here's the original comment from the ARM pnx4008 port (serial.c):
>   48         /* Send a NULL to fix the UART HW bug */
>   49         __raw_writel(0x00, UART5_BASE_VA);
>   50         __raw_writel(0x00, UART3_BASE_VA);

Hard to trace since pnx4008's serial.c contains it since the beginning
in 2006.

OTOH, you added a bit more than this to lpc32xx' serial.c.

Anyway, I guess that PNX4008's and LPC3200's standard UARTs share some
ideas, NXP internally. ;-)

Roland
