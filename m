From: al@alarsen.net (Anders Larsen)
Date: Mon, 10 Jan 2011 16:32:20 +0100
Subject: AT91: Fix power-saving in idle-mode on 926T processors
In-Reply-To: <AANLkTimGTVybe4LmspxWj6vkM_zNnPcaUbk6sqvpJ032@mail.gmail.com>
	(from jacmet@sunsite.dk on Mon Jan 10 16:05:36 2011)
References: <AANLkTimGTVybe4LmspxWj6vkM_zNnPcaUbk6sqvpJ032@mail.gmail.com>
Message-ID: <1294673540l.26200l.0l@i-dmzi_al.realan.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Peter,

On 2011-01-10 16:05:36, Peter Korsgaard wrote:
> On Thu, Oct 7, 2010 at 9:44 PM, Anders Larsen <al@alarsen.net> wrote:
> > According to Atmel, their 926T processors (AT91 post RM9200) requires
> > 'Wait for Interrupt' mode be entered right after disabling the processor clock
> > in order to minimise current consumption when idle, so do both provided we're
> > not running on a 920T (an RM9200).
> 
> Is there a known interaction with this and the JTAG controller?

indeed there is - disabling the processor clock blocks JTAG debugging.

> I haven't had time to look closer into it yet, but with this applied
> I can no longer access an Altera FPGA on a chain shared with a 9G45
> through Quartus.

If you boot with the kernel parameter "nohlt", arch_idle() is not called,
and JTAG should work again (but of course power consumption will be
substantially higher).

This was noted by Uwe Kleine-K?nig in https://lkml.org/lkml/2010/5/5/342

Cheers
Anders
