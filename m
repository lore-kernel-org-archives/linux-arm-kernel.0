From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 3 Apr 2018 17:01:39 +0200
Subject: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
In-Reply-To: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
Message-ID: <20180403150139.l7oec4doafmsidfp@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> - switch to generic recovery using minimal helpers to drive the SDA/SCL lines
>   directly

If you had added this incrementally, reviewing would have been easier (=
faster). The callbacks look okay...

> - don't recover on every error

... but you are now never recovering. You don't call i2c_recover_bus().

> - add patch to sanity check i2c_transfer() arguments in core code (#3)

See small comment there.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/817d23e9/attachment.sig>
