From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 21 Feb 2013 08:37:18 +0100
Subject: GPIO sysfs 'default' values
In-Reply-To: <1361430680.10390.7.camel@gitbox>
References: <1361430680.10390.7.camel@gitbox>
Message-ID: <20773.52910.72747.877165@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Tony Prisk writes:
> Hi Grant, Linus.
> 
> I was testing our new gpio/pinctrl driver today and noticed something a
> little weird.
> 
> I exported gpio0 via sysfs and echoed the direction value - it was 'in'.
> This pin is used to control an LCD panel, and is actually in 'out' mode.
> If I write 'in' to direction, it changes mode to 'in' and the panel
> turns off. Setting it back to 'out' and value=0, and the panel turns on
> again.
> 
> I noticed that I had no gpiochip->get_direction, so I added it, but the
> result was the same.
> 
> Any idea what I've missed?
> 
You missed to report on what platform this happens.
The platform specific GPIO driver obviously does not initialize the
shadow variables for the hardware registers correctly.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
