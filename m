From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jul 2013 15:20:09 +0100
Subject: Audio issue on Kirkwood t5325: no sound
In-Reply-To: <20130718134330.5aea00c5@skate>
References: <20130718134330.5aea00c5@skate>
Message-ID: <20130718142009.GX24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 01:43:30PM +0200, Thomas Petazzoni wrote:
> As part of some work around audio support on Marvell platforms, I've
> taken the Kirkwood-based HP t5325 thin client device that Martin
> Michlmayr kindly gave me and tried to use the audio part of it, with
> kernel 3.11-rc1. (My plan is to write the Device Tree binding for this
> audio driver, and then use it for Armada 370 based platforms).

A couple of basic things to check:

1. /proc/asound/card0/pcm0p/sub0/status

Does this indicate that the hw_ptr and appl_ptr are updating ?

2. /proc/interrupts

Are you getting interrupts for kirkwood-i2s ?

That will confirm whether the I2S unit is reading data from the ring
buffer.  I suspect these will be a positive yes, given that aplay
appears to work normally except being muted.

Another thing to check is the DAPM status, which you can find buried
in /sys/kernel/debug/asoc - check all the DAPM status you can find
below there, and check whether you think it's reasonable.
