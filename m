From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Dec 2017 02:24:58 +0000
Subject: [GIT PULL] revert ARM SCPI changes for v4.15-rc1
In-Reply-To: <20171203010435.6ycn75rxss5yiixe@localhost>
References: <7hlgimns2m.fsf@baylibre.com>
 <20171203010435.6ycn75rxss5yiixe@localhost>
Message-ID: <20171204022458.GC6870@e107533-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 02, 2017 at 05:04:35PM -0800, Olof Johansson wrote:
> On Fri, Dec 01, 2017 at 11:53:05AM -0800, Kevin Hilman wrote:
> > Arnd, Olof,
> > 
> > These ARM SCPI changes caused SCPI regressions resulting in CPUfreq
> > failures on most Amlogic SoCs (found by kernelci.org.)
> > 
> > Unfortunately, this was not caught in linux-next due to other
> > bugs/panics on these platforms masking this problem so we've only found
> > it since we've fixed the other issues.
> > 
> > Since we're already in the -rc cycle, I'd prefer to revert to a known
> > working state (that of v4.14) rather than finding/reverting a subset,
> > which would just lead to another untested state.
> > 
> > These changes can then have some time to be better reviewed and tested
> > and resubmitted for v4.16.
> > 
> > I've tested this revert on the affect Amlogic SoCs and verified that
> > we're back to the previous (working) condition.
> > 
> > Also, I'm sending the pull directly to arm-soc instead of Sudeeep
> > because I understand that Sudeep is currently out-of-office and unlikely
> > to be able to address this himself during the -rc cycle.
> >

Thanks Kevin for taking care of this in my absence.

As mentioned in the other thread, I would like to get a list of AmLogic
SoCs using SCPI and the ones that are broken. If my analysis is correct,
then it's more likely to be firmware issue that is popping up as we now
allow other SCPI protocols to work even when DVFS fails. This is useful
on some platforms where firmware is under development or only DVFS is
broken partially/fully.

> 
> Sounds like the right approach here. I've merged this and added the above text
> to the merge commit as well.
>

Thanks.

--
Regards,
Sudeep
