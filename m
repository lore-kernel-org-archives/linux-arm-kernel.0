From: jyrios@die.upm.es (Jorge Yesid Rios Ortiz)
Date: Fri, 24 Jun 2011 20:31:05 +0200
Subject: I can' t compile a new kernel version
Message-ID: <1308940265.2194.77.camel@sacarino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi:

I have a little problem about update my kernel version.

I have a M501 evaluation board kit:

CPU: ATMEL AT91RM9200, with MMU
Clock: 180MHz
SDRAM: 32MB (16MB user space)
Flash: 16MB (12MB user space)
USB Host: x2, USB 2.0 compliant

In this moment, I have 2.6.16-M5 version (it's very old, I Know).  I
would like to compile a new version, basically because I need to use a
Camera with this board.

Camera:
ID 041e:4058
model: Live! Cam Optia AF
manufacturer:  Creative Technology, Ltd

This cams works very fine when I used it on my PC with Linux, but when I
plugged to my embedded system I get this message:

usb 1-2: new full speed USB device using at91rm9200-ohci and address 5
usb 1-2: Manufacturer: Creative Labs
uvcvideo: Found UVC 1.00 device <unnamed> (041e:4058)
uvcvideo: Non-zero status (-110) in status completion handler.


Laurent Pinchart, Wrote to me this:
<<According to /usr/include/asm-generic/errno.h, -110 is -ETIMEDOUT.
According to Documentation/usb/error-codes.txt, -ETIMEDOUT means
"Synchronous USB message functions use this code to indicate timeout
expired 
before the transfer completed, and no other error was reported by HC."

Try to upgrade to a recent kernel because your kernel is more than 5
years ago.>>

I tried update many times the linux's kernel and different versions of
kernels  (2.6.18, 2.6.20, 2.6.22, 2.6.24....2.6.38 ) and basically I
can't do it for this reasons:


1) the toolchains is very old (3.3.2 version).  I wrote to ARTILA's
support tech  asking about a new toolchain because I need to compile a
newer kernel and your answers was: "this is the last toolchains for your
board, you must to use this". I download different versions of ARM's
toolchains (like code sourcery lite version
http://www.codesourcery.com/sgpp/lite/arm  and others more), this
toolchains isn't working for me and my embedded system.


2) Russell King on this site wrote this:
<<Downloading an ARM patch: You only need this step if you are using a
kernel prior to 2.6.0-test2. There are no -rmk or -vrs patches for later
kernels.>>

I suppose that recent versions of kernel has support for ARM
architecture, but, when I tried to compile different versions of
kernels, always I obtain different errors.

3) On ARTILA ftp site, the "last kernel version" is 2.6.14-M5 kernel
version update to septembre 15 / 2010, I think. (for me it's a bad joke
to say "last kernel version" to a 2.6.14 version).


Finally, Laurent Pinchart (he is a Linux kernel developer and He has
written the Linux UVC driver which supports several hundreds of webcams)
explains to me about the error load:

<<According to /usr/include/asm-generic/errno.h, -110 is -ETIMEDOUT.
According to Documentation/usb/error-codes.txt, -ETIMEDOUT means

"Synchronous USB message functions use this code to indicate timeout
expired  before the transfer completed, and no other error was reported
by HC."

I'm surprised to see this error code reported in a URB completion
handler.>>

I read something about URB (The basic idea of the new driver is message
passing, the message itself is called USB Request Block, or URB for
short)  and I  don't know what I must to be for to solve this error.


If you have some idea about how to compile a new kernel's version I
appreciated Very much.


Jorge
