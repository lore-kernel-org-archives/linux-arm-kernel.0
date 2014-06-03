From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Jun 2014 22:59:44 +0100
Subject: [alsa-devel] [PATCH] ASoC: pxa: add I2C dependencies as needed
In-Reply-To: <87k38xg0k6.fsf@free.fr>
References: <46560700.2S4p0nUZl8@wuerfel>
 <87k38xg0k6.fsf@free.fr>
Message-ID: <20140603215944.GB2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 11:12:09PM +0200, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:

> > To shut this up for good, this adds the dependency to every board
> > that uses I2C as the interface to the codec. I have gone through
> > all board files and verified that they all either use AC97 or
> > I2C, and this annotates the latter. Some of these already enable
> > I2C from mach-pxa/Kconfig, but since that can change it's better
> > to be explicit here.

> Any reason SND_PXA2XX_SOC_MIOA701 escaped ? The board is PXA based, and its
> codec wm9713 is I2C based, and relies on AC97.

The WM9713 is AC'97 only, there's no I2C interface there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/a45d7e02/attachment.sig>
