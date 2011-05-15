From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 May 2011 08:42:07 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<201105132135.34741.arnd@arndb.de>
	<BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
Message-ID: <201105150842.07816.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 May 2011, Will Drewry wrote:
> Depending on integration, it could even be limited to ioctl commands
> that are appropriate to a known fd if the fd is opened prior to
> entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
> with a filter of "1" then narrowed through a later addition of
> something like "(fd == %u && (cmd == %u || cmd == %u))" or something
> along those lines.
> 
> Does that make sense?

Thanks for the explanation. This sounds like it's already doing all
we need.

	Arnd
