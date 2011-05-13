From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 13 May 2011 17:23:01 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <1305299455.2076.26.camel@localhost.localdomain>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<1305299455.2076.26.camel@localhost.localdomain>
Message-ID: <1305300181.2466.72.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-13 at 11:10 -0400, Eric Paris wrote:
> Then again, I certainly don't see a
> reason that this syscall hardening patch should be held up while a whole
> new concept in computer security is contemplated... 

Which makes me wonder why this syscall hardening stuff is done outside
of LSM? Why isn't is part of the LSM so that say SELinux can have a
syscall bitmask per security context?

Making it part of the LSM also avoids having to add this prctl().
