From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 27 May 2012 02:32:57 +0000
Subject: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
In-Reply-To: <1338048678-23991-1-git-send-email-stigge@antcom.de>
References: <1338048678-23991-1-git-send-email-stigge@antcom.de>
Message-ID: <201205270232.58253.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 May 2012, Roland Stigge wrote:
> Hi,
> 
> this is how the modified FIFO is handled in the repositories at
> git.lpclinux.com. Is there a better way for doing this (without ifdef)?  Looks
> like registering additional types (like PORT_16550A) isn't encouraged.  Maybe
> extending of_serial.c? The latter currently doesn't handle .fifosize and
> .tx_loadsz, though.
> 
> Any suggestions appreciated.

We occasionally add new types, and I think that would be ok here too, if it's
actually a new type. It definitely doesn't look like a 16550.

I wonder if it's in fact a PORT_16654, or if we can at least pretend it's one.
	
	Arnd
