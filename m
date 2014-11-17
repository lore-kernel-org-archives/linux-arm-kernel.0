From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Nov 2014 14:57:17 +0000
Subject: [PATCH] ASoC: samsung-i2s: Add 192kHz config option
In-Reply-To: <1416221874-22092-1-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1416221874-22092-1-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <20141117145717.GE2722@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 10:57:54AM +0000, Richard Fitzgerald wrote:
> Adds QUIRK_SUPPORTS_192KHZ to allow 192kHz rate
> to be selected for hardware that supports it.

> +- samsung,supports-192khz: specify this (without a value) if you want to allow
> +    192000 sample rate over the I2S link.

Two things here.  One is that the first half is a funny way of saying
"boolean property" (the other standard idiom is "present if...").  The
other is that "if you want to allow" suggests that this is a bit of
runtime configuration (which shouldn't be in device tree at all).  If
there's a quirk here it should be a fixed property of the hardware, if
this is a system integration choice then it should at most be specified
in the machine driver and the I2S controller should just advertise
whatever it's physically capable of.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/0859fd4a/attachment.sig>
