From: syin@broadcom.com (Sherman Yin)
Date: Fri, 7 Mar 2014 16:49:40 -0800
Subject: pinctrl: pinctrl-single vs custom driver
In-Reply-To: <CACRpkdYhCDpKxkMxcHHLyp2mTf8-3mhioZkNqQACHcKjL+3erQ@mail.gmail.com>
References: <530BFEC0.2070805@broadcom.com>
 <CACRpkdYhCDpKxkMxcHHLyp2mTf8-3mhioZkNqQACHcKjL+3erQ@mail.gmail.com>
Message-ID: <531A6924.8080009@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Like the bcm281xx, in this SoC, each pin is also controlled by 1 register,
>> so pinctrl-single should work.
>
> One other deciding factor is what kind of information you have available
> on these pin registers and what format they are in. If your system is
> well documented and not delivered in some register map description
> format you should typically open code the hardware information in the
> driver.

The info available is similar to the bcm281xx pinctrl driver - basically 
just what is available in the binding documentation.  Although that is 
still not 100% clear, it is still much better than just numerical 
register values.


>> Is this efficiency enough to warrant using pinctrl-single over a "normal"
>> pinctrl driver in this case?
>
> So I would say that this code execution is likely not on the time-critical
> path?

Pins are typically changed on suspend/resume to save power, so I don't 
think it is time-critical.  Also, I could cache the pin values (provided 
we can assure that all software change pins via my driver) to save a few 
messages should timing/messaging congestion become a concern.  I won't 
implement the cache unless we really run into timing problems without it.

> Also take the debuggability and understandability of the code as a
> very important factor. Which driver will be easiest for a developer to
> cope with, and which will be easiest to use when debugging the
> system?

Okay.  The new driver will be similar to the bcm281xx one and will not 
be based on pinctrl-single, so that code is a bit easier to understand 
and the device tree nodes will be more readable.

Thanks for your input, Linus!

Regards,
Sherman
