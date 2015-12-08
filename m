From: hadess@hadess.net (Bastien Nocera)
Date: Tue, 08 Dec 2015 13:14:51 +0100
Subject: [PATCH 0/2] input: Driver for Goodix GT801 2+1 touchscreen
In-Reply-To: <1449473161-3535-1-git-send-email-plaes@plaes.org>
References: <1449473161-3535-1-git-send-email-plaes@plaes.org>
Message-ID: <1449576891.28364.15.camel@hadess.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-12-07 at 09:25 +0200, Priit Laes wrote:
> This series adds support for Goodix GT801 2+1 touchscreen controller
> and hooks it up on Gemei G9 tablet.
> 
> Now about GT801 2+1 - I initially tried to implement this inside the
> existing Goodix driver, but unfortunately there are too many small
> bits and pieces that would make the otherwise simple driver a
> complicated mess:
> ? - endianness differences of coordinate readouts
> ? - totally different touch protocol
> ? - configuration layout and version information
> ? - I2C register differences (2 bytes vs single byte)

The goodix driver will get more complicated after we merge Irina's
patchset. Instead of looking at the differences between the protocols,
which don't look insurmountable (a switch statement in a few places,
right?), you should look at the code you could share:
- power management
- ESD support
- ACPI support
- the support for variants in goodix.c (911-variants, and 967-variants)
- ability to read and write config data to the device

Taking this into account (and the fact that I can't read Chinese that
well, so my reading of the specs is cursory), would it make sense to
merge the 2 drivers?

CC'ing Irina about this.

Cheers
