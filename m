From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Jan 2015 15:29:18 +0000
Subject: [alsa-devel] [PATCH 2/3] ASoC: samsung: Document Trats2 audio
 subsystem bindings
In-Reply-To: <1420457117-11030-3-git-send-email-ideal.song@samsung.com>
References: <1420457117-11030-1-git-send-email-ideal.song@samsung.com>
 <1420457117-11030-3-git-send-email-ideal.song@samsung.com>
Message-ID: <20150105152918.GT11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 08:25:16PM +0900, Inha Song wrote:

> + - clocks : Reference to the codec master clock
> + - clock-names : The clock should be named "mclk"

This should be done in the CODEC driver, not in the machine driver - the
CODEC always needs the clock, it's not something specific to this
machine.  Even if we decide that for Linux the best thing to do is to
manage the clock in the machine driver it should be described in the DT
as being attached to the CODEC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/1b737f72/attachment.sig>
