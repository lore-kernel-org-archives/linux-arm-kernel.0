From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Mon, 11 Dec 2017 13:22:45 +0200
Subject: [PATCH] soc: qcom: Separate kryo l2 accessors from PMU driver
In-Reply-To: <20171205115118.ekilgrzsp47fz5ua@lakrids.cambridge.arm.com>
References: <1512455630-25119-1-git-send-email-ilialin@codeaurora.org>
 <20171205103516.bczf43vvpcin24zl@lakrids.cambridge.arm.com>
 <011801d36dbd$7ae34e80$70a9eb80$@codeaurora.org>
 <20171205115118.ekilgrzsp47fz5ua@lakrids.cambridge.arm.com>
Message-ID: <002101d37272$60016a20$20043e60$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Do you mean, I should send them as a single series to both lists?

Thanks,
Ilia

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Tuesday, December 5, 2017 1:51 PM
> To: ilialin at codeaurora.org
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] soc: qcom: Separate kryo l2 accessors from PMU driver
> 
> On Tue, Dec 05, 2017 at 01:37:47PM +0200, ilialin at codeaurora.org wrote:
> > Hello Mark,
> >
> > > -----Original Message-----
> > > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > > Sent: Tuesday, December 5, 2017 12:35 PM
> > > To: Ilia Lin <ilialin@codeaurora.org>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Subject: Re: [PATCH] soc: qcom: Separate kryo l2 accessors from PMU
> > > driver
> > >
> > > Hi,
> > >
> > > On Tue, Dec 05, 2017 at 08:33:50AM +0200, Ilia Lin wrote:
> > > > The driver provides kernel level API for other drivers to access
> > > > the
> > > > MSM8996 L2 cache registers.
> > > > Separating the L2 access code from the PMU driver and making it
> > > > public to allow other drivers use it.
> > > > The accesses must be separated with a single spinlock, maintained
> > > > in this driver.
> > > >
> > > > Change-Id: I2865e888491e85d678e298279400c371427e30ea
> > > > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > >
> > > What other driver is going to use this?
> > >
> > > Until there is another driver, I don't see much point in factoring
> > > this
> > out.
> >
> > The other driver currently is the CPU clock driver, which needs
> > configuring the L2 registers. The clock driver will be submitted
> > through the linux-clk list and will depend on the kryo-l2-accessors
driver
> then.
> 
> Ok,
> 
> Please put the two in a series, and keep me (and Will Deacon) on Cc, so
that
> we can review both together.
> 
> Thanks,
> Mark.
