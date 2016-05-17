From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 17 May 2016 18:07:53 +0900
Subject: [PATCH v15 00/20] arm64 kexec kernel patches v15
In-Reply-To: <573AD11E.1030301@arm.com>
References: <cover.1457977401.git.geoff@infradead.org>
 <20160401015947.GA3835@dhcp-128-65.nay.redhat.com>
 <1459535954.20121.3.camel@infradead.org>
 <20160517054216.GA12543@dhcp-128-65.nay.redhat.com>
 <573AD11E.1030301@arm.com>
Message-ID: <20160517090602.GA31879@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc, Dave

On Tue, May 17, 2016 at 09:06:54AM +0100, Marc Zyngier wrote:
> Hi Dave,
> 
> On 17/05/16 06:42, Dave Young wrote:
> > Marc, it has been discussed for long time, I think kdump code can be
> > logically splitted from this series so that we can get the kexec
> > done first? 
> 
> The basis for kexec are already on their way to mainline, as part of the
> hibernate series that James has put together.
> 
> I'd expect someone to:
> 
> 1) rebase the remaining kexec/kdump patches based on the current
> arm64/for-next/core,

Done. At the time of last week.
The only issue that I have now is a support for KASLR, but this is not
a kernel issue, but tool's. I'm now talking with Dave Anderson (RedHat)
about how we should fix it.

> 2) post these patches when -rc1 gets cut in two weeks from now,

Yes, we are planning to do so.

> 3) address the review comments in a timely manner,

I'd like to expect the code to be reviewed in a timely manner, too.
In v4.6, we have not got any comments (nor ack's) on kexec/kdump-specific
part of patches. If this happens again, it will make the turnaround of our
re-spinning even longer.

> 4) update the series once a week so that we see some actual progress

Yes if we have updates.

> If this happens, I can't see any reason why this code wouldn't get
> merged. But keeping kexec and kdump together is not what has prevented
> the code from getting merged until now.

Yeah, agree.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> 	M.
> > 
> > On 04/01/16 at 11:39am, Geoff Levand wrote:
> >> Hi,
> >>
> >> On Fri, 2016-04-01 at 09:59 +0800, Dave Young wrote:
> >>> Geoff, for easier to review maybe you can send kexec patches first
> >>> then AKASHI Takahiro
> >>> can send the kdump patches as a standalone patchset?
> >>
> >> Marc Zyngier specifically asked for an integrated set
> >> of patches for easier review.  I will keep it that way
> >> for now.
> >>
> >> -Geoff
> > 
> 
> 
> -- 
> Jazz is not dead. It just smells funny...
