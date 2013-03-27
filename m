From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 27 Mar 2013 22:23:26 +1300
Subject: [PATCHv2 3/7] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <515204F7.30502@wwwdotorg.org>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
 <1364015633-18580-4-git-send-email-linux@prisktech.co.nz>
 <515083CB.1060908@wwwdotorg.org> <1364237467.18777.9.camel@gitbox>
 <515204F7.30502@wwwdotorg.org>
Message-ID: <1364376206.2160.10.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-26 at 14:28 -0600, Stephen Warren wrote:
> On 03/25/2013 12:51 PM, Tony Prisk wrote:
> > On Mon, 2013-03-25 at 11:05 -0600, Stephen Warren wrote:
> >> On 03/22/2013 11:13 PM, Tony Prisk wrote:
> >>> This patch adds support for the GPIO/pinmux controller found on the VIA
> >>> VT8500 and Wondermedia WM8xxx-series SoCs.
> >>>
> >>> Each pin within the controller is capable of operating as a GPIO or as
> >>> an alternate function. The pins are numbered according to their control
> >>> bank/bit so that if new pins are added, the existing numbering is maintained.
> >>>
> >>> All currently supported SoCs are included: VT8500, WM8505, WM8650, WM8750 and
> >>> WM8850.
> >>
> >>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt
> >>
> >>> +Required properties:
> >>
> >>> +- gpio-controller: Marks the device node as a GPIO controller.
> >>> +- #gpio-cells : Should be two. The first cell is the pin number and the
> >>> +  second cell is used to specify optional parameters.
> >>
> >> What are those optional parameters? This binding should define them.
> >
> > There are actually no optional parameters at the moment - but there will
> > be at some point. In our original GPIO driver binding it was suggested
> > that a flags cell be added. When moving it to the pinctrl driver
> > binding, the bank + pin number cells were combined as we have linear
> > numbering now, and the flags property was retained.
> > 
> > - #gpio-cells : should be <3>.
> > 	1) bank
> > 	2) pin number
> > 	3) flags - should be 0
> > 
> > I will clarify this in the next version.
> 
> I think you should define a flag for inverted or active-low. This is
> typically bit 0 in the flags cell.
> ...

Stephen,

Do you know if there is an example of this somewhere I can look at?

I did a quick search through the documentation for pinctrl and gpio, but
I can't find any code for defining active-low in the gpio flags. There
seems to be plenty for defining interrupt 'modes' but nothing for
setting active-low.

I also couldn't see anywhere where it was possible to interpret the
flags that are passed in. Assuming I add an .of_xlate, and pass, for
example, *flags = gpiospec[2] I can't see anywhere later on where I get
the chance to 'decode' the flags to perform the specific configurations.

Any advice appreciated.

Regards
Tony P
