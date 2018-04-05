From: lukma@denx.de (Lukasz Majewski)
Date: Thu, 5 Apr 2018 16:42:32 +0200
Subject: [PATCH v3] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
In-Reply-To: <CAOMZO5DHtvX64oseDFsLGiYmQPcb3thUrGeLxX8dgp69vUNZMg@mail.gmail.com>
References: <20180405070939.22245-1-lukma@denx.de>
 <CAOMZO5DHtvX64oseDFsLGiYmQPcb3thUrGeLxX8dgp69vUNZMg@mail.gmail.com>
Message-ID: <20180405164134.5ae71ea9@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Hi Lukasz,
> 
> On Thu, Apr 5, 2018 at 4:09 AM, Lukasz Majewski <lukma@denx.de> wrote:
> 
> > +       reg_audio: regulator-audio {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "sgtl5000-supply";
> > +               gpio = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +               regulator-always-on;
> > +       };  
> 
> sgtl5000 has 3 supplies: VDDD, VDDIO, VDDA.
> 
> Which supply does this reg_audio supply to the chip?

It supplies none of the above. This regulator is needed to enable
amplifier output placed after sgtl5000 device.

> 
> Can't you use any of the existing sgtl5000 regulator bindings to
> describe this supply?

As stated before - this supply enables the output of the amplifier.


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180405/78d63f7a/attachment.sig>
