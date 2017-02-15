From: stefan@agner.ch (Stefan Agner)
Date: Tue, 14 Feb 2017 23:25:34 -0800
Subject: sDMA on i.mx7d
In-Reply-To: <20170214222425.hbkfkeq3l6sveo7n@piout.net>
References: <20170214222425.hbkfkeq3l6sveo7n@piout.net>
Message-ID: <e9c36a33f2a49df2a517db5869eaea7f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 2017-02-14 14:24, Alexandre Belloni wrote:
> Hi,
> 
> I've been trying to get a PCM3168s codec with a Colibri iMX7 using TDM
> on SAI2.
> I've got it working properly with the 4.1.35 kernel from Toradex (based
> on the 4.1.15 from Freescale).
> It is working fine with and without providing a firmware to the sDMA.
> 
> But, I couldn't get that to work with v4.9. I actually managed to
> reproduce the issue using the SGTL5000 so I don't have any patch on top
> of v4.9.

I guess you are using the on module SGTL5000 to reproduce?

When I added audio support I remember that the sound seemed to be ok to
me. Is the corruption such that you can hear it?

> 
> I really suspect the DMA driver as the issue varies with the selected
> period/buffer size.
> 
> Basically, the samples in a period are in the correct order but the
> periods are mixed up.

Maybe a endian issue?

> 
> This is what I'm playing in a loop:
> http://free-electrons.com/~alexandre/source.png
> 
> This is the output I get:
> http://free-electrons.com/~alexandre/playback.png
> 
> The configuration for the cyclic transfer seems to be fine and I don't
> know enough about the sdma to investigate further.
> I can try to backport b7d2648ac3d4 "dmaengine: imx-sdma: Add i.MX7
> support" to v4.8 and test I you think that can be useful

I'll do a test with v4.9 on Colibri iMX7 internal SGTL5000.

--
Stefan
