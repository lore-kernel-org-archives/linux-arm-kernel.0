From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Jan 2013 20:17:30 +0800
Subject: [PATCH 6/6 v14] gpio: Add block gpio to several gpio drivers
In-Reply-To: <CAOY=C6H5xETt5UNXUfRkGW9q+bj0y2R3sXNvW87XXvQcYoL_-g@mail.gmail.com>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-7-git-send-email-stigge@antcom.de>
 <CAOY=C6H5xETt5UNXUfRkGW9q+bj0y2R3sXNvW87XXvQcYoL_-g@mail.gmail.com>
Message-ID: <20130124121726.GQ4955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 01:02:38PM +0100, Stijn Devriendt wrote:

> As a fictive example, consider the i2c-bitbang driver, which you could optimize
> by using block-gpio with sda/scl in a single block. By offering the
> block-gpio API
> even when you cannot set all bits at once, you could cause timing issues.
> You might be toggling the clock line before pushing out data, for example.

> The same holds below, for a driver that has separate hi/lo bits.

If there's a strict ordering requirement on updates then I would expect
a user to explictly code that in hardware otherwise there may be
hardware level issues with unpredictable results; besides in general it
seems silly to force users to open code both versions if they don't want
to rely on this API.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/6f8b79d6/attachment.sig>
