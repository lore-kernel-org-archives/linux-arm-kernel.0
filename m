From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2009 12:25:52 +0100
Subject: [PATCH 2/9] collie: prepare for gpiolib use
In-Reply-To: <20091007110805.GA7656@rainbow>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<20091007110805.GA7656@rainbow>
Message-ID: <20091007112552.GC6246@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2009 at 03:08:05PM +0400, Dmitry Artamonow wrote:
> On 23:35 Mon 05 Oct     , Thomas Kunze wrote:
> > prefix gpio definitions for direct register access with '_' so we
> > can use the other names for gpio_request & co
> 
> Familiar problem - numeric vs bit-shifted gpio defines.
> I'm facing it here too while converting h3[16]00 to gpiolib,
> and I'm thinking about dropping bit-shifted defines completely
> and using GPIO_GPIO(SOME_NUMERIC_GPIO) instead.

What we did with PXA was to decide not to use definitions for the built-in
GPIOs - what's the point of:

#define GPIO0	0
#define GPIO1	1
#define GPIO2	2
...

It's a bit like:

#define NUMBER0	0
#define NUMBER1	1
etc.

Yes, there's a reason to if the number spaces are different, but for
the built-in GPIOs, they aren't.
