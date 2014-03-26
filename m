From: Phil.Edworthy@renesas.com (Phil.Edworthy at renesas.com)
Date: Wed, 26 Mar 2014 08:50:00 +0000
Subject: [PATCH v5 9/9] ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig
In-Reply-To: <CANqRtoRCK8rLKDuy9kuyES=Y0Ek00BVnzzTdCeTKpPjrxiP7RQ@mail.gmail.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>	<1395766604-30926-10-git-send-email-phil.edworthy@renesas.com>
 <CANqRtoRCK8rLKDuy9kuyES=Y0Ek00BVnzzTdCeTKpPjrxiP7RQ@mail.gmail.com>
Message-ID: <OFB07E7C91.23278323-ON80257CA7.00305D4A-80257CA7.00308574@eu.necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On: 26/03/2014 05:39, Magnus wrote:
> Subject: Re: [PATCH v5 9/9] ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to 
defconfig
> 
> On Wed, Mar 26, 2014 at 1:56 AM, Phil Edworthy
> <phil.edworthy@renesas.com> wrote:
> > This is fixes a boot problem when the R-Car PCIe driver is enabled.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  arch/arm/configs/koelsch_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/configs/koelsch_defconfig 
b/arch/arm/configs/koelsch_defconfig
> > index ec14547..67666b6 100644
> > --- a/arch/arm/configs/koelsch_defconfig
> > +++ b/arch/arm/configs/koelsch_defconfig
> > @@ -15,6 +15,7 @@ CONFIG_MACH_KOELSCH=y
> >  CONFIG_CPU_BPREDICT_DISABLE=y
> >  CONFIG_PL310_ERRATA_588369=y
> >  CONFIG_ARM_ERRATA_754322=y
> > +CONFIG_HAVE_ARM_ARCH_TIMER=y
> 
> Hi Phil,
> 
> Thanks for your patches! I appreciate that you send out a whole series
> with broken out patches, that makes it easier to see what is going on.
> 
> However, regarding this particular patch I'm not so sure if your fix
> is correct. The issue is most likely there, no doubt about that, but
> this "select" does not match well with how we currently handle timers
> for the rest of the SoCs in mach-shmobile. We for instance want to be
> able to boot with CMT only.
> 
> So here's a gentle "NAK" on this particular patch. I think this shows
> that either deferred probing or a different init ordering is needed
> somehow.

When reading your comments, I realised that since I changed the driver to 
use module_platform_driver instead of subsys_initcall, we no longer need 
this patch.

Thanks
Phil
