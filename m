From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 13 May 2011 16:29:27 +0100
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	callfiltering
In-Reply-To: <1305299880.2076.31.camel@localhost.localdomain>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ... If you can be completely stateless its easier, but there's
> a reason that stacking security modules is hard.  Serge has tried in
the
> past and both dhowells and casey schaufler are working on it right
now.
> Stacking is never as easy as it sounds   :)

For a bad example of trying to allow alternate security models
look at NetBSD's kauth code :-)

NetBSD also had issues where some 'system call trace' code
was being used to (try to) apply security - unfortunately
it worked by looking at the user-space buffers on system
call entry - and a multithreaded program can easily arrange
to update them after the initial check!
For trace/event type activities this wouldn't really matter,
for security policy it does.
(I've not looked directly at these event points in linux)

	David
