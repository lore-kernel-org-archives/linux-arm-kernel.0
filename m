From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 13 Feb 2015 17:59:36 +0100
Subject: [PATCH 4/5] ARM: dts: imx28-apf28dev: add support for can0
In-Reply-To: <20150213163131.23cbffb5@x230.trabucayre.com>
References: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-4-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <20150213155358.12678942@ipc1.ka-ro>
 <20150213163131.23cbffb5@x230.trabucayre.com>
Message-ID: <20150213175936.7dcecb8b@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

gwenhael.goavec wrote:
> Hi,
> 
> On Fri, 13 Feb 2015 15:53:58 +0100
> Lothar Wa?mann <LW@KARO-electronics.de> wrote:
> 
> > Hi,
> > 
> > Gwenhael Goavec-Merou wrote:
> > > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > > Signed-off-by: Sebastien Szymanski <sebastien.szymanski@armadeus.com>
> > > ---
> > >  arch/arm/boot/dts/imx28-apf28dev.dts | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> > > index 68405c3..a052d3e 100644
> > > --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> > > +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> > > @@ -110,6 +110,13 @@
> > >  					};
> > >  				};
> > >  			};
> > > +
> > > +			can0: can at 80032000 {
> > >
> > Did you compile-test this? It should produce a build error, since
> > the label can0 already exists in imx28.dtsi.
> Compile fine and without error. It's the same thing for all labels in 
> this dts file.
> > You should use:
> > |&can0 {
> > |				pinctrl-names = "default";
> > |				pinctrl-0 = <&can0_pins_a>;
> > |				xceiver-supply = <&reg_can0_vcc>;
> > |				status = "okay";
> > |};
>
I also noticed now, that defining a label for the same node twice is OK
with the dtc-compiler.
But you could simplify your dts files and make them more readable by
referencing the existing labels (like all the other platforms do)
rather than reproducing the whole tree structrure in your files.

Thus instead of:
|	apb at 80000000 {
|		apbh at 80000000 {
|			gpmi-nand at 8000c000 {
[...]
|		};
|
|		apbx at 80040000 {
|			duart: serial at 80074000 {
[...]

you would only have:
|&duart {
	[...]
|};
|
|&gpmi {
|	[...]
|};
in your dts files.
Sorting the labels alphabetically additionally helps readability.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
