From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Mon, 23 Nov 2009 18:07:14 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <20091117123935.GV14091@buzzloop.caiaq.de>
References: <20091117091713.GN14091@buzzloop.caiaq.de>
	<20091117071744.GM14091@buzzloop.caiaq.de>
	<20091110064900.GK14091@buzzloop.caiaq.de>
	<20091104131500.GZ14091@buzzloop.caiaq.de>
	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
	<OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>
	<OF409EDC40.B7ED8C90-ON65257671.001667E7-65257671.001667F5@tcs.com>
	<OF29677297.CAA27B00-ON65257671.002E6F4B-65257671.002E6F5C@tcs.com>
	<OF8F8BC118.05889ED4-ON65257671.0041E186-65257671.0041E18F@tcs.com>
	<20091117123935.GV14091@buzzloop.caiaq.de>
Message-ID: <ba4215e10911230907s78e4bdfftc8cba93857ae9fca@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Assuming this is the reference hardware which you're running on, others
> should be able to reproduce this error. Unfortunately I can't help here,
> as I don't have access to any MX2 based hardware. Anyone else?
>

Mainline (2.6.32rc5) works fine on MX21 for me.

I also have a MX27 based board (Eukrea CPUMX27 module not a ADS) which
worked fine on 2.6.30 (haven't tried since - could do so if no one
else has a ADS handy).

I think it was mentionned somewhere in the thread but what is user
space doing? - didn't see any reference to init=/bin/sh in the kernel
command line log.

Another idea would be to patch drivers/serial/imx.c so that
imx_set_termios() and imx_setup_ufcr() are NOPs; that should leave the
UART config as the bootloader set it - which seems to work.

[even though the bit time is correct maybe its a word format error...]

Martin
