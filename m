From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 10 Mar 2010 15:30:42 +0100
Subject: [PATCH 4/6] perf-events: export enable/disable event symbols
	to kernel modules
In-Reply-To: <001201cac047$70b71c60$52255520$@deacon@arm.com>
References: <1268217690-29712-1-git-send-email-will.deacon@arm.com>
	<1268217690-29712-2-git-send-email-will.deacon@arm.com>
	<1268217690-29712-3-git-send-email-will.deacon@arm.com>
	<1268217690-29712-4-git-send-email-will.deacon@arm.com>
	<1268217690-29712-5-git-send-email-will.deacon@arm.com>
	<1268218566.8991.1.camel@twins>
	<001201cac047$70b71c60$52255520$@deacon@arm.com>
Message-ID: <1268231442.5279.1.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-10 at 11:47 +0000, Will Deacon wrote:
> Hello Peter,
> 
> > On Wed, 2010-03-10 at 10:41 +0000, Will Deacon wrote:
> > > The perf_event_enable and perf_event_disable functions are used to
> > > control the activation of perf-events for a given context or CPU.
> > >
> > > This patch exports these symbols so that they can be used by kernel
> > > modules. Without these symbols, an event must be destroyed and recreated
> > > to disable or enable it respectively. The maximum number of perf-events
> > > is also made available to modules via the perf_get_max_events function.
> > 
> > Where is the module that uses all this?
> 
> It's part of the same patchset:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011126.html
> 
> The idea is to use perf-events as the backend for OProfile to avoid replicating
> the PMU accessor code.

Ah, very nice. Can something like that be done in general, like an
arch-independent oprofile backend using perf, or is there too much
arch-specific bits to the oprofile stuff?

I know Robert talked about doing something like this, I just have no
clue how arch specific this would be.
