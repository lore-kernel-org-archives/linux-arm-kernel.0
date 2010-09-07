From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Tue, 7 Sep 2010 21:13:12 +0200
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <569801.35222.qm@web180310.mail.gq1.yahoo.com>
References: <4C85BEFD.402@bluewatersys.com>
	<569801.35222.qm@web180310.mail.gq1.yahoo.com>
Message-ID: <AANLkTinq98+ryOOKx1o1o21x9VnHz3nRCHh=5Wwixn4o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> NAK still. ?You're trying to abuse gpio_is_valid(),
> which I see no need to support.
>
> In terms of GPIO framework architecture, zero is
> the first GPIO in all cases, and is always
> a valid GPIO number, even if it's not
> requestable/swritable/readable on a given board.
>
> Whether it's usable on a given platform depends
> on whether a GPIO controller is registered which
> claims numbers 0..N ... (assuming gpiolib in use).

How should the following be done in a driver then?

   if (gpio_is_valid(device->output_pin)) {
         if (gpio_request(device->output_pin, "driverX") != 0)
             goto error_handling;

         /* continue with gpio setup */
    }
    else {
        /* there is no vcc_pin, so don't do any gpio setup */
    }

    ....

   if (gpio_is_valid(device->output_pin)) {
       /* set value high */
   }


Regards,
  Andrew Victor
