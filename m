From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 26 Jan 2015 11:33:29 -0300
Subject: perf not capturing stack traces
In-Reply-To: <20150126135406.GD11502@n2100.arm.linux.org.uk>
References: <20150123195128.GE26557@saruman.tx.rr.com>
 <20150123205959.GD3073@kernel.org>
 <20150123223745.GJ26557@saruman.tx.rr.com>
 <20150124151204.GF3073@kernel.org>
 <20150124222342.GA26941@saruman.tx.rr.com>
 <20150125155651.GB11502@n2100.arm.linux.org.uk>
 <20150126102711.GC15598@arm.com>
 <20150126121243.GA16629@kernel.org>
 <20150126135406.GD11502@n2100.arm.linux.org.uk>
Message-ID: <20150126143329.GA5906@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Jan 26, 2015 at 01:54:06PM +0000, Russell King - ARM Linux escreveu:
> On Mon, Jan 26, 2015 at 09:12:43AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 26, 2015 at 10:27:11AM +0000, Will Deacon escreveu:
> > > FWIW, perf can now use libunwind for unwinding the userspace side of
> > > things, so it's not quite as bad as it used to be. For the kernel side,
> > > if the unwinder isn't working properly it would be nice to know *why*,
> > > but I agree that it tends to be far flakier than the frame-pointer method.

> > Any idea why, with userspace using frame pointers, perf doesn't go all
> > the way from kernel to userspace main() (or whatever is the endpoint),
> > as Russel stated?
>            ^ *growl*

I misunderstood, as corrected on another message, sorry.
 
> I've rebuilt userspace code which I've been working on in with a bunch of
> flags which makes it use frame pointers in ARM mode, and perf does seem
> to be capable of that; in that case, perf_callchain_user() can walk the
> linked set of frames.
> 
> However, if glibc is built for thumb2 or doesn't contain frame pointers,
> userspace tracing pretty much stops after you hit the first function in
> userspace.

Right.

- Arnaldo
