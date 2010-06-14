From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 14 Jun 2010 19:36:10 +1000
Subject: Request review of device tree documentation
In-Reply-To: <20100614092559.GA7881@n2100.arm.linux.org.uk>
References: <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com> <1276408773.1962.574.camel@pasglop>
	<AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
	<20100614073828.GA6095@n2100.arm.linux.org.uk>
	<4C15DE2E.1050905@firmworks.com>
	<20100614092559.GA7881@n2100.arm.linux.org.uk>
Message-ID: <1276508170.2552.43.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-14 at 10:25 +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 13, 2010 at 09:45:50PM -1000, Mitch Bradley wrote:
> > None of this is a deal-breaker for the kind of debugging tasks that are  
> > the primary use case for the callback.
> 
> Would you mind explaining what kind of tasks these callbacks will
> be used for?

That's one of the thing I'm "touching" on in my previous reply...

(For those who didn't quite follow, the discussion here is about
allowing a real Open Firmware implementation on ARM with the feature of
leaving OF alive while the OS is up, which is something sparc does but
we never supported on ppc).

Ideally, if you keep open firmware alive, you can drop into it when the
kernel crashes for example, or in some other circumstances.

However, there's a lot of room for abuse here and I'm worried that if it
becomes widespread, we'll start seeing vendors use that as a way to do
some kind of HAL and hide various platform methods in there (clock
control, nvram, etc...).

Another option Mitch mentioned is to have the f-code interpreter (f-code
is OF tokenized forth format) in the kernel, but that doesn't completely
solve the problem of providing it with appropriate virtual mappings,
arbitrating access to HW resources, etc etc etc

OF as a FW/bootloader is great. OF alive along with the OS can be a nice
debugging tool under some circumstances but I am a bit more dubious as
to whether that's going to work out in practice. But I'd like to -not-
see it abused as some kind of HAL.

Cheers,
Ben.
