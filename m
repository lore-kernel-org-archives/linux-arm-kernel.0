From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jan 2014 17:16:27 +0000
Subject: New randconfig build failure: rx51 asoc / gpiolib
In-Reply-To: <20140117131257.GB15937@n2100.arm.linux.org.uk>
References: <20140117131257.GB15937@n2100.arm.linux.org.uk>
Message-ID: <20140120171627.GW17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 01:12:58PM +0000, Russell King - ARM Linux wrote:
> Last night's omap randconfig found this.  This has only appeared in the
> builds in the last few days, so it's a new regression for the changes
> queued up for merge window:

Really?  The relevant change is quite old...  it is possible some other
thing removed a select though so gpiolib can now be unset.

> which is caused by "struct snd_soc_jack_gpio" not being defined.  For
> some reason, this structure is defined in sound/soc.h, but is
> conditionalised upon CONFIG_GPIOLIB.

> This means either the dependencies on SND_OMAP_SOC_RX51 are incorrect
> (they don't include a dependency on GPIOLIB) or ASoC is wrong to make
> the definitions conditional upon GPIOLIB.

I'd add the dependency here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/e6087ac6/attachment.sig>
