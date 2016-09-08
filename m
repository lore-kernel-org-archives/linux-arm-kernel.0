From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Sep 2016 22:26:17 +0800
Subject: [PATCH v2 0/7] ARM: dts: imx: add gpio-ranges properties to some
 iMX GPIO controllers
In-Reply-To: <a97478e5-e423-2c9b-de71-3341c76ff4fe@mentor.com>
References: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <a97478e5-e423-2c9b-de71-3341c76ff4fe@mentor.com>
Message-ID: <20160908142617.GG16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 06:31:15PM +0300, Vladimir Zapolskiy wrote:
> Hello Shawn, Fabio.
> 
> On 08/20/2016 11:04 PM, Vladimir Zapolskiy wrote:
> >% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' \
> >	arch/arm/boot/dts/imxXX-pinfunc.h | sort -n
> >
> >Note that this means that potential errors in arch/arm/boot/dts/imx*-pinfunc.h
> >descriptions may migrate to this change, please double check the values.
> >
> >If needed similar changes may be done for the rest of iMX SoCs.
> >
> >Changes from v1 to v2:
> >* in copy-pasted commit messages corrected SoC names
> >
> >Vladimir Zapolskiy (7):
> >  ARM: dts: add gpio-ranges property to iMX50 GPIO controllers
> >  ARM: dts: add gpio-ranges property to iMX6Q/D GPIO controllers
> >  ARM: dts: add gpio-ranges property to iMX6DL/S GPIO controllers
> >  ARM: dts: add gpio-ranges property to iMX6SL GPIO controllers
> >  ARM: dts: add gpio-ranges property to iMX6SX GPIO controllers
> >  ARM: dts: add gpio-ranges property to iMX6UL GPIO controllers
> >  ARM: dts: add gpio-ranges property to iMX7D/S GPIO controllers
> >
> > arch/arm/boot/dts/imx50.dtsi  | 16 +++++++++++++
> > arch/arm/boot/dts/imx6dl.dtsi | 53 +++++++++++++++++++++++++++++++++++++++++++
> > arch/arm/boot/dts/imx6q.dtsi  | 37 ++++++++++++++++++++++++++++++
> > arch/arm/boot/dts/imx6sl.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++++
> > arch/arm/boot/dts/imx6sx.dtsi | 14 ++++++++++++
> > arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++
> > arch/arm/boot/dts/imx7s.dtsi  | 14 ++++++++++++
> > 7 files changed, 197 insertions(+)
> >
> 
> Gentle ping, please provide review comments, the change would be good
> to have in v4.9.

I'm fine to pick them up, but can you please squash them into one patch
and drop the newline right before gpio-ranges property?

Shawn
