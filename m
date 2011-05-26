From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 26 May 2011 06:27:52 +0000
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
Message-ID: <20110526062752.GA14622@localhost.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  On Mon 2011-05-16 10:36:05, James Morris wrote:
> On Fri, 13 May 2011, Ingo Molnar wrote:
> How do you reason about the behavior of the system as a whole?
> 
> 
> > I argue that this is the LSM and audit subsystems designed right: in the long 
> > run it could allow everything that LSM does at the moment - and so much more 
> > ...
> 
> Now you're proposing a redesign of the security subsystem.  That's a 
> significant undertaking.
> 
> In the meantime, we have a simple, well-defined enhancement to seccomp 
> which will be very useful to current users in reducing their kernel attack 
> surface.

Well, you can do the same with subterfugue, even without kernel
changes. But that's ptrace -- slow. (And it already shows that syscall
based filters are extremely tricky to configure).

If yu want speed, seccomp+server for non-permitted operations seems like reasonable way.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
