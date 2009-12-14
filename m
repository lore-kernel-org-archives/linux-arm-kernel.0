From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2009 16:24:31 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for	ARMv6
In-Reply-To: <20091214162003.GI4141@wear.picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
	<001001ca7cd8$517ce440$f476acc0$@deacon@arm.com>
	<20091214162003.GI4141@wear.picochip.com>
Message-ID: <001101ca7cd9$ead75b10$c0861130$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Jamie Iles wrote:

> > Why are you modifying mm/Kconfig? I think it would be better to change the
> > Makefile to use CONFIG_HAVE_PERF_EVENTS rather than define a new bool.
> Because this bool says that we support hardware perf events. If it isn't set,
> we can still do perf events, but only the software variety. This allows us to
> do software events for ARMv5 and earlier, but also do hardware counter support
> where available.

Ok, sorry I missed that. I still feel that it should be in the top-level ARM 
Kconfig instead of the mm/Kconfig though.

Will
