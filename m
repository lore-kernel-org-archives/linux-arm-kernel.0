From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 01 Sep 2011 21:32:27 +0200
Subject: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry checking
	for each DAIs separately
In-Reply-To: <4E5FD5EB.50009@freescale.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>	<65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>	<4E5E1285.8020508@ti.com>
	<4E5E213A.8040909@freescale.com>	<4E5E264B.8000004@metafoo.de>
	<4E5FD5EB.50009@freescale.com>
Message-ID: <4E5FDDCB.9060709@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2011 08:58 PM, Timur Tabi wrote:
> Lars-Peter Clausen wrote:
>> Without the patch for example 'aplay -r 8000 ... & arecrod -r 16000 ...' would
>> result in playback running twice as fast as it is supposed to.
> 
> I'm not sure I can reproduce the problem.  Executing the above command either
> plays audio at the proper rate (with or without your patch), doesn't play
> anything at all (it just sits there), or gives me this error message:
> 
> soc-audio soc-audio: set sample size in capture stream first
> 
> (sometimes it says "playback" instead of "capture").

Try to add a small delay between the two commands. e.g. 'aplay -r 8000 ... &
sleep 1; arecrod -r 16000 ...'. And of course the DAIs need to be configured to
be asynchronous, otherwise you'll of course catch the error in the fsl_ssi driver.
