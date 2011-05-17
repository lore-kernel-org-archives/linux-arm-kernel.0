From: mingo@elte.hu (Ingo Molnar)
Date: Tue, 17 May 2011 15:10:58 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
	<20110516150837.GA513@elte.hu>
	<alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
Message-ID: <20110517131058.GE21441@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* James Morris <jmorris@namei.org> wrote:

> On Mon, 16 May 2011, Ingo Molnar wrote:
> 
> > > Not really.
> > > 
> > > Firstly, what is the security goal of these restrictions? [...]
> > 
> > To do what i described above? Namely:
> > 
> >  " Sandboxed code should only be allowed to open files in /home/sandbox/, /lib/
> >    and /usr/lib/ "
> 
> These are access rules, they don't really describe a high-level security 
> goal. [...]

Restrictng sandboxed code to only open files within a given VFS namespace 
boundary sure sounds like a high-level security goal to me.

If implemented and set up correctly then it restricts sandboxed code to only be 
able to open files reachable via that VFS sub-namespace.

That is a rather meaningful high-level concept. What higher level concept do 
you want to argue?

> [...]  How do you know it's ok to open everything in these directories?

How do you know it's ok to open /etc/hosts? The sysadmin has configured the 
system that way.

How do you know that it's ok for sandboxed code to open files in 
/home/sandbox/? The sandbox developer has configured the system that way.

I'm not sure i get your point.

Thanks,

	Ingo
