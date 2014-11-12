From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 12 Nov 2014 13:48:01 +0000
Subject: [PATCH 12/13] ARM: STi: DT: STiH410: Add STiH410 SoC clock
 support.
In-Reply-To: <88469624.TsXJ3Gpfe2@wuerfel>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-13-git-send-email-peter.griffin@linaro.org>
 <88469624.TsXJ3Gpfe2@wuerfel>
Message-ID: <20141112134801.GB20187@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for reviewing.

> On Friday 07 November 2014 11:57:54 Peter Griffin wrote:
> > +
> > +       soc {
> > +
> > +               ohci0: usb at 9a03c00 {
> > +                       status = "okay";
> > +               };
> > +
> > +               ehci0: usb at 9a03e00 {
> > +                       status = "okay";
> > +               };
> > +
> > +               ohci1: usb at 9a83c00 {
> > +                       status = "okay";
> > +               };
> > +
> > +               ehci1: usb at 9a83e00 {
> > +                       status = "okay";
> > +               };
> > +       };
> > +};
> > 
> 
> These seem to refer to an existing device in the base dtsi file. Just put the label
> in the shared file and remove the exact names here. Alternatively, drop the labels
> you don't use.

Based on Maximes feedback in V2 I've created a seperate stih410.dtsi file
which has the extra ehci / ohci device nodes in it. This means they don't need to be
enabled in the board file any more.

regards,

Peter.
