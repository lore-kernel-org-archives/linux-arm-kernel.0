From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 26 Jan 2015 20:46:45 +0100 (CET)
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <20150125150431.GE2719@earth.universe>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
Message-ID: <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Sebastian Reichel <sre@kernel.org> hat am 25. Januar 2015 um 16:04
> geschrieben:
>
>
> Hi,
>
> [add maintainers from regulator framework]
>
> On Thu, Jan 22, 2015 at 09:08:04AM +0100, Stefan Wahren wrote:
> > Am 22.01.2015 um 00:01 schrieb Sebastian Reichel:
> > > On Thu, Nov 20, 2014 at 08:14:36PM +0000, Stefan Wahren wrote:
> > >> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> > >> power subsystem. It's required to trigger the probing of the underlying
> > >> drivers like on-chip regulators. Additionally the drivers supports
> > >> the configuration of the DC-DC clock frequency to avoid possible
> > >> interferences.
> > > I would expect PLL to be board specific and part of DT. Why is it
> > > specified as parameter?
> >
> > I think the switching frequency of the DC-DC belongs to the
> > configuration and don't describe how the hardware is connected. But i
> > don't have a problem to change it into a DT property.
> >
> > Does a common property name exists for the switching frequency or would
> > it be vendor specific?
>
> As far as I know most regulators have fixed switching frequencies,
> so there is no common property name so far. I added regulator
> framework people, since this property should be regulator specific.
>
> Apart from introducing a custom/common switching-frequency property
> the dts could also expose the PLL like this and use the common
> clock-frequency property:
>
> power: power at 80044000 {
> compatible = "fsl,imx28-power";
> #address-cells = <1>;
> #size-cells = <1>;
> reg = <0x80044000 0x2000>;
> interrupts = <6>;
> ranges;
>
> powerpll {
> compatible = "fsl,imx28-power-pll"
> #clock-cells = <0>;
> clock-frequency = <12345>;
> }
> }

okay i understand. But doesn't it need a extra driver to set the switching
frequency because of the new compatible string?

At this point i think about moving this feature into the bootloader.

@Fabio, @Marek:

What's your opinion about that?

>
> -- Sebastian

Stefan
