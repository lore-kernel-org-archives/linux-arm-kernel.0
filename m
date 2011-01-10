From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 10 Jan 2011 16:43:07 +0100
Subject: AT91: Fix power-saving in idle-mode on 926T processors
In-Reply-To: <1294673540l.26200l.0l@i-dmzi_al.realan.de> (Anders Larsen's
	message of "Mon, 10 Jan 2011 16:32:20 +0100")
References: <AANLkTimGTVybe4LmspxWj6vkM_zNnPcaUbk6sqvpJ032@mail.gmail.com>
	<1294673540l.26200l.0l@i-dmzi_al.realan.de>
Message-ID: <87fwt069ys.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Anders" == Anders Larsen <al@alarsen.net> writes:

Hi,

 >> Is there a known interaction with this and the JTAG controller?

 Anders> indeed there is - disabling the processor clock blocks JTAG debugging.

Ok - And apparently it completely blocks the JTAG controller, so you
cannot even put it in bypass mode and access other devices on the same
JTAG chain.

 >> I haven't had time to look closer into it yet, but with this applied
 >> I can no longer access an Altera FPGA on a chain shared with a 9G45
 >> through Quartus.

 Anders> If you boot with the kernel parameter "nohlt", arch_idle() is
 Anders> not called, and JTAG should work again (but of course power
 Anders> consumption will be substantially higher).

 Anders> This was noted by Uwe Kleine-K?nig in
 Anders> https://lkml.org/lkml/2010/5/5/342

Thanks.

-- 
Bye, Peter Korsgaard
