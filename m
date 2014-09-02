From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 2 Sep 2014 22:11:48 +0800
Subject: [PATCH 2/2] ARM: dts: imx6x-sdb: Add LCD support
In-Reply-To: <CAOMZO5Ct0PiRViQkrQ24ZUCHmaC+UgY1rktmOH+4BY0s99yB-g@mail.gmail.com>
References: <1409593803-12368-1-git-send-email-fabio.estevam@freescale.com>
 <1409593803-12368-2-git-send-email-fabio.estevam@freescale.com>
 <20140902135036.GJ3135@dragon>
 <CAOMZO5Ct0PiRViQkrQ24ZUCHmaC+UgY1rktmOH+4BY0s99yB-g@mail.gmail.com>
Message-ID: <20140902141147.GL3135@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 11:01:06AM -0300, Fabio Estevam wrote:
> On Tue, Sep 2, 2014 at 10:50 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> >> +&lcdif1 {
> >> +     pinctrl-names = "default";
> >> +     pinctrl-0 = <&pinctrl_lcd>;
> >> +     lcd-supply = <&reg_lcd_3v3>;
> >> +     display = <&display0>;
> >> +     status = "okay";
> >> +
> >> +     display0: display {
> >
> > Shouldn't the node be named more specific, so that we do not run into
> > the kernel warning complaining duplicated property name?
> 
> I do not see any warning here.

I'm not sure why you do not see it, but I do.

[    0.037835] device-tree: Duplicate name in lcdif at 02220000, renamed to "display#1"

> 
> It was on mx28 that I got the warning as it has "display: display".

I do not think the warning comes because of "display: display" but the
fact that lcdif node has a property named "display" and a child node
named "display" at the same time.

Shawn

> 
> Last time on mx28 you asked me to look at mx6qdl-sabresd.dtsi for a
> reference, but display nodes there are inside the ldb node and do not
> have the "display: display", so not sure how to proceed.
> 
> What do you suggest here?
