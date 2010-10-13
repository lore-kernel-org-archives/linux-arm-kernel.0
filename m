From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Oct 2010 17:21:39 +0200
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <201010131721.39623.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 October 2010, Daniel Walker wrote:
> Many of JTAG debuggers for ARM support DCC protocol over JTAG
> connection, which is very useful to debug hardwares which has no
> serial port. This patch adds DCC serial emulation and the console
> support. System timer based polling method is used for the
> emulation of serial input interrupt handling.
> 
> Most of the code was taken from Hyok S. Choi original work, but the
> inline assmebly needed some work and updating. It now supports ARMv7.
> Also the description above is from Hyok also.
> 

Sorry to join in late, but why would you want to make this a "serial"
driver when it really is just a dumb tty.

I think you would be much better off making it a "hvc" driver, where
you just need to provide a read character and write character function
and an optional interrupt handler but otherwise have the common hvc
code take care of polling the hardware and talking to the tty layer.

	Arnd
