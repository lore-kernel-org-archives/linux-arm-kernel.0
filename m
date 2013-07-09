From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 16:01:14 +0100
Subject: [PATCH v4 2/7] Documentation: DT: add sam9x5ek-wm8731 machine
 driver
In-Reply-To: <1373379933-32749-3-git-send-email-richard.genoud@gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-3-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130709150114.GB27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 04:25:28PM +0200, Richard Genoud wrote:
> This add the sound DT binding for sam9x5ek-wm8731 machine driver
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |   30 ++++++++++++++++++++

Put new binding documents in the same patch that reads them, this makes
review easier.

> +  - atmel,audio-routing: A list of the connections between audio components.

This needs to be more specific and list the available board specific
nodes for routing.  For the CODEC you can just refer to the CODEC
binding documentation.

> +  - atmel,format: DAI format. Must be "i2s"

So why not just omit this then?

> +  - atmel,bitclock-master:  DAI clock master
> +  - atmel,frame-master: DAI frame master

The driver isn't handling these and there's no information on how to set
them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/dcbf9701/attachment.sig>
