From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Dec 2009 15:05:13 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for	ARMv6
In-Reply-To: <20091215150205.GO4141@wear.picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
	<000101ca7d92$fe903000$fbb09000$@deacon@arm.com>
	<20091215150205.GO4141@wear.picochip.com>
Message-ID: <000201ca7d98$012826b0$03787410$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Jamie Iles wrote:

> Ok, is it a safe assumption that for ARMv6 if num_possible_cpus() returns >1
> we are mpcore and need to use different ID's or is there a better way to test
> for mpcore?

The bottom 16 bits of the cpuid field will read 0xB020 on an 11MPCore as it's a
different chip to the other v6 cores.

You could cast the cpuid to a u16 and switch on that: 0xB360, 0xB560 and 0xB760
are the single core ARM11s.

Will
