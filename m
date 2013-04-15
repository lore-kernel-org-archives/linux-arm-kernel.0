From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Apr 2013 17:15:45 +0100
Subject: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <516ACA7D.60807@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org> <20130414141015.GC27394@pengutronix.de>
 <516AC305.2000800@tabi.org> <20130414152016.GE27394@pengutronix.de>
 <516ACA7D.60807@tabi.org>
Message-ID: <20130415161544.GH15837@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 10:25:49AM -0500, Timur Tabi wrote:

> Ah, so this is a work-around for a bug, where the codec is
> incompatible with the SoC?  Mark, are you familiar with this issue?
> Is there a way to reconfigure the codec so that it works better with
> the SoC?  It seems ridiculous to add all this code just because an
> incompatible codec was chosen for some board.

It's a limitation in the SoC - it sort of tries to bodge AC'97 in but
doesn't do a great job of it and can't handle the idea that there's
multiple streams of data on the bus.  This isn't something that can be
configured in the CODEC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130415/17c01bc8/attachment.sig>
