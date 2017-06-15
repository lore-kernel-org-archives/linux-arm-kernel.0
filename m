From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Jun 2017 15:51:01 +0800
Subject: [PATCH v3 1/9] ARM: dts: imx6ul-isiot: Add Sound card with codec
 node
In-Reply-To: <CAMty3ZCwkP=EaFcSdA--yQNN9ebjE9JptfwWjQpceXqDq-xkyA@mail.gmail.com>
References: <1491501735-1649-1-git-send-email-jagan@openedev.com>
 <1491501735-1649-2-git-send-email-jagan@openedev.com>
 <20170407131649.GH16503@dragon>
 <CAMty3ZDj3XgeZwUTXTTX2svoXaNWJ3GJtbNAt9+jj+n8Z4640w@mail.gmail.com>
 <20170615022024.GE30112@dragon>
 <CAMty3ZAUK37JYnPwVRuBA6B67QV+S_BYQ6f=k6_rjw__ypTxBg@mail.gmail.com>
 <20170615071529.GC5902@dragon>
 <CAMty3ZCwkP=EaFcSdA--yQNN9ebjE9JptfwWjQpceXqDq-xkyA@mail.gmail.com>
Message-ID: <20170615075059.GD5902@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 01:01:22PM +0530, Jagan Teki wrote:
> > I feel the abstraction is wrong from the beginning.  Ideally, we should
> > have something like below.
> >
> >  - imx6ul-isiot.dtsi
> >  - imx6ul-isiot-kit.dts and imx6ul-isiot-carrier.dts
> >
> > The -isiot should have everything on SoM and common stuff between -kit
> > and -carrier boards, while -kit and -carrier include -isiot and contains
> > the base-board specific things.  The -isiot can have both emmc and nand
> > devices with "disabled" status, and let firmware turn device on per SoM
> > it boots.  In that case, the abstraction level can be less and clearer.
> >
> > Thoughts?
> 
> So,even the common stuff (lcdif, ts and etc) should be in -isiot.dtsi

Yes, anything common can be in -isiot.dtsi.

> and make it "disabled" and let them enabled on respective dts. this
> what you mentioned here?

It doesn't matter.  If the lcd/touch is same on -kit and -carrier, you
can even have them enabled by default in -isiot.dtsi.  The -kit.dts and
-carrier.dts are there to accommodate base-board specific differences.

Shawn
