From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 May 2014 10:47:53 +0100
Subject: [PATCH v5 08/14] ARM: hisi: add hip04 SoC support
In-Reply-To: <CAD6h2NQ_eD-K_i6VryjZK-7WHyNsOtz8y3kiTJPHrKjxi3X2_w@mail.gmail.com>
References: <1399473888-12947-9-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1405071259300.980@knanqh.ubzr>
 <CAD6h2NQU0NR1PO=x6pz62B4QWqkPz7F+Fp65YeQJ62vumF8_Aw@mail.gmail.com>
 <CAD6h2NTMJ5GNkUdcTvx_MoKnGSnmQ15vUWBoj7GcKdBTBf7MJw@mail.gmail.com>
 <alpine.LFD.2.11.1405121510130.980@knanqh.ubzr>
 <CAD6h2NTz6h+GSM7BKr_Om3VHjKOXebO6hRD0BHCjzyT57qHeLQ@mail.gmail.com>
 <alpine.LFD.2.11.1405131433580.980@knanqh.ubzr>
 <CAD6h2NR3=uq7uQ3JMjGKo0-QjM18B-pdOoeGTsMtfkdf_uSQ=A@mail.gmail.com>
 <alpine.LFD.2.11.1405151602140.17310@knanqh.ubzr>
 <CAD6h2NQ_eD-K_i6VryjZK-7WHyNsOtz8y3kiTJPHrKjxi3X2_w@mail.gmail.com>
Message-ID: <20140521094745.GA3830@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 12:53:31PM +0800, Haojian Zhuang wrote:
> On 16 May 2014 04:10, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Thu, 15 May 2014, Haojian Zhuang wrote:
> >
> >> On 14 May 2014 02:44, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> >>
> >> >> There's no CCI in HiP04. Their own fabric is used instead.
> >> >
> >> > OK.  Still, in order to support deep C-States with cpuidle, the
> >> > waking-up of CPUs must happen asynchronously, and in that case the CPU
> >> > being awaken must do snooping setup by itself.  So I'd be interested to
> >> > see if that can be down that way as well for HiP04, at least to be
> >> > similar in structure to other backend implementations, and possibly for
> >> > being cpuidle ready as well.
> >> >
> >>
> >> But it fails on my platform if I execute snooping setup on the new CPU.
> >
> > It fails how?  I want to make sure if the problem is with the hardware
> > design or the code.
> >
> The failure isn't caused by your assembly code. I even rewrite it.
> 
> It's caused by hardware design. Hisilicon guys said the snooping setup
> should be set before new CPU on. I tried and got the same result.

How does this design support cluster powerdown during idle, then ... or
is this just not intended to be supported?

Unless there is some extra logic in the hardware taking care of snoop
control races, it's not clear who interrupt-driven wakeup from a cluster
powerdown could work safely.

Cheers
---Dave
