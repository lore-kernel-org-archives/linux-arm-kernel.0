From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 27 Feb 2012 20:02:21 +0100
Subject: [PATCH v2 5/6] ARM: LPC32xx: serial.c: HW bug workaround
In-Reply-To: <4F4BA31F.8040201@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
 <1330184118-10270-6-git-send-email-stigge@antcom.de>
 <20120227141430.GB3550@pengutronix.de> <4F4BA31F.8040201@antcom.de>
Message-ID: <083DF309106F364B939360100EC290F81F365B2AD1@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> If you have a reference (errata ID or similar) it would be nice to
>> have it in the comment and description.
>
>Can you please help out with this one?
>
>In the LPC32xx errata, there is a note about a similar HS UART issue,
>but this one here (Standard UART) must be a different one (or it's a
>bug and the fix is actually targeted at HS UART).
>
>I actually just ported this code from lpclinux.com and assumed that
>NXP knows best about LPC HW bugs. ;-)

There isn't any errata related to this, but something strange was
happening with the serial ports (only in Linux) if I didn't do this.
I stumbled across a 'bug' comment in the pnx4008 port related to
serial, tried the same fix, and the problem went away, so I
(incorrectly) keyed in the errata wording.

Here's the original comment from the ARM pnx4008 port (serial.c):
  48         /* Send a NULL to fix the UART HW bug */
  49         __raw_writel(0x00, UART5_BASE_VA);
  50         __raw_writel(0x00, UART3_BASE_VA);

The HSUART errata is not related to this.

>Thanks in advance,
>
>Roland
