From: mingo@elte.hu (Ingo Molnar)
Date: Sat, 14 May 2011 09:05:42 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <1305300443.2466.77.camel@twins>
References: <1305289146.2466.8.camel@twins> <20110513122646.GA3924@elte.hu>
	<1305290370.2466.14.camel@twins> <1305290612.2466.17.camel@twins>
	<20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
	<20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
	<20110513145737.GC32688@elte.hu> <1305300443.2466.77.camel@twins>
Message-ID: <20110514070542.GA9307@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2011-05-13 at 16:57 +0200, Ingo Molnar wrote:
> > this is a security mechanism
> 
> Who says? [...]

Kernel developers/maintainers of the affected code.

We have security hooks all around the kernel, which can deny/accept execution 
at various key points, but we do not have 'execute arbitrary user-space defined 
(safe) scripts' callbacks in general.

But yes, if a particular callback point is defined widely enough to allow much 
bigger intervention into the flow of execution, then more is possible as well.

> [...] and why would you want to unify two separate concepts only to them 
> limit it to security that just doesn't make sense.

I don't limit them to security - the callbacks themselves are either for 
passive observation or, at most, for security accept/deny callbacks.

It's decided by the subsystem maintainers what kind of user-space control power 
(or observation power) they want to allow, not me.

I would just like to not stop the facility itself at the 'observe only' level, 
like you suggest.

Thanks,

	Ingo
