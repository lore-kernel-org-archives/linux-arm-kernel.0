From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 21 Feb 2013 20:27:41 +1300
Subject: GPIO sysfs 'default' values
In-Reply-To: <1361430680.10390.7.camel@gitbox>
References: <1361430680.10390.7.camel@gitbox>
Message-ID: <1361431661.12222.0.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-21 at 20:11 +1300, Tony Prisk wrote:
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
> Regards
> Tony Prisk

Sorted it out.
->get_direction was all that was needed.

Apologies,
Tony P
