From: lexa@cfotr.com (lexa)
Date: Mon, 25 Feb 2013 11:34:51 +0400
Subject: Debugging missing interrupts
Message-ID: <1361777691.4640.34.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello.

I have a trouble with debugging SSC interface(or maybe with audio
codec). I have a board based on Atmel AT91 (at91sam9m10g45) and codec TI
tlv320aic3106(using driver tlv320aic3x) connected to SSC interface in
I2S mode.
Playback is works well, but the capture cause trouble.
The problem is that arecord don't capture any data, he just writes wav
header and nothing more. 
Interrupt counter on ssc0 does not increased during capture.
Also i checked data and clock lines by oscilloscope, and clearly see
that clock and data transmitting from audio codec during capture.

It's seem to me, that cpu somewhat doesn't accept data from codec. But i
don't understand why, and how to debug this.

I know that provided information is insufficient, but i simply don't
know how to get more detailed information about this problem.
