From: msalter@redhat.com (Mark Salter)
Date: Thu, 30 Apr 2015 09:26:34 -0400
Subject: [PATCH V2] drivers: CCI: fix used_mask init in validate_group()
In-Reply-To: <55420A18.7080203@arm.com>
References: <20150409144029.GE9648@leverpostej>
 <1428591425-17330-1-git-send-email-msalter@redhat.com>
 <20150409153629.GI9648@leverpostej> <20150413124121.GF2869@arm.com>
 <55420A18.7080203@arm.com>
Message-ID: <1430400394.24034.67.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-30 at 11:55 +0100, Suzuki K. Poulose wrote:
> On 13/04/15 13:41, Will Deacon wrote:
> > On Thu, Apr 09, 2015 at 04:36:29PM +0100, Mark Rutland wrote:
> >> On Thu, Apr 09, 2015 at 03:57:05PM +0100, Mark Salter wrote:
> >>> Currently in validate_group(), there is a static initializer
> >>> for fake_pmu.used_mask which is based on CPU_BITS_NONE but
> >>> the used_mask array size is based on CCI_PMU_MAX_HW_EVENTS.
> >>> CCI_PMU_MAX_HW_EVENTS is not based on NR_CPUS, so CPU_BITS_NONE
> >>> is not correct and will cause a build failure if NR_CPUS
> >>> is set high enough to make CPU_BITS_NONE larger than used_mask.
> >>>
> >>> Signed-off-by: Mark Salter <msalter@redhat.com>
> >>
> >> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> >>
> >> Arnd, Olof, are you happy to take this via arm-soc?
> >>
> >> My (broken) patch went via Will's tree because of a perf dependency, but
> >> other CCI patches have gone via you guys.
> >
> > Yeah, arm-soc is the best place for this. You should resend to
> > arm at kernel.org as a new patch with the relevant acks.
> Mark
> 
> Could you please send this to arm-soc as suggested by Will, with the 
> relevant acks/reviews  ?
> 

I sent it on Tuesday. Did it not show up? Is arm at kernel.org the correct
address? I got the cc:

From: Mark Salter <msalter@redhat.com>
To: arm at kernel.org
Cc: Mark Salter <msalter@redhat.com>
Subject: [PATCH V2] drivers: CCI: fix used_mask init in validate_group()
Date: Tue, 28 Apr 2015 13:09:32 -0400
Message-Id: <1430240972-16386-1-git-send-email-msalter@redhat.com>
