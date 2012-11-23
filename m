From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Nov 2012 12:34:00 -0800
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121123171654.GO32200@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50AFACFF.4000907@gmail.com>
 <20121123171654.GO32200@mudshark.cambridge.arm.com>
Message-ID: <20121123203359.GG5279@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Will Deacon <will.deacon@arm.com> [121123 09:23]:
> On Fri, Nov 23, 2012 at 05:06:07PM +0000, Rob Herring wrote:
> > On 11/22/2012 05:34 AM, Will Deacon wrote:
> > > On Sun, Nov 11, 2012 at 03:20:40AM +0000, Rob Herring wrote:
> > >> From: Rob Herring <rob.herring@calxeda.com>
> > >>
> > >> Use the previously unused TPIDRPRW register to store percpu offsets.
> > >> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> > >>
> > >> This saves 2 loads for each percpu variable access which should yield
> > >> improved performance, but the improvement has not been quantified.
> > >>
> > >> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > >> ---
> > >>  arch/arm/include/asm/Kbuild   |    1 -
> > >>  arch/arm/include/asm/percpu.h |   44 +++++++++++++++++++++++++++++++++++++++++
> > >>  arch/arm/kernel/smp.c         |    3 +++
> > >>  3 files changed, 47 insertions(+), 1 deletion(-)
> > >>  create mode 100644 arch/arm/include/asm/percpu.h
> > > 
> > > Russell pointed out to me that this patch will break on v6 CPUs if they don't
> > > have the thread ID registers and we're running with SMP_ON_UP=y. Looking at
> > > the TRMs, the only case we care about is 1136 < r1p0, but it does indeed break
> > > there (I have a board on my desk).
> > 
> > Are there any non ARM Ltd. cores without v6K we need to worry about? I
> > wouldn't think there are many 1136 < r1p0 out there (your desk being an
> > obvious exception).
> 
> To be honest, I'm not sure. It would be good if Marvell and Qualcomm could
> chime in as I wouldn't be surprised if they had some parts that fit this
> category.

At least omap2420 is without v6K.

Regards,

Tony
