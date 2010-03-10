From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 11:47:19 -0000
Subject: [PATCH 4/6] perf-events: export enable/disable event symbols to
	kernel modules
In-Reply-To: <1268218566.8991.1.camel@twins>
References: <1268217690-29712-1-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-2-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-3-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-4-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-5-git-send-email-will.deacon@arm.com>
	<1268218566.8991.1.camel@twins>
Message-ID: <001201cac047$70b71c60$52255520$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

> On Wed, 2010-03-10 at 10:41 +0000, Will Deacon wrote:
> > The perf_event_enable and perf_event_disable functions are used to
> > control the activation of perf-events for a given context or CPU.
> >
> > This patch exports these symbols so that they can be used by kernel
> > modules. Without these symbols, an event must be destroyed and recreated
> > to disable or enable it respectively. The maximum number of perf-events
> > is also made available to modules via the perf_get_max_events function.
> 
> Where is the module that uses all this?

It's part of the same patchset:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011126.html

The idea is to use perf-events as the backend for OProfile to avoid replicating
the PMU accessor code.

Cheers,

Will
