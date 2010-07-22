From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 22 Jul 2010 17:15:31 +0200
Subject: Kernel 2.6.33: PXA270 Audio does not resume after resume from
	suspend state
In-Reply-To: <AANLkTiloYpM6LBNFHOfHGdvoHZ03cavW8vdmVZjHxSKC@mail.gmail.com>
References: <AANLkTiloYpM6LBNFHOfHGdvoHZ03cavW8vdmVZjHxSKC@mail.gmail.com>
Message-ID: <20100722151530.GI17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 08, 2010 at 10:38:36AM -0400, Shane Volpe wrote:
> I have upgraded an embedded system (PXA270) to the 2.6.33 kernel (from
> 2.6.23).  Now when I run an audio program (ogg123) and put the system
> into standby then wake the system up the audio does not work (continue
> playing) after resume until I terminate ogg123 and start again.  After
> restarting ogg123 the audio works fine with out reseting the system or
> changing anything else on the system.
> 
> The system is using the UCB1400 AC97 codec and just as added
> information when the audio is locked up, after resume, the touchscreen
> on the system still works which is also controlled by the UCB1400
> audio codec.  I have also tried several other audio players and the
> results are the same.   Has anyone else seen this bug and does anyone
> have suggestions on further tests to perform to narrow down were the
> bug may reside?

I've had similar issues some time ago. However, we used I2S over SSP for
our system, not AC97, and suspend/resume works fine now.

You may have a look at commit 026384d614b ("ASoC: fix PXA SSP port
resume") and check whether something similar must be done for the AC97
controller part.

Daniel
