From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 May 2010 13:40:41 -0700
Subject: [PATCH v4 4/5(7)] input: serio: add support for Amstrad Delta
	serial keyboard port
In-Reply-To: <201004280310.52678.jkrzyszt@tis.icnet.pl>
References: <201004280252.58420.jkrzyszt@tis.icnet.pl>
	<201004280310.52678.jkrzyszt@tis.icnet.pl>
Message-ID: <20100504204041.GL29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100427 18:09]:
> The patch introduces a serio driver that supports a keyboard serial port found
> on the Amstrad Delta videophone board.
> 
> After initializing the hardware, the driver reads its input data from a buffer
> filled in by the board FIQ (Fast Interrupt Request) handler.
> 
> Standard AT keyboard driver (atkbd) will be used on top of the serio layer for 
> handling the E3 keyboard (called mailboard) connected to the port. Since the 
> device generated scancodes differ from what the atkbd expects, a custom key 
> code to scan code table must be loaded from userspace for the keyboard to be 
> useable.
> 
> Compiles and works on top of PATCH v4 3/5(7), "OMAP1: Amstrad Delta: use FIQ 
> for processing GPIO interrupts".

I'll add this series into omap for-next. Will also add Dmitry's ack
from the earlier series to this patch.

Regards,

Tony
