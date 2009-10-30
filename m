From: dev.c0debabe@gmail.com (Stefan Schoenleitner)
Date: Fri, 30 Oct 2009 18:25:03 +0100
Subject: at91sam9260 on linux 2.6.31 with at91 patchset: UART looses bytes
	when receiving packets
Message-ID: <4AEB216F.7080006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a at91sam9260 based development board with a Rev.B controller
sitting on it.
On this board I use UART0 in raw mode with no flow control to connect to
a DSP board and exchange data packets.
While the UART generally seems to be working it seems to loose bytes
from time to time when receiving.

Interestingly is is *always the same byte* on the same position in the
stream that is lost.
I verified that the stream really contains all the bytes by sniffing the
TX pin on the DSP board at the same time.
While on the PC that is used for sniffing all bytes are received, the
sam9260 board misses the mentioned byte.

I looked into the errata section of the sam9260 datasheet as well.
For Rev.A chips there were some related UART problems but for my Rev.B
chip these errors seem to have been fixed.

Did anyone on this list had similar problems ?
Do you have suggestions how I can find out what's wrong and fix the
problem ?

One possibility to debug the problem that comes to my mind right now is
to add some debug code to the kernel so that I can see which bytes are
actually received from the uart controller itself.
If the data coming from the controller is the same as the data I receive
in my userspace application it has to be a hardware or hardware
configuration problem, right ?

cheers,
stefan
