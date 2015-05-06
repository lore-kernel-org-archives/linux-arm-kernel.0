From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 16:54:16 +0100
Subject: [PATCH] ARM: dts: cubox-i: add support for Broadcom
 Wifi/Bluetooth devices
In-Reply-To: <1430923179-25448-1-git-send-email-festevam@gmail.com>
References: <1430923179-25448-1-git-send-email-festevam@gmail.com>
Message-ID: <20150506155416.GX2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:39:39AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add DT support for the Broadcom Wifi/Bluetooth devices found on the
> microsom board.
> 
> [Modified original Russell King's patch to use mmc-pwrseq]

You should also mention that it's a bodge because you're permanently
enabling the regulators rather than controlling them from the mmc-pwrseq
stuff.

I would like to see a proper implementation rather than a bodge -
especially one which permanently enables the oscillator regulator,
thus having the oscillator output trying to drive a device which is
powered down, which will forward-bias the ESD diodes... which is not
a particularly nice thing to do.

So really that's a NAK on this.  Please do the job properly.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
