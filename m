From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Tue, 22 Apr 2014 16:01:53 +0900
Subject: [PATCH] ARM: dts: disable MDMA1 node for smdk5420 board
In-Reply-To: <CAHbNUh3G1NUUfAwh=B+rDwVkfsAetUpDspiPS-JbK3oYuxSd_A@mail.gmail.com>
References: <001a01cf5b0c$5ddc7d60$19957820$%jun@samsung.com>
 <021301cf5dd1$1d0ec910$572c5b30$@samsung.com>
 <CAHbNUh3G1NUUfAwh=B+rDwVkfsAetUpDspiPS-JbK3oYuxSd_A@mail.gmail.com>
Message-ID: <000001cf5df8$bdc6f900$3954eb00$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, April 22, 2014, Tushar Behera wrote:
> On 22 April 2014 07:48, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Seungwon Jeon wrote:
> >>
> >
> > + Javi Merino and Tushar Behera
> >
> >> This change is similar to commit 3da355c(ARM: dts: Disable MDMA1 node
> >> for arndale-octa board). If MDMA1 region is configured with secure mode,
> >> it makes the boot failure with the following.
> >>
> >> Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> >>
> > If so, how about adding the 'disabled' status in 5420 dtsi file? Then if 'enabling' is required, we
> can enable in each board dt file...
> >
> 
> That should be okay. While at it, we can remove the node disabling
> code from Arndale-Octa board DTS file.

OK, I'll consider both.

Thanks,
Seungwon Jeon

> 
> 
> > - Kukjin
> >
> >> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> ---
> >>  arch/arm/boot/dts/exynos5420-smdk5420.dts |    6 ++++++
> >>  1 files changed, 6 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> >> b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> >> index 6910485..9a48e3f 100644
> >> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> >> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> >> @@ -373,4 +373,10 @@
> >>                       };
> >>               };
> >>       };
> >> +
> >> +     amba {
> >> +             mdma1: mdma at 11C10000 {
> >> +                     status = "disabled";
> >> +             };
> >> +     };
> >>  };
> >> --
> >> 1.7.0.4
> >
> 
> 
> 
> --
> Tushar Behera
