From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Oct 2009 08:39:46 +0100
Subject: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
In-Reply-To: <2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
	<4ADC4D4D.5020508@gmail.com>
	<20091019120744.GB7412@n2100.arm.linux.org.uk>
	<2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com>
Message-ID: <20091020073946.GB723@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 11:21:40PM -0500, Nelson Castillo wrote:
> There is one case where "whatever way" fails here. If you get a set of
> points and you notice they have noise you can schedule more
> conversions _right_away_ without latency to get new points from the
> ADC. That's what the "group filter" does and you can not do that from
> tslib and I say it after learning how to write tslib filters.

In which case people aren't implementing their kernel drivers correctly.
The kernel is supposed to produce a stream of samples when the pen is
touched, and those samples should be delivered to tslib.  tslib's filters
then has the responsibility to read groups of samples, and filter them
using whatever method that the user wants.

I also don't buy your comparison on your web page since there's almost
zero details of what you're comparing.  You don't give details of what
filters you're using with the userspace method - for all the reader
knows, you're not using tslib at all.

> Most people who hear about the filters blindly say "this should be
> done in user-space" without considering this fact.

I'm the original author of tslib.  Don't think for a moment that I haven't
any experience in this area.
