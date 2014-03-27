From: john.tobias.ph@gmail.com (John Tobias)
Date: Thu, 27 Mar 2014 13:33:56 -0700
Subject: iMX6 GPIO input
In-Reply-To: <CACUGKYPMJ5Cf4D61Ta_A1t6UuGL2s18V=caPS+skP8jbqnKE8Q@mail.gmail.com>
References: <CACUGKYPMJ5Cf4D61Ta_A1t6UuGL2s18V=caPS+skP8jbqnKE8Q@mail.gmail.com>
Message-ID: <CACUGKYObKh=ApqFrDGdQLEA+pPepMgJUvotrK+dijFCWmNJB=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, I found it.
I need to set the active_low to 1 in order to return 0 or 1.
echo 1 > /sys/class/gpio/gpio86/active_low

Regards,

john

On Thu, Mar 27, 2014 at 12:56 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello all,
>
> I am using kernel 3.13 at the same time I pulled the latest for-next
> of Shawn's repo. For the testing, I un-allocated the gpio3 pin 22 by
> disabling cd-gpios = <&gpio3 22 0>;  in ushdc3 of imx6sl-evk.dts file
> in order to export it in the userspace.
>
> Then, I do the following in the userspace:
>
> echo 86 > /sys/class/gpio/export
> echo in > /sys/class/gpio/gpio86/direction
> cat /sys/class/gpio/gpio86/value
>
> I got 4194304 value which is correspond to gpio3 pin 22. If the SD
> card is inserted, I got 0.
>
> Previously, the gpio should return 1 or 0 (depending how the gpio is
> configured). But, now it was returning a value based on bit
> representation of the pin.
>
> Is these a new implementation or it is a bug?
>
> Regards,
>
> john
