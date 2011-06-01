From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Jun 2011 10:37:16 +0200
Subject: [PATCH 2/3] clocksource: add DB8500 PRCMU Timer support
In-Reply-To: <20110601083000.GD3660@n2100.arm.linux.org.uk>
References: <1306830661-9546-1-git-send-email-mattias.wallin@stericsson.com>
	<alpine.LFD.2.02.1105311236250.3078@ionos>
	<4DE51EB7.7010606@stericsson.com>
	<BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
	<20110601083000.GD3660@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimAOWNJNGJwJkCkwwDJ2BR__NCV+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, May 31, 2011 at 11:18:25PM +0200, Linus Walleij wrote:
>> Keeping it under include/linux is probably wise since we want drivers
>> OUT of the ARM tree, but I don't know if there is much consensus on that?
>
> Header files private to a driver should be alongside the driver. ?Look
> at drivers/net or drivers/scsi for plenty of examples.
>
> Just because its a header file does not mean it must be in some directory
> with 'include' in its path. ?The only reason to put it in include/linux
> is if it contains stuff which needs to be shared outside of the driver
> (eg, with arches).

I agree. Right now I have a creepy feeling that many drivers are just
putting headers in <mach/foo.h> out of habit, when plain "foo.h" in
working dir or <linux/subsystem/foo.h> is what is really apropriate.

Yours,
Linus Walleij
