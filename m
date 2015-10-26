From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 26 Oct 2015 15:15:17 +0800
Subject: [PATCH v5 4/5] ARM: dts: mt8135: enable basic SMP bringup for
 mt8135
In-Reply-To: <CAMAWPa-Ed2FJY2pW67EHHKBH3_eBZx0+oWfMJwc_DhEjrf7aMg@mail.gmail.com>
References: <1443799181-50409-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443799181-50409-5-git-send-email-yingjoe.chen@mediatek.com>
 <CAMAWPa-Ed2FJY2pW67EHHKBH3_eBZx0+oWfMJwc_DhEjrf7aMg@mail.gmail.com>
Message-ID: <1445843717.23888.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-10-26 at 09:56 +0900, Kevin Hilman wrote:
> Hello,
> 
> On Sat, Oct 3, 2015 at 12:19 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> > Add arch timer node to enable arch-timer support. MT8135 firmware
> > doesn't correctly setup arch-timer frequency and CNTVOFF, add
> > properties to workaround this.
> >
> > This also set cpu enable-method to enable SMP.
> >
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> 
> kernelci.org started detecting new boot failures for the mt8135-evb in
> the arm-soc tree[1], and the boot failures were bisected down to this
> patch, which landed upstream in the form of commit d186a394bb98 (ARM:
> dts: mt8135: enable basic SMP bringup for mt8135)
> 
> Maybe this new SMP support requires updating the firmware on the board
> as well?  If so, the changelog should've been a bit more explicit
> about firmware dependencies.

Kevin,

Thanks for testing.

No, it doesn't need new firmware. Will test to see what's going wrong.


Joe.C
