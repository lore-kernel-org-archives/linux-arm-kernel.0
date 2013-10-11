From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Oct 2013 13:28:46 +0100
Subject: [PATCH] arm/arm64: remove atomic_clear_mask() in
 "include/asm/atomic.h"
In-Reply-To: <CAFLxGvwsx2YfNHiGtjWsANfVW74PT3KneLA-T6SpY4NEp_OSUA@mail.gmail.com>
References: <5256121A.9030504@asianux.com> <52561269.60900@asianux.com>
 <20131010100733.GH3817@mudshark.cambridge.arm.com>
 <52568998.2080108@asianux.com>
 <20131010142305.GG6199@mudshark.cambridge.arm.com>
 <525751E2.3020207@asianux.com>
 <20131011104419.GE14732@mudshark.cambridge.arm.com>
 <5257E033.3090607@asianux.com> <5257E539.9080902@asianux.com>
 <CAFLxGvwsx2YfNHiGtjWsANfVW74PT3KneLA-T6SpY4NEp_OSUA@mail.gmail.com>
Message-ID: <20131011122846.GK14732@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 01:08:17PM +0100, Richard Weinberger wrote:
> On Fri, Oct 11, 2013 at 1:47 PM, Chen Gang <gang.chen@asianux.com> wrote:
> > In current kernel wide source code, except other architectures, only
> > s390 scsi drivers use atomic_clear_mask(), and arm/arm64 need not
> > support s390 drivers.
> >
> > So remove atomic_clear_mask() from "arm[64]/include/asm/atomic.h".
> 
> Is it really worth removing such a primitive?
> If someone needs it later he has to implement it from scratch and
> introduces bugs...

The version we have (on ARM64 anyway) already has bugs. Given the choice
between fixing code that has no callers and simply removing it, I'd go for
the latter.

Will
