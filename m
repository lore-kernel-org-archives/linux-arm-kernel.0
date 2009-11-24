From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 25 Nov 2009 00:45:21 +0100
Subject: IXP425: help on HSS channelized service
In-Reply-To: <4B0BDFC1.7010506@kaskonetworks.it> (Davide Di Gesualdo's message
	of "Tue, 24 Nov 2009 14:29:37 +0100")
References: <4B0BDFC1.7010506@kaskonetworks.it>
Message-ID: <m3d437bi7i.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Davide Di Gesualdo <davide.digesualdo@kaskonetworks.it> writes:

> I'm writing a kernel module for a HSS channelized service on IXP425
> processor, based on ixp4xx_hss. I'm developing on a IXDPG425 Intel
> board, and the HSS bus is attached to four Si3210 ProSLIC chips.
> The purpose of this module is to read/write from/to HSS 8-byte buffers
> in raw mode (no particular alignment is required). In write direction,
> everything seems ok: if I write a buffer like
> char buf[] = {0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb};
> on a fixed timeslot and then read the TXD pin signal with a scope, I
> can see the correct waveform at the correct place; I've also tried to
> write a tone with a fixed freqeuncy, and I've listened it correctly.
> The problem comes with read direction: I've tried to make a loopback
> by copying the rxbuffer in the txbuffer, but I can't hear my voice
> back (instead I hear something like a continous buzz). I'm quite sure
> I read the rxbuffer in the correct way (I do the same when I write
> txbuffer, which works properly!).

The buffers have different structures for RX and TX.

> This is the ISR for HSS
> read-complete interrupt:

Looks like a modified code from one of my ixp4xx-[0-9][0-9] branch. Have
you tried using the original code in e.g. ixp4xx-31? You may need to
make some trivial changes related to "MVIP".

Not that my channelized HSS code is flawless or something, far from it,
but it works, both directions.
-- 
Krzysztof Halasa
