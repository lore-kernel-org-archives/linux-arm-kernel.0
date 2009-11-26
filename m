From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 26 Nov 2009 20:39:33 +0100
Subject: IXP425: help on HSS channelized service
In-Reply-To: <200911261543.08448.schindele@nentec.de> (Juergen Schindele's
	message of "Thu, 26 Nov 2009 16:43:07 +0200")
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<m3d437bi7i.fsf@intrepid.localdomain>
	<200911261543.08448.schindele@nentec.de>
Message-ID: <m3y6ltt6ru.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juergen Schindele <schindele@nentec.de> writes:

>> The buffers have different structures for RX and TX.
> This was a very good hint :-). I discovered that the 
> "struct desc" used in the kernel mainline driver is quite 
> different from the one used in INTEL code !?????.

Actually I meant the structures for channelized I/O RX and TX.

> When I replace the "struct desc" (see below) it works fine for me.
> Isn't there a general problem with this driver when it works only 
> for channelized mode (your case) ???

It most certainly works in packetized (HDLC) mode.

Perhaps you're using IXP46x/43x CPU and the new firmware (3.x)?
The driver works with fw 2.4 (and some older), i.e. the last firmware
which works with IXP42x and 46x/43x.
-- 
Krzysztof Halasa
