From: jmorris@namei.org (James Morris)
Date: Mon, 16 May 2011 10:36:05 +1000 (EST)
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110513121034.GG21022@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
Message-ID: <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 May 2011, Ingo Molnar wrote:

> Say i'm a user-space sandbox developer who wants to enforce that sandboxed code 
> should only be allowed to open files in /home/sandbox/, /lib/ and /usr/lib/.
> 
> It is a simple and sensible security feature, agreed? It allows most code to 
> run well and link to countless libraries - but no access to other files is 
> allowed.

Not really.

Firstly, what is the security goal of these restrictions?  Then, are the 
restrictions complete and unbypassable?

How do you reason about the behavior of the system as a whole?


> I argue that this is the LSM and audit subsystems designed right: in the long 
> run it could allow everything that LSM does at the moment - and so much more 
> ...

Now you're proposing a redesign of the security subsystem.  That's a 
significant undertaking.

In the meantime, we have a simple, well-defined enhancement to seccomp 
which will be very useful to current users in reducing their kernel attack 
surface.

We should merge that, and the security subsystem discussion can carry on 
separately.


- James
-- 
James Morris
<jmorris@namei.org>
