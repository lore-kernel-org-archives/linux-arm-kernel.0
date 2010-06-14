From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jun 2010 10:47:40 +0100
Subject: Request review of device tree documentation
In-Reply-To: <1276508170.2552.43.camel@pasglop>
References: <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<1276408773.1962.574.camel@pasglop>
	<AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
	<20100614073828.GA6095@n2100.arm.linux.org.uk>
	<4C15DE2E.1050905@firmworks.com>
	<20100614092559.GA7881@n2100.arm.linux.org.uk>
	<1276508170.2552.43.camel@pasglop>
Message-ID: <20100614094740.GB7881@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 14, 2010 at 07:36:10PM +1000, Benjamin Herrenschmidt wrote:
> However, there's a lot of room for abuse here and I'm worried that if it
> becomes widespread, we'll start seeing vendors use that as a way to do
> some kind of HAL and hide various platform methods in there (clock
> control, nvram, etc...).

This is what I'm worried about too.

As I said in my first reply in this thread, calling out from the kernel
will kill performance due to the time taken to shut down the caches and
MMU, which can only be done safely with all exceptions turned off.

The only time that it can be seriously considered is if you're calling
out to reboot, shutdown or kexec.
