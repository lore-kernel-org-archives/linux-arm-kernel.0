From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 29 Aug 2010 14:35:01 +0200
Subject: [PATCH 3/3 v2] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <20100828161858.GI1473@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<20100823174852.GB26928@pengutronix.de>
	<AANLkTimmEKfErV17RWNBO-pVCfFtFw=yJL2v92UBN0=2@mail.gmail.com>
	<201008281727.10913.marek.vasut@gmail.com>
	<20100828161858.GI1473@pengutronix.de>
Message-ID: <AANLkTimhFAhR3sSJWo3b8_rMk5GCQfOwG0T36uEs=DjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/28 Sascha Hauer <s.hauer@pengutronix.de>:

> Peripherals integrated into a SoC like the SDMA engine here are
> normally accessible in native endianess and thus need the __raw_*
> functions.

So the SDMA actually switch and twist around the endianness of
its registers if it's synthesized into a bigendian version of the system?

Or hardware-dynamically even depending on the setting of the
endianness bit in the ARM core?

How can that possibly even work...

But I'm still impressed by the statemachines some silicon
engineers come up with so wouldn't surprise me. X-)
I understand the code now atleast. Our hardware is always
synthesized LE so we so handily use [read|write][b|w|l]
everywhere, luckily.

Yours,
Linus Walleij
