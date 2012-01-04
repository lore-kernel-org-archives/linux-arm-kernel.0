From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 09:17:08 +0000
Subject: [PATCH] pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
In-Reply-To: <CAN1soZzeJi=QKCz4zuUk0LRyWFfACtq363QnqxO9D0RdUGTbxw@mail.gmail.com>
References: <1323728465.801.YahooMailClassic@web29018.mail.ird.yahoo.com>
 <CA+gwMcc3tbGXmFHQt=y7mwprXumh7sgMSE_e7B0L2LbQ-Hk2fg@mail.gmail.com>
 <20111221191901.GA18261@rainbow>
 <CAN1soZzwMQh7cMF_1QR5zzzy895qb+QkKP+AXp+7VnwCFykNgg@mail.gmail.com>
 <20111222194907.GA29166@rainbow>
 <CAN1soZzeJi=QKCz4zuUk0LRyWFfACtq363QnqxO9D0RdUGTbxw@mail.gmail.com>
Message-ID: <20120104091708.GJ2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 02:41:47PM +0800, Haojian Zhuang wrote:
> On Fri, Dec 23, 2011 at 3:49 AM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> > On 13:58 Thu 22 Dec ? ? , Haojian Zhuang wrote:
> >> On Thu, Dec 22, 2011 at 3:19 AM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> >> >
> >> > Yes, I also think increasing ARCH_NR_GPIO is the way to go.
> >> > BTW, there's a patchset floating around which moves such custom
> >> > settings of ARCH_NR_GPIO from mach/gpio.h into Kconfig variable:
> >> > http://lkml.indiana.edu/hypermail/linux/kernel/1111.0/01433.html
> >> >
> >> > I'm not sure though if it's going to be merged into 3.3
> >> >
> >> I think configuring ARCH_NR_GPIO is not a good solution. Since
> >> building one image
> >> is a target. While multiple archs are built together, what will happen?
> >
> > Setting custom ARCH_NR_GPIO in mach/gpio.h does scale only inside one
> > sub-arch, but the patch from the set above which migrates ARCH_NR_GPIO to
> > arch/arm/include/asm/gpio.h and converts it into Kconfig variable should
> > help to select proper ARCH_NR_GPIO even for multi-arch kernels
> > (Kconfig's magic will ensure that proper maximal value of ARCH_NR_GPIO
> > is selected for each combination of platforms)
> >
> > See the patch here:
> > http://lkml.indiana.edu/hypermail/linux/kernel/1111.0/01431.html
> >
> > and Russell's explanation of Kconfig magic here:
> > http://lkml.indiana.edu/hypermail/linux/kernel/1111.0/01577.html
> >
> 
> Excuse me to response so late.
> 
> Russell,
> 
> Since I failed to access your git tree, I can't verity whether the ARCH_NR_GPIO
> patch set is merged into your tree. Could you help to confirm this?

commit 44986ab056076e9dc9fb9f8b4729afef7fa72616
Author: Peter De Schrijver (NVIDIA) <pdeschrijver@nvidia.com>
Date:   Wed Dec 21 10:48:45 2011 +0100

    ARM: 7240/1: Make ARCH_NR_GPIO a Kconfig variable

    Change ARCH_NR_GPIO into a Kconfig variable as suggested by Russel King.
    This makes ARCH_NR_GPIO single zImage friendly. The default value for
    tegra is defined as well.

    Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

?
