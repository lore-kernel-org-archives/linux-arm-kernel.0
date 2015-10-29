From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 29 Oct 2015 20:03:55 +0800
Subject: [PATCH v5 4/5] ARM: dts: mt8135: enable basic SMP bringup for
 mt8135
In-Reply-To: <7hlhamjawi.fsf@deeprootsystems.com>
References: <1443799181-50409-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443799181-50409-5-git-send-email-yingjoe.chen@mediatek.com>
 <CAMAWPa-Ed2FJY2pW67EHHKBH3_eBZx0+oWfMJwc_DhEjrf7aMg@mail.gmail.com>
 <1445843717.23888.1.camel@mtksdaap41>
 <CAMAWPa_Gyq7H0qUJ32PAJh_ELdHeKWMPyHud4gaT8=Ootcu1+g@mail.gmail.com>
 <1445859610.26723.4.camel@mtksdaap41> <7hlhamjawi.fsf@deeprootsystems.com>
Message-ID: <1446120235.18122.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-29 at 02:12 -0700, Kevin Hilman wrote:
> Eddie Huang <eddie.huang@mediatek.com> writes:
> 
> > Hi Kevin,
> >
> > On Mon, 2015-10-26 at 17:06 +0900, Kevin Hilman wrote:
> >> On Mon, Oct 26, 2015 at 4:15 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> >> > On Mon, 2015-10-26 at 09:56 +0900, Kevin Hilman wrote:
> >> >> Hello,
> >> >>
> >> >> On Sat, Oct 3, 2015 at 12:19 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> >> >> > Add arch timer node to enable arch-timer support. MT8135 firmware
> >> >> > doesn't correctly setup arch-timer frequency and CNTVOFF, add
> >> >> > properties to workaround this.
> >> >> >
> >> >> > This also set cpu enable-method to enable SMP.
> >> >> >
> >> >> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >> >>
> >> >> kernelci.org started detecting new boot failures for the mt8135-evb in
> >> >> the arm-soc tree[1], and the boot failures were bisected down to this
> >> >> patch, which landed upstream in the form of commit d186a394bb98 (ARM:
> >> >> dts: mt8135: enable basic SMP bringup for mt8135)
> >> >>
> >> >> Maybe this new SMP support requires updating the firmware on the board
> >> >> as well?  If so, the changelog should've been a bit more explicit
> >> >> about firmware dependencies.
> >> >
> >> > Kevin,
> >> >
> >> > Thanks for testing.
> >> >
> >> > No, it doesn't need new firmware. Will test to see what's going wrong.
> >> 
> >> Thanks for following up.  I'll be glad to test any patches if you have
> >> anything you'd like me to test.
> >
> > You need "clockevents/drivers/mtk: Fix spurious interrupt leading to
> > crash" (https://lkml.org/lkml/2015/8/24/803)
> >
> > Daniel Lezcano already applied this patch in his tree for 4.4.
> > (https://git.linaro.org/people/daniel.lezcano/linux.git)
> >
> 
> Thanks for letting us know.
> 
> In the future, these kinds of cross-tree dependencies are important to
> mention in the cover letter of  the pull request so we can setup
> dependency branches and keep arm-soc/for-next building and booting.
> 
sorry, we will be more careful in the future

Eddie
Thanks
