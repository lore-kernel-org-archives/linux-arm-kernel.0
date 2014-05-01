From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 01 May 2014 23:16:26 +0900
Subject: [PATCH v12 30/31] ARM: dts: add System MMU nodes of exynos5250
In-Reply-To: <CAD=FV=UCpQRg9nWu5EfuzWmBpee9N3X6yCmtpRaNQxitfFZkMQ@mail.gmail.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <1398584283-22846-31-git-send-email-shaik.ameer@samsung.com>
 <CAGm_ybhTEN9QxFBd1Su8NGP32KeYTF8d_Z8gXKo7cYpapZrA9w@mail.gmail.com>
 <CAD=FV=UCpQRg9nWu5EfuzWmBpee9N3X6yCmtpRaNQxitfFZkMQ@mail.gmail.com>
Message-ID: <20140501231626.fd15cca4a30891f81c953a44@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Apr 2014 16:13:19 -0700, Doug Anderson wrote:
> Vikas,
> 
> 
> On Sun, Apr 27, 2014 at 10:39 AM, Vikas Sajjan <sajjan.linux@gmail.com> wrote:
> > Hi shaik,
> >
> > +Doug, Abhilash,
> >
> > On Sun, Apr 27, 2014 at 1:08 PM, Shaik Ameer Basha
> > <shaik.ameer@samsung.com> wrote:
> >> From: Cho KyongHo <pullip.cho@samsung.com>
> >>
> >> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> >> ---
> >>  arch/arm/boot/dts/exynos5250.dtsi |  270 ++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 267 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> >> index 3742331..eebd397 100644
> >> --- a/arch/arm/boot/dts/exynos5250.dtsi
> >> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> >> @@ -82,6 +82,16 @@
> >>                 reg = <0x10044040 0x20>;
> >>         };
> >>
> >> +       pd_isp: isp-power-domain at 0x10044020 {
> >> +               compatible = "samsung,exynos4210-pd";
> >> +               reg = <0x10044020 0x20>;
> >> +       };
> >> +
> >> +       pd_disp1: disp1-power-domain at 0x100440A0 {
> >> +               compatible = "samsung,exynos4210-pd";
> >> +               reg = <0x100440A0 0x20>;
> >> +       };
> >> +
> >
> > As per subject "add System MMU nodes of exynos5250", it should only
> > add SysMMU node.
> > So, I think adding power domain nodes should go in a separate patch.
> >
> > Adding power domain nodes can break the system, if powering ON/OFF of
> > the given power domain is NOT taken care well.
> > I can see ISP is one such case. With this series I can see S2R breaks
> > [1] on 5250 chromebook with current mainline kernel (same applies for
> > arndale and smdk5250, but I have tested on these boards yet)
> 
> Thanks for catching that!  Let's make sure not to break suspend/resume.
> 
> Given that these power domains are actually used as the domains for
> some of the System MMU nodes I don't totally object to adding them in
> the same patch, but if they're breaking things then I agree that we
> could leave them out and add them in a later patch (once issues are
> sorted out).
> 

Thank you, Vikas.

Let me consider adding ISP power doamin after checking
power down sequence of ISP domain.

KyongHo
