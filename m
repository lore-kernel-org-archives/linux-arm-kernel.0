From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 13 May 2011 14:19:06 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110513121034.GG21022@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
Message-ID: <1305289146.2466.8.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-13 at 14:10 +0200, Ingo Molnar wrote:
>         err = event_vfs_getname(result);

I really think we should not do this. Events like we have them should be
inactive, totally passive entities, only observe but not affect
execution (other than the bare minimal time delay introduced by
observance).

If you want another entity that is more active, please invent a new name
for it and create a new subsystem for them, now you could have these
active entities also have an (automatic) passive event side, but that's
some detail.
