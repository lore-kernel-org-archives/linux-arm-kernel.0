From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Mar 2015 06:58:06 +0100
Subject: [PATCH 1/2] ASoC: cygnus-audio: adding device tree bindings
In-Reply-To: <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Message-ID: <20150331055806.GB2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 08:16:23PM -0700, Scott Branden wrote:

> +SSP Subnode properties:
> +- dai-name: The name of the DAI registered with ASOC

ASoC.

Why is this in the DT - it sounds like this is just an internal
implementation detail for Linux, not a property of the hardware.

> +- mode: Controls if this port should be configured as I2S or TDM mode.
> +	Valid values are: "tdm" or "i2s"
> +- tdm-bits-per-frame:  only if mode is "tdm" then this property must set.
> +	Valid values are (128/256/512)

We'd normally leave these up to the machine driver to set as they're
link wide things for system integration.  The bits per frame in
particular looks like something that's not going to be fixed by the
hardware and could be varied at runtime.

> +- port-status: Controls if port is enabled or not
> +	Valid values "enabled" or "disabled"

This sounds like it's replicating the DT standard status property?

> +- channel-group: Control grouping of serial port
> +	Valid values are "2_0", "3_1", or "5_1"

What does this mean?  It looks like it's setting the number of channels
which again seems like a runtime thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/7473ab86/attachment.sig>
