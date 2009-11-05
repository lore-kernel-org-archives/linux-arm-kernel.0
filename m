From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 5 Nov 2009 12:07:40 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <OFEF3C8131.8C4BB129-ON65257665.003C2B08-65257665.003C2B0A@tcs.com>
References: <20091104131500.GZ14091@buzzloop.caiaq.de>
	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
	<OFEF3C8131.8C4BB129-ON65257665.003C2B08-65257665.003C2B0A@tcs.com>
Message-ID: <20091105110740.GO14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Please do not remove anyone from Cc and do not post on top when
replying)

On Thu, Nov 05, 2009 at 04:27:11PM +0530, Prabha J wrote:
>    But in inittab ,we are not using any getty.

What you see is certainly not a crash - something obviously just changes
the baudrate. If you're not using getty, it's something else. Try
adding 'init=/bin/sh' to your kernel command line. That should dump you
directly to a shell without any further startup script processing. If
that works, your problem is not related to the kernel.

>    One more thing,
>    We have Linux-2.6.19.2 which is working on this board and we are using the
>    same root filesystem and the toolchain used also same.
>    We checked the clock and baudrate ,and it is correct.

Maybe the baud rate configured in the older kernel is different?
I don't know.

>    What else may be the problem.
>    Are we missing any configuration?
>    Between linux-2.6.19.2 and linux-2.6.28 there is lot of changes. Do we
>    have to change anything in the driver.

Which driver do you mean?

Daniel
