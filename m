From: lukma@denx.de (Lukasz Majewski)
Date: Tue, 29 May 2018 17:09:39 +0200
Subject: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
In-Reply-To: <CAOMZO5AU8PDEErHeU1yb9mwgNLJUvWipTrDsY8csXSHiNro-7w@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
 <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
 <20180519140202.3449e3c1@jawa>
 <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
 <20180529155736.275e27b1@jawa>
 <CAOMZO5AU8PDEErHeU1yb9mwgNLJUvWipTrDsY8csXSHiNro-7w@mail.gmail.com>
Message-ID: <20180529170939.68419862@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Hi Lukasz,
> 
> On Tue, May 29, 2018 at 10:58 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
> 
> > Sorry for "small" delay on this.
> >
> > Ok, so I've investigated the issue:
> >
> > 1. The code, which you pasted:
> > http://code.bulix.org/ik01yu-339697
> >
> > works correctly as imx53-qsb-common.dtsi directly includes
> > "imx53.dtsi" in which iomuxc label is defined.
> >
> > In my case though,
> >
> > 2. I do include imx53-tqma53.dtsi [1], in which the iomuxc" label
> > is extended:
> >
> > &iomuxc {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&pinctrl_hog>;
> >
> >         imx53-tqma53 {
> >                 pinctrl_hog: hoggrp {
> >
> > .......
> >
> > };
> >
> > The imx53-tqma53.dtsi then includes imx53.dtsi.
> >
> > Moreover, my file -> imx53-kp.dtsi as it includes [1], it extends
> > further the &iomuxc label:
> >
> > &iomuxc {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&pinctrl_kp_common>;
> >
> >         imx53-kp-common {
> >                 pinctrl_buzzer: buzzergrp {
> > .......
> > };
> >
> > So, when I remove imx53-kp-common I will have mismatch with [1]
> > iomuxc structure.
> >
> > The code works as expected when I do remove imx53-tqma53 in [1].
> >
> > However, I would prefer to not touch this imx53-tqma53.dtsi file.
> > It is also included in: imx53-mba53.dts, which extends iomux in
> > following way:
> >
> > &iomuxc {
> >         lvds1 {
> >                 pinctrl_lvds1_1: lvds1-grp1 {
> >
> >
> > Here I would need to remove lvds1, disp1 and tve to make it working.
> > However, it will not break during build, but at run time.
> >
> > Considering the above, I would prefer to leave the code in [1] as is
> > and use imx53-kp-common as well (as in v2 of this patch).
> >
> > Fabio, what do you think?  
> 
> Ok, thanks for the clarification. I just wanted to make sure we did
> not have some kind of iomux bug there.
> 
> I think your proposed patch is fine then.

Would you be so kind and add your Reviwed-by or Acked-by tag to second
version of this patch?

[PATCH v2] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards from
K+P

> 
> Thanks




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/cea5a333/attachment.sig>
