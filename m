From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Sep 2015 15:21:05 +0200
Subject: [PATCH] arm: Handle starting up in secure mode
In-Reply-To: <20150826103940.GD6281@e103592.cambridge.arm.com>
References: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
 <20150826103940.GD6281@e103592.cambridge.arm.com>
Message-ID: <CACRpkda1mD1SO25NL=K-SqOUAtXGj=X+v6oaOSbSVJEdfAXZ0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 12:39 PM, Dave Martin <Dave.Martin@arm.com> wrote:

> Shouldn't the bootloader or firmware be doing this stuff, and if not,
> why not?

Firmware yes, bootloader no, or maybe.

Bootloaders IMO loads in images, checksum, even public key check or
whatever, then sets up the basics and boot them.

Some hacks in U-Boot install PSCI handlers. It is neat, but a hack:
a piece of code is compiled to a special offset and copied there
by U-Boot to install the PSCI handlers. I would be fine if that software
was not compiled as part of U-Boot, but another binary loaded by it.

This would be another such "neat hack" also leaving a minimal
monitor behind IIUC.

I see the simplicity it brings to compile a load of stuff into U-Boot,
but eahhhhhhh...

Yours,
Linus Walleij
