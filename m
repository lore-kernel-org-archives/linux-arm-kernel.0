From: lukma@denx.de (Lukasz Majewski)
Date: Thu, 24 May 2018 00:18:33 +0200
Subject: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
In-Reply-To: <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
 <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
 <20180519140202.3449e3c1@jawa>
 <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
Message-ID: <20180524001833.58b9b59d@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Hi Lukasz,
> 
> On Sat, May 19, 2018 at 9:02 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
> 
> > After removing imx53-kp-ddc and imx53-kp-common iomux subnodes I do
> > see following errors in the dmesg (v4.17-rc5):
> >
> > imx53-pinctrl 53fa8000.iomuxc: function 'iomuxc' not supported
> > imx53-pinctrl 53fa8000.iomuxc: invalid function iomuxc in map
> > table  
> 
> Could you please investigate this error?
> 

Ok.

> I have just tried the following change on a imx53-qsb:
> http://code.bulix.org/ik01yu-339697

I've noticed that this is the "common" dtsi file:
imx53-qsb-common.dtsi

Is there any board inheriting it? Is it extending the iomux node with
its own code ?

> 
> and it works as expected:
> # dmesg  | grep iomux
> [    0.100046] imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl
> driver




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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/396e6327/attachment.sig>
