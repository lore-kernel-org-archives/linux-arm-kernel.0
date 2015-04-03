From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 3 Apr 2015 11:40:09 -0700
Subject: [GIT PULL] qcom SoC changes for v4.1
In-Reply-To: <20150403162246.GA426@qualcomm.com>
References: <alpine.DEB.2.02.1503161601450.30317@galak-ubuntu.qualcomm.com>
 <CAP71WjzKSRRSVLcwpZTaQOYp2uziP7=J=E=3bHAzCjui-ZqbYQ@mail.gmail.com>
 <42F2C5A0-5231-4D4B-95EE-7BC173A14768@codeaurora.org>
 <551D9BF6.2070502@codeaurora.org>
 <20150403162246.GA426@qualcomm.com>
Message-ID: <20150403184009.GA18274@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03, Andy Gross wrote:
> On Thu, Apr 02, 2015 at 12:43:50PM -0700, Stephen Boyd wrote:
> > On 04/02/15 12:25, Kumar Gala wrote:
> > >> [1] http://kernelci.org/boot/all/job/arm-soc/kernel/v4.0-rc4-354-ga0690e6586df/
> > > I think we need to associated DT updates.
> > >
> > >
> > 
> > What about this patch squashed on top? Just guessing but I suspect we
> > don't care about cell-index if we're not doing the tcsr stuff. Also, I
> > imagine we could get rid of cell-index entirely if we matched against
> > the address of the gsbi instead.
> 
> Except that the GSBI5 base address changes from chip to chip.
> 
> 

Yep, for the cell-index removal part I was thinking we would make
another table per SoC like we already have for the TCSR part. The
table would map the physical address to the GSBI number.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
