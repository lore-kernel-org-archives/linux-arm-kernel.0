From: eric@anholt.net (Eric Anholt)
Date: Wed, 13 Jul 2016 18:37:47 -0700
Subject: [PATCH 1/1] ASoC: bcm2835-i2s: Support 384k sample rate
In-Reply-To: <1466358739-31669-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
References: <1466358739-31669-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
Message-ID: <87k2gp80es.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clive Messer <clive.messer@digitaldreamtime.co.uk> writes:

> Add support for sample rates up to 384k to bcm2835-i2s driver,
> with SNDRV_PCM_RATE_CONTINUOUS and specifying 8k min and 384k max,
> for both playback and capture.

It looks like this should be OK -- the PCM clock should max out at
25Mhz, and that divided by 2*32 (max bclk_ratio) is just over 384k.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160713/2b525964/attachment.sig>
