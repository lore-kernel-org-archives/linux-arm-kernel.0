From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 9 Nov 2017 19:54:40 +0900
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <20171104021303.bexhsxpg5tjerhu7@salmiak>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
 <20171103180913.whp2tdjjvs32f4lz@lakrids.cambridge.arm.com>
 <CAKwvOd=5CCMAA9n7=ocPO5UYmCmkNs8GLYrxXVZVZEeYCyisyA@mail.gmail.com>
 <20171103192634.u25go4tu7lgzl6ja@lakrids.cambridge.arm.com>
 <20171103195647.GA137924@samitolvanen.mtv.corp.google.com>
 <20171104021303.bexhsxpg5tjerhu7@salmiak>
Message-ID: <20171109105439.GA27630@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 04, 2017 at 02:13:04AM +0000, Mark Rutland wrote:
> On Fri, Nov 03, 2017 at 12:56:47PM -0700, Sami Tolvanen wrote:
> > On Fri, Nov 03, 2017 at 07:26:35PM +0000, Mark Rutland wrote:
> > > I guess that in Google you haven't tested on a platform with EL2
> > > available?
> > 
> > Correct. I'll look into this and include a fix in v2. Does this work on a
> > clang build without LTO?
> 
> I saw this on v4.14-rc7, with patch 7 (-mno-implicit-float), but no other
> patches from this series (i.e. no LTO).


Add -fno-jump-tables to ccflags-y of arch/arm64/kvm/hyp/Makefile.
Without this option, clang generates a branch instruction (br x11)
to an absolute (EL1) virtual address.

-Takahiro AKASHI

> Thanks,
> Mark.
