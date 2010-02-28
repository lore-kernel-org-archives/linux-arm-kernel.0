From: bgat@billgatliff.com (Bill Gatliff)
Date: Sat, 27 Feb 2010 21:23:39 -0600
Subject: AC97 audio broken on SAM9263EK?
In-Reply-To: <4B86AA29.8010806@atmel.com>
References: <4B85789D.6000704@billgatliff.com> <4B864C66.6060209@atmel.com>
	<4B867108.2050806@billgatliff.com> <4B86AA29.8010806@atmel.com>
Message-ID: <4B89E1BB.6090504@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sedji Gaouaou wrote:
> Hi Bill,
>
> Here is the patch for the ac97 support on AT91:
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025629.html
>
>
> Here is the patch for the full duplex support:
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025628.html
>

Hmm.  I applied both patches to 2.6.33-rc5.  There were two local
variables "err" and "ptcr" that weren't defined, which I corrected.  And
then there was this:

 CC      sound/atmel/ac97c.o
sound/atmel/ac97c.c: In function ?atmel_ac97c_capture_trigger?:
sound/atmel/ac97c.c:545: warning: unused variable ?casr?
sound/atmel/ac97c.c: In function ?atmel_ac97c_pcm_new?:
sound/atmel/ac97c.c:743: error: ?at91_ac97_pcm_defs? undeclared (first
use in this function)
sound/atmel/ac97c.c:743: error: (Each undeclared identifier is reported
only once
sound/atmel/ac97c.c:743: error: for each function it appears in.)
sound/atmel/ac97c.c:743: warning: type defaults to ?int? in declaration
of ?type name?
sound/atmel/ac97c.c:743: warning: type defaults to ?int? in declaration
of ?type name?
sound/atmel/ac97c.c:743: error: negative width in bit-field ?<anonymous>?
make[2]: *** [sound/atmel/ac97c.o] Error 1


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
