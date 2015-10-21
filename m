From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 16:29:00 +0200
Subject: [linux-sunxi] [PATCH v2 1/1] dts: sun6i: yones toptech bs1078
 v2: Add AXP221 support to dts
In-Reply-To: <CAGb2v65S9R=sLVRBdUKFUDXCbEFJWF9Sp8Yw__+Q6ncpgPp7kg@mail.gmail.com>
References: <1445191673-8869-1-git-send-email-lyu@micile.com>
 <CAGb2v65S9R=sLVRBdUKFUDXCbEFJWF9Sp8Yw__+Q6ncpgPp7kg@mail.gmail.com>
Message-ID: <20151021142900.GD10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Oct 19, 2015 at 05:59:20PM +0800, Chen-Yu Tsai wrote:
> > +/* Voltage source for I2C pullup resistors for I2C Bus 0 */
> > +&reg_dldo3 {
> > +       regulator-always-on;
> > +       regulator-min-microvolt = <2800000>;
> > +       regulator-max-microvolt = <2800000>;
> > +       regulator-name = "vcc-csi";
> 
> This should probably be named "vddio-csi".
> 
> I think Maxime and Hans were still debating whether the camera VDDIO
> regulator should be defined independently as "always-on", instead of
> having the I2C subsystem do some kind of power sequencing.
> 
> I wonder if the power domain stuff would work for this.

Probably not, power domains are more targeted for in-SoC supplies
(like when you can gate the power controler by controler).

This is for external signals.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/6a75fa3c/attachment.sig>
