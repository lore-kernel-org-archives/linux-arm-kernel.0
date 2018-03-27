From: LinoSanfilippo@gmx.de (Lino Sanfilippo)
Date: Tue, 27 Mar 2018 16:33:00 +0200
Subject: Aw: Re: [PATCH v7 0/7] netdev: intel: Eliminate duplicate barriers
 on weakly-ordered archs
In-Reply-To: <dcbd4406-73f7-4afa-850d-5f5d9f97ab02@codeaurora.org>
References: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
 <CAKgT0UcaxM8Mj9Y9fR0B+aafTm1SzTqh+gHT5ozgvyaoHvrzRQ@mail.gmail.com>
 <1521849496.15055.16.camel@intel.com>
 <862cdbeafb9cfd272a426b010943ffc5@codeaurora.org>
 <e3ada376-52a5-573b-33f1-9aa84af75f0d@codeaurora.org>
 <trinity-6d247cd1-94e3-4a58-a762-77724e895644-1522159460624@3c-app-gmx-bs61>
 <dcbd4406-73f7-4afa-850d-5f5d9f97ab02@codeaurora.org>
Message-ID: <trinity-9fb90024-b1c8-480a-b47f-220288d422c5-1522161180334@3c-app-gmx-bs61>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>
> On 3/27/2018 10:04 AM, Lino Sanfilippo wrote:
> > Hi,
> > 
> >> Double sorry now.
> >>
> >> I don't know if you have been following "RFC on writel and writel_relaxed" thread
> >> or not but there are some new developments about wmb() requirement. 
> > 
> > Just out of interest: Where can this thread be found?
> 
> https://www.spinics.net/lists/linux-rdma/msg62570.html
> 
> https://patchwork.kernel.org/patch/10309913/
> 
> 
> > 
> >>
> >> Basically, wmb() should never be used before writel() as writel() seem to
> >> provide coherency and observability guarantee.
> >>
> > 
> > AFAIU memory-barriers.txt writel() only guarantees correct order of accesses to
> > IO-memory not RAM vs. IO-memory (this may be the case for some architectures 
> > where the writel() implementation contains a wmb() but not for all).
> > For the RAM vs. IO-memory case at least a a wmb()/rmb() has to be used. 
> > Is this not correct? 
> 
> We are being told that if you use writel(), then you don't need a wmb() on
> all architectures.
> 
> Jason is seeking behavior clarification for write combined buffers.
> 

Interesting, thanks for the information!

Lino
