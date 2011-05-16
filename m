From: mingo@elte.hu (Ingo Molnar)
Date: Mon, 16 May 2011 14:00:43 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <201105150842.07816.arnd@arndb.de>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<201105132135.34741.arnd@arndb.de>
	<BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
	<201105150842.07816.arnd@arndb.de>
Message-ID: <20110516120043.GA7128@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 14 May 2011, Will Drewry wrote:
> > Depending on integration, it could even be limited to ioctl commands
> > that are appropriate to a known fd if the fd is opened prior to
> > entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
> > with a filter of "1" then narrowed through a later addition of
> > something like "(fd == %u && (cmd == %u || cmd == %u))" or something
> > along those lines.
> > 
> > Does that make sense?
> 
> Thanks for the explanation. This sounds like it's already doing all
> we need.

One thing we could do more clearly here is to help keep the filter expressions 
symbolic - i.e. help resolve the various ioctl variants as well, not just the 
raw syscall parameter numbers.

But yes, access to the raw syscall parameters and the ability to filter them 
already gives us the ability to exclude/include specific ioctls in a rather 
flexible way.

Thanks,

	Ingo
