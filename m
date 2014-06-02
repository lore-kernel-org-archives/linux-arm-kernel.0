From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Jun 2014 23:16:27 +0100
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <538CA635.4050502@ziswiler.com>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
 <538CA24B.1010602@wwwdotorg.org> <538CA635.4050502@ziswiler.com>
Message-ID: <20140602221627.GP31751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 06:28:37PM +0200, Marcel Ziswiler wrote:
> On 06/02/2014 06:11 PM, Stephen Warren wrote:

> >>+CONFIG_SPI_SPIDEV=y

> >Is this useful with DT? I thought that unlike I2C_CHARDEV, spidev needed
> >dummy devices to exist in DT for spidev to work? If so, there's not much
> >point adding the option to defconfig, since people can add it when they
> >put the dummy devices into DT.

> Yes, the Apalis T30 DT I sent actually contains two of them which we call
> generic Apalis SPI1 and SPI2 out-of-the-box configured for exactly that.
> Without the config enabled though it probably does not make much sense to
> include it in the DT so I would consider removing it again.

Your DT is broken if it's got a "spidev" node in it, you should be
describing the hardware not the Linux implementation of the software.
It would be really nice if we had a good way of handling this but we
don't yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/6e5c3da7/attachment.sig>
