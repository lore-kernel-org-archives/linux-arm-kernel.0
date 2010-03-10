From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 14:41:41 -0000
Subject: [PATCH 4/6] perf-events: export enable/disable event symbols to
	kernel modules
In-Reply-To: <1268231442.5279.1.camel@twins>
References: <1268217690-29712-1-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-2-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-3-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-4-git-send-email-will.deacon@arm.com>	
	<1268217690-29712-5-git-send-email-will.deacon@arm.com>	
	<1268218566.8991.1.camel@twins>	
	<001201cac047$70b71c60$52255520$@deacon@arm.com>
	<1268231442.5279.1.camel@twins>
Message-ID: <001301cac05f$cc85d730$65918590$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> Ah, very nice. Can something like that be done in general, like an
> arch-independent oprofile backend using perf, or is there too much
> arch-specific bits to the oprofile stuff?

In theory, it should be possible but it would require that:

(a) all the architectures that have OProfile support have equivalent support in Perf
(b) the OProfile userspace tools would need tweaking so that the kernel interface:
    i.)  is identical across different architectures
    ii.) has a 1:1 mapping with perf. That is, OProfile tools must agree with perf
         on things like number of counters and PMU name [which I don't think the
         generic perf code needs to care about].

> I know Robert talked about doing something like this, I just have no
> clue how arch specific this would be.

I think it would be a nightmare to fix up all the edge-cases that each architecture
has at the moment. If, in the long run, each architecture ends up defining their own
oprofile <-> perf interface then it would make sense to look at merging them at the
higher level.

Will
