From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 May 2011 21:35:34 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <1305169376-2363-1-git-send-email-wad@chromium.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
Message-ID: <201105132135.34741.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 May 2011, Will Drewry wrote:
> This change adds a new seccomp mode based on the work by
> agl at chromium.org in [1]. This new mode, "filter mode", provides a hash
> table of seccomp_filter objects.  When in the new mode (2), all system
> calls are checked against the filters - first by system call number,
> then by a filter string.  If an entry exists for a given system call and
> all filter predicates evaluate to true, then the task may proceed.
> Otherwise, the task is killed (as per seccomp_mode == 1).

I've got a question about this: Do you expect the typical usage to disallow
ioctl()? Given that ioctl alone is responsible for a huge number of exploits
in various drivers, while certain ioctls are immensely useful (FIONREAD,
FIOASYNC, ...), do you expect to extend the mechanism to filter specific
ioctl commands in the future?

	Arnd
