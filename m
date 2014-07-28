From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Jul 2014 22:48:23 +0100
Subject: [PATCH 2/2] spi: orion: add support for multiple chip selects
In-Reply-To: <53D5ECCA.7030806@gmail.com>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <53D5ECCA.7030806@gmail.com>
Message-ID: <20140728214823.GI17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 08:25:14AM +0200, Sebastian Hesselbarth wrote:

> So, "num-cs" describes the number of *available* chip select signals. As
> they can comprise extra cs lines that are GPIO and not dedicated
> controller signals (native above), it cannot be something the driver
> knows.

Yes, indeed.  Though given that we also need a way to pass in the GPIOs
for the chip selects which isn't standardised at the minute it's all a
bit of a mess right now.

> As long as you only use native cs lines, omit the cs-gpios property, if
> there is any GPIO cs lines, insert <0> where you want native ones.

Right, something like that should be usable.  We also need a way to say
which native chip select to set when using a GPIO chip select if the
GPIO chip selects go beyond the native ones and none of the native ones
are masked by GPIOs.

> Although, I wonder how the driver learns about reg = <1> is actually the
> controller's cs0 in the example above?

Interesting question...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/d9928469/attachment.sig>
