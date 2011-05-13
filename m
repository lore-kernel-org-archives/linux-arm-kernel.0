From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 13 May 2011 17:27:23 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110513145737.GC32688@elte.hu>
References: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
	<1305294935.2466.64.camel@twins>  <20110513145737.GC32688@elte.hu>
Message-ID: <1305300443.2466.77.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-13 at 16:57 +0200, Ingo Molnar wrote:
> this is a security mechanism

Who says? and why would you want to unify two separate concepts only to
them limit it to security that just doesn't make sense.

Either you provide a full on replacement for notifier chain like things
or you don't, only extending trace events in this fashion for security
is like way weird.

Plus see the arguments Eric made about stacking stuff, not only security
schemes will have those problems.
