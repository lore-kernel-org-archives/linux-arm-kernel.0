From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 22 May 2013 10:36:33 +0200
Subject: [PATCH] ARM: iomux-mx51: Always define
 PU E for pins used as GPIO
In-Reply-To: <1369207056.596630214@f96.mail.ru>
References: <1369124845-19244-1-git-send-email-shc_work@mail.ru>
 <1369203552.559574351@f389.i.mail.ru>
 <20892.28064.82907.942799@ipc1.ka-ro>
 <1369207056.596630214@f96.mail.ru>
Message-ID: <20892.33681.753710.620640@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alexander Shiyan writes:
> > Alexander Shiyan writes:
> > > > On Tue, May 21, 2013 at 12:27:25PM +0400, Alexander Shiyan wrote:
> > > > > This patch adds a PUE bit for pins which used as GPIO. This allow
> > > > > to use the GPIOs correctly as inputs when source is open-drain with
> > > > > external pullup resistor (IRQ open-drain outputs for example).
> > > > 
> > > > I don't understand. If there's an external pullup why do you want to
> > > > turn on the internal one?
> > > 
> > > It is just switch off keeper circuit.
> > > 
> > If you want to switch the keeper circuit off why don't you do that by
> > removing PAD_CTL_PKE rather than adding PAD_CTL_PUE?
> 
> Again, I do not know which the solution here is better. If we remove
> the PKE bit, for some pins it will be removed the default pullup/pulldown (PUS = 0),
> so it may affect the some running configuration.
> 
IMO the current approach of defining the pad config with the pad
definition is broken anyway. It would be much better to specify the
pad configuration at the point where a specific pad is used, rather
than where it is defined.
The pin mux setting for a specific function of a pin is always the
same for any platform but the pad config may be different for
different platforms.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
