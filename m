From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 17 May 2013 14:38:07 +0200
Subject: [PATCH 0/5 v2] ARM: at91: dt: switch to pre-processor
In-Reply-To: <5195EA33.4010400@atmel.com>
References: <20130515141906.GI22508@game.jcrosoft.org>
 <5195EA33.4010400@atmel.com>
Message-ID: <20130517123807.GA16804@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:28 Fri 17 May     , Nicolas Ferre wrote:
> On 15/05/2013 16:19, Jean-Christophe PLAGNIOL-VILLARD :
> >HI,
> >
> >	v2:
> >	 use common IRQ define
> >	 split patch
> >	 rebase on 3.10-rc1
> >
> >         The follow patch series switch the at91 to DT pre-processor
> >
> >         So we can use macro for AIC and Pinctrl instead of magic
> 
> Hi, this is very good for me: nice to use the common GPIO and IRQ
> defines. It increases readability a lot!
and avoid typo when adding pinctrl
> 
> So, it seems natural to push this series through arm-soc. It would
> be integrated early in a "cleanup" branch for 3.11.
> We also would like to make it a prerequisite for all AT91 material
> that are touching the changed files, targeted for 3.11.

agreed
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Best Regards,
J.
> 
> Thanks, best regards.
> 
> >The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> >
> >   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> >
> >are available in the git repository at:
> >
> >   git://github.com/at91linux/linux-at91.git j/for-3.11-dt
> >
> >for you to fetch changes up to 3668ac6a70bc5af71a947ad7b531c57b8a787ea0:
> >
> >   ARM: at91: dt: switch to standard IRQ flag defines (2013-05-15 21:56:18 +0800)
> >
> >----------------------------------------------------------------
> >Jean-Christophe PLAGNIOL-VILLARD (5):
> >       ARM: at91: dt: use #include for all device trees
> >       ARM: at91: dt: switch to standard GPIO flag defines.
> >       ARM: at91: dt: add pinctrl pre-processor define
> >       ARM: at91: dt: switch to pinctrl to pre-processor
> >       ARM: at91: dt: switch to standard IRQ flag defines
> >
> >  arch/arm/boot/dts/aks-cdu.dts               |   12 +--
> >  arch/arm/boot/dts/animeo_ip.dts             |   18 ++---
> >  arch/arm/boot/dts/at91-ariag25.dts          |    6 +-
> >  arch/arm/boot/dts/at91rm9200.dtsi           |  207 +++++++++++++++++++++++++------------------------
> >  arch/arm/boot/dts/at91rm9200ek.dts          |   10 +--
> >  arch/arm/boot/dts/at91sam9260.dtsi          |  215 ++++++++++++++++++++++++++-------------------------
> >  arch/arm/boot/dts/at91sam9263.dtsi          |  203 ++++++++++++++++++++++++------------------------
> >  arch/arm/boot/dts/at91sam9263ek.dts         |   24 +++---
> >  arch/arm/boot/dts/at91sam9g15.dtsi          |    2 +-
> >  arch/arm/boot/dts/at91sam9g15ek.dts         |    4 +-
> >  arch/arm/boot/dts/at91sam9g20.dtsi          |    2 +-
> >  arch/arm/boot/dts/at91sam9g20ek.dts         |    6 +-
> >  arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   10 +--
> >  arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   28 ++++---
> >  arch/arm/boot/dts/at91sam9g25.dtsi          |    2 +-
> >  arch/arm/boot/dts/at91sam9g25ek.dts         |    4 +-
> >  arch/arm/boot/dts/at91sam9g35.dtsi          |    2 +-
> >  arch/arm/boot/dts/at91sam9g35ek.dts         |    4 +-
> >  arch/arm/boot/dts/at91sam9g45.dtsi          |  213 +++++++++++++++++++++++++-------------------------
> >  arch/arm/boot/dts/at91sam9m10g45ek.dts      |   38 ++++-----
> >  arch/arm/boot/dts/at91sam9n12.dtsi          |  141 +++++++++++++++++-----------------
> >  arch/arm/boot/dts/at91sam9n12ek.dts         |   14 ++--
> >  arch/arm/boot/dts/at91sam9x25.dtsi          |   22 +++---
> >  arch/arm/boot/dts/at91sam9x25ek.dts         |    4 +-
> >  arch/arm/boot/dts/at91sam9x35.dtsi          |    2 +-
> >  arch/arm/boot/dts/at91sam9x35ek.dts         |    4 +-
> >  arch/arm/boot/dts/at91sam9x5.dtsi           |  279 +++++++++++++++++++++++++++++++++---------------------------------
> >  arch/arm/boot/dts/at91sam9x5cm.dtsi         |    8 +-
> >  arch/arm/boot/dts/at91sam9x5ek.dtsi         |   14 ++--
> >  arch/arm/boot/dts/ethernut5.dts             |    6 +-
> >  arch/arm/boot/dts/evk-pro3.dts              |    6 +-
> >  arch/arm/boot/dts/ge863-pro3.dtsi           |    2 +-
> >  arch/arm/boot/dts/kizbox.dts                |   16 ++--
> >  arch/arm/boot/dts/mpa1600.dts               |    4 +-
> >  arch/arm/boot/dts/pm9g45.dts                |   22 +++---
> >  arch/arm/boot/dts/sama5d3.dtsi              |  520 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
> >  arch/arm/boot/dts/sama5d31ek.dts            |    6 +-
> >  arch/arm/boot/dts/sama5d33ek.dts            |    4 +-
> >  arch/arm/boot/dts/sama5d34ek.dts            |    6 +-
> >  arch/arm/boot/dts/sama5d35ek.dts            |    4 +-
> >  arch/arm/boot/dts/sama5d3xcm.dtsi           |    4 +-
> >  arch/arm/boot/dts/sama5d3xdm.dtsi           |    2 +-
> >  arch/arm/boot/dts/sama5d3xmb.dtsi           |   26 +++----
> >  arch/arm/boot/dts/tny_a9260.dts             |    4 +-
> >  arch/arm/boot/dts/tny_a9263.dts             |    4 +-
> >  arch/arm/boot/dts/tny_a9g20.dts             |    4 +-
> >  arch/arm/boot/dts/usb_a9260.dts             |    4 +-
> >  arch/arm/boot/dts/usb_a9260_common.dtsi     |    6 +-
> >  arch/arm/boot/dts/usb_a9263.dts             |    8 +-
> >  arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi    |   22 +++---
> >  arch/arm/boot/dts/usb_a9g20.dts             |    4 +-
> >  include/dt-bindings/pinctrl/at91.h          |   35 +++++++++
> >  52 files changed, 1139 insertions(+), 1078 deletions(-)
> >  create mode 100644 include/dt-bindings/pinctrl/at91.h
> >
> >Best Regards,
> >J.
> >
> >
> 
> 
> -- 
> Nicolas Ferre
