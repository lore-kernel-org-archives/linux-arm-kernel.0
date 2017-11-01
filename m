From: john.weber@technexion.com (John Weber)
Date: Wed, 1 Nov 2017 17:24:52 +0000
Subject: [PATCH v2] ARM: dts: imx7d-pico: Add Wifi support
In-Reply-To: <CAP9ODKpjhob8kqr+xMi6aqnVkd82JwpdJ_3cLJ_K6Ap7nAfApQ@mail.gmail.com>
References: <1503056221-29183-1-git-send-email-vanessa.maegima@nxp.com>
 <CAP9ODKrp1+-u+OvuXLv_k7rpo-5Y6DpoxHFA+2zXM=XbPA7GBQ@mail.gmail.com>
 <1509539876.4068.2.camel@nxp.com>
 <CAP9ODKpjhob8kqr+xMi6aqnVkd82JwpdJ_3cLJ_K6Ap7nAfApQ@mail.gmail.com>
Message-ID: <FE0F1D02-95E6-474A-B549-9F113B87835D@technexion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/1/17, 7:47 AM, "Otavio Salvador" <otavio.salvador@ossystems.com.br> wrote:

    On Wed, Nov 1, 2017 at 10:38 AM, Vanessa Maegima
    <vanessa.maegima@nxp.com> wrote:
    > On Ter, 2017-10-31 at 16:11 -0200, Otavio Salvador wrote:
    >> On Fri, Aug 18, 2017 at 8:37 AM, Vanessa Maegima
    >> <vanessa.maegima@nxp.com> wrote:
    >> >
    >> > imx7d-pico has an ap6212 wifi chip connected to usdhc2 port.
    >> >
    >> > Add support for the usdhc2 port and to the WL_REG_ON regulator
    >> > so Wifi can be functional on this board.
    >> >
    >> > Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
    >> It seems the name of the dtb is misleading ... this dtb refers mostly
    >> to the imx7d-pico-pi board no?
    >>
    >
    > Yes, this refers to the imx7d-pico-pi board. At the time I added this
    > support, I was not aware of the board variants as I had only the pico-
    > pi baseboard. I can work to separate this dts into SoM and baseboard
    > dts if you think this would be better, but I can only support pico-pi
    > as I do not have access to the other baseboards.
    
    Agreed, splitting it makes sense.
    
    I think we'd need to:
    
    - rename imx7d-pico.dts to imx7d-pico.dtsi
    - make a new imx7d-pico.dts to keep compatibility (Shawn is it need?)
    - try to make a imx7d-pico-pi.dts that includes imx7d-pico.dtsi and
    technexion-pico-pi.dtsi?
    
    It allows for adding the imx6ul-pico-pi and also split hobit baseboard as well.

This is the way that it has been done in the TechNexion downstream kernel based on NXP?s 4.1.15 kernel:

For reference:
https://github.com/TechNexion/linux/tree/tn-imx_4.1.15_2.0.0_ga/arch/arm/boot/dts

We have split the baseboards out into .dtsi files with ?baseboard_pico_(pi,nymph,hobbit,dwarf).dtsi?

John
