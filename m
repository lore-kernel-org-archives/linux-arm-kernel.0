From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jun 2017 17:08:29 +0100
Subject: [PATCH 1/2] arm64: dts: marvell: fix USB3 regulator definition
 on MacchiatoBin
In-Reply-To: <20170623154014.20573-1-thomas.petazzoni@free-electrons.com>
References: <20170623154014.20573-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170623160829.GU4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 05:40:13PM +0200, Thomas Petazzoni wrote:
> Due to the lack of GPIO support, the USB3 regulator definition was
> left unfinished in the MacchiatoBin DT description. Now that GPIO
> support is available, this commit adjusts the Device Tree to properly
> describe the USB3 regulator.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

If you weren't soo keen with your NIH patches, then you wouldn't be
making a mistake here...

Now, from what you've said on IRC, I know that you're more than happy
to fetch my git tree and test it on your board, and I've already stated
in a previous thread that I'm happy for people to take the DTS patches
I have in that branch, but still you persist in creating your own (and
in this case broken) patches.

While it _may_ work for you, it is not correct to the binding doc.

Now, you could have taken these three patches from my tree (which I
know you have from what you said on IRC):

  arm64: dts: marvell: mcbin: add GPIO
  arm64: dts: marvell: mcbin: add pinctrl nodes
  arm64: dts: marvell: mcbin: add gpio binding include file

which apply cleanly on top of arm-soc, and tested them with your gpio
and pinmux work.  In fact, these three patches are solving the exact
problem you have here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
