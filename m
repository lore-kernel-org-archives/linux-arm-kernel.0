From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Feb 2010 10:01:14 -0000
Subject: [PATCH 5/6] ARM: oprofile: use perf-events framework as backend
In-Reply-To: <201002261028.07691.jpihet@mvista.com>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<1267124175-21721-5-git-send-email-will.deacon@arm.com>
	<1267124175-21721-6-git-send-email-will.deacon@arm.com>
	<201002261028.07691.jpihet@mvista.com>
Message-ID: <000501cab6ca$a1ca7710$e55f6530$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Thanks for the feedback.

> How is the underlaying HW reserved? In Oprofile we used to have a call to
> reserve_pmu.

Since this patch uses the perf API, perf will take care of reserving the hardware
for us [well, it reserves it for the perf framework]. The events created by
OProfile are pinned to each CPU, so provided the perf calls don't fail, we know
that we have access to the PMU. If the calls do fail, we report failure back to
the generic OProfile framework.
 
> Otherwise I am OK with the concept of cleaning the profiling tools. Very good!

Thanks. Not only does it clean the code - it adds A9MP support to OProfile for free!

Cheers,

Will
