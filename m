From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 13 Oct 2010 09:17:03 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <201010131721.39623.arnd@arndb.de>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010131721.39623.arnd@arndb.de>
Message-ID: <1286986623.28336.3.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-13 at 17:21 +0200, Arnd Bergmann wrote:
> On Tuesday 05 October 2010, Daniel Walker wrote:
> > Many of JTAG debuggers for ARM support DCC protocol over JTAG
> > connection, which is very useful to debug hardwares which has no
> > serial port. This patch adds DCC serial emulation and the console
> > support. System timer based polling method is used for the
> > emulation of serial input interrupt handling.
> > 
> > Most of the code was taken from Hyok S. Choi original work, but the
> > inline assmebly needed some work and updating. It now supports ARMv7.
> > Also the description above is from Hyok also.
> > 
> 
> Sorry to join in late, but why would you want to make this a "serial"
> driver when it really is just a dumb tty.

The code has been around since 2003 I think, and Hyok wrote (not me)..
So I'm not sure why it's a serial driver. The only thing which I noted
in a prior email is that it uses takes over ttyS optionally, so that
might be part of the reason.

> I think you would be much better off making it a "hvc" driver, where
> you just need to provide a read character and write character function
> and an optional interrupt handler but otherwise have the common hvc
> code take care of polling the hardware and talking to the tty layer.

I don't know what the "hvc" driver is "Hypervisor Virtual Console"
maybe? Can you give any sort of example driver which does what you
suggesting?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
