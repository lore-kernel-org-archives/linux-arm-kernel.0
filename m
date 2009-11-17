From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 17 Nov 2009 10:17:13 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <OF29677297.CAA27B00-ON65257671.002E6F4B-65257671.002E6F5C@tcs.com>
References: <20091117071744.GM14091@buzzloop.caiaq.de>
	<20091110064900.GK14091@buzzloop.caiaq.de>
	<20091104131500.GZ14091@buzzloop.caiaq.de>
	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
	<OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>
	<OF409EDC40.B7ED8C90-ON65257671.001667E7-65257671.001667F5@tcs.com>
	<OF29677297.CAA27B00-ON65257671.002E6F4B-65257671.002E6F5C@tcs.com>
Message-ID: <20091117091713.GN14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 01:57:11PM +0530, Vadivelan M wrote:
>  Did you measure the junk characters or the 'working' serial output. The
>  question is whether the baud rate really changes.
>           -- Yes. we have measured the baud rate when the junk characters starts coming.

Then the only explanation I have is that something seriously crashes
your userspace binaries and makes the kernel go wild.

>  Please send in patches of your modifications so people here can have a
>  look to what you did.
>           -- Please find the patches [please find the attachment . ]

I don't get what you're doing and why. Why do you patch around in
vmalloc.h? What reason is there to modify the clock framework for that
platform? And Those patches are obvisouly agains version 2.6.19.2 and
not mainline? Without any word of elaboration, I'm afraid you're on your
own.

My suggestion is to take the MX27ADS platform which your kernel config
is made for and try the current mainline kernel on that hardware.
Without any of your patches. Then find out the difference between that
setup and your own board.

Albeit I don't have such hardware, but I'm quite confident the reference
platform works well. Maybe someone of the MX2 people can acknowledge that.

Daniel
