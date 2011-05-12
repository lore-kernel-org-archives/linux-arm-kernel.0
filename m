From: jmorris@namei.org (James Morris)
Date: Thu, 12 May 2011 21:44:15 +1000 (EST)
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110512074850.GA9937@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
Message-ID: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 May 2011, Ingo Molnar wrote:

> 
> 2) Why should this concept not be made available wider, to allow the 
>    restriction of not just system calls but other security relevant components 
>    of the kernel as well?

Because the aim of this is to reduce the attack surface of the syscall 
interface.

LSM is the correct level of abstraction for general security mediation, 
because it allows you to take into account all relevant security 
information in a race-free context.


>    This too, if you approach the problem via the events code, will be a natural 
>    end result, while if you approach it from the seccomp prctl angle it will be
>    a limited hack only.

I'd say it's a well-defined and readily understandable feature.


- James
-- 
James Morris
<jmorris@namei.org>
