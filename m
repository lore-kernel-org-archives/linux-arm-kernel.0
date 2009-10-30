From: gerardk5@verizon.net (Gerard Kam)
Date: Fri, 30 Oct 2009 15:08:42 -0700 (PDT)
Subject: at91sam9260 on linux 2.6.31 with at91 patchset: UART looses bytes
	when receiving packets
In-Reply-To: <4AEB216F.7080006@gmail.com>
Message-ID: <594305.67002.qm@web84306.mail.re1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there

--- On Fri, 10/30/09, Stefan Schoenleitner <dev.c0debabe@gmail.com> wrote:

> I have a at91sam9260 based development board with a Rev.B
> controller sitting on it.
> On this board I use UART0 in raw mode with no flow control
> to connect to
> a DSP board and exchange data packets.
> While the UART generally seems to be working it seems to
> loose bytes
> from time to time when receiving.
> 
> Interestingly is is *always the same byte* on the same
> position in the stream that is lost.

By "same position in the stream" do you mean "same position in the packet"?
What is the byte position?

What is the baud rate? 

> Did anyone on this list had similar problems ?
> Do you have suggestions how I can find out what's wrong and
> fix the problem ?

Maybe use HW flow control?
I'm using at91sam9260 rev A, kernel 2.6.28 and USART0 in raw mode, CTSRTS enabled and 111,111 baud (the device cannot do 115200).  The packets (16 to 400 bytes) have CRC32 checksums, and I haven't seen a single lost byte. 

Regards
