From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Apr 2017 18:23:07 +0100
Subject: [PATCH V3 0/5] iommu/arm-smmu: Add runtime pm/sleep support
In-Reply-To: <CAF6AEGv_1pNvhCc-mVP5S28Yt5kTJmTRfe8tKSJpEmxfOKM7Jg@mail.gmail.com>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
 <20170331175457.GD4897@arm.com>
 <CAF6AEGv_1pNvhCc-mVP5S28Yt5kTJmTRfe8tKSJpEmxfOKM7Jg@mail.gmail.com>
Message-ID: <20170403172307.GI5706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 10:58:16PM -0400, Rob Clark wrote:
> On Fri, Mar 31, 2017 at 1:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Mar 09, 2017 at 09:05:43PM +0530, Sricharan R wrote:
> >> This series provides the support for turning on the arm-smmu's
> >> clocks/power domains using runtime pm. This is done using the
> >> recently introduced device links patches, which lets the symmu's
> >> runtime to follow the master's runtime pm, so the smmu remains
> >> powered only when the masters use it.
> >
> > Do you have any numbers for the power savings you achieve with this?
> > How often do we actually manage to stop the SMMU clocks on an SoC with
> > a handful of masters?
> >
> > In other words, is this too coarse-grained to be useful, or is it common
> > that all the devices upstream of the SMMU are suspended?
> 
> well, if you think about a phone/tablet with a command mode panel,
> pretty much all devices will be suspended most of the time ;-)

Well, that's really what I was asking about. I assumed that periodic
modem/radio transactions would keep the SMMU clocked, so would like to get a
rough idea of the power savings achieved with this coarse-grained approach.

Will
