From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:30:18 +0200
Subject: [PATCH 6/9] ARM: ux500: Provide device enumeration number suffix
 for SMSC911x
In-Reply-To: <1368019749-19455-7-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYz0HcdBovoJu6O-4QyRbXz93MaeWwAwCohbE8rv=8O7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:

> First Ethernet device has a ".0" appended onto the device name. It
> appears that we need this in order to obtain the correct clock.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
(...)
> -       OF_DEV_AUXDATA("smsc,lan9115", 0x50000000, "smsc911x", NULL),
> +       OF_DEV_AUXDATA("smsc,lan9115", 0x50000000, "smsc911x.0", NULL),

I guess what you want to say in the commit message is that
on a non-DT boot the ethernet will be named "smsc911x.0"
and since the clocks are not converted to device tree these
names need to be matched when providing the name from
auxdata.

Edited the commit message and applied!

Yours,
Linus Walleij
