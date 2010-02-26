From: jpihet@mvista.com (Jean Pihet)
Date: Fri, 26 Feb 2010 11:25:04 +0100
Subject: [PATCH 5/6] ARM: oprofile: use perf-events framework as backend
In-Reply-To: <000501cab6ca$a1ca7710$e55f6530$@deacon@arm.com>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<201002261028.07691.jpihet@mvista.com>
	<000501cab6ca$a1ca7710$e55f6530$@deacon@arm.com>
Message-ID: <201002261125.04448.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Will,

On Friday 26 February 2010 11:01:14 Will Deacon wrote:
> Hi Jean,
>
> Thanks for the feedback.
>
> > How is the underlaying HW reserved? In Oprofile we used to have a call to
> > reserve_pmu.
>
> Since this patch uses the perf API, perf will take care of reserving the
> hardware for us [well, it reserves it for the perf framework]. The events
> created by OProfile are pinned to each CPU, so provided the perf calls
> don't fail, we know that we have access to the PMU. If the calls do fail,
> we report failure back to the generic OProfile framework.
Ok that looks good!

>
> > Otherwise I am OK with the concept of cleaning the profiling tools. Very
> > good!
>
> Thanks. Not only does it clean the code - it adds A9MP support to OProfile
> for free!
Sure, very nice! I was wondering how to maintain both Oprofile and Perf 
Events. You come with the good solution.
I am OK to co-maintain this code if you do not mind.

Thanks,
Jean

>
> Cheers,
>
> Will
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
