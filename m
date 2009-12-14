From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2009 17:09:48 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <1260807177.8106.50.camel@def-laptop>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-5-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
	<1260807177.8106.50.camel@def-laptop>
Message-ID: <001201ca7ce0$3e58b580$bb0a2080$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

* Jean Pihet wrote:
> 
> I am interested in supporting perf events for ARMv7. What do you think?
> 

I'm also interested in this. My plan was to add an initialisation function
as an arch_initcall which would switch on the cpuid and setup a static PMU
struct that could be later returned by hw_perf_event_init.
This struct could also contain another struct encoding the event numbers for
that particular core.

Is this what you had in mind? Either way, we should get Jamie's code sorted
and then build on top of that to avoid divergence.

Will
