From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Fri, 20 Nov 2015 09:45:48 +0100
Subject: [linux-sunxi] [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
In-Reply-To: <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
 <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
Message-ID: <CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

2015-11-19 23:59 GMT+01:00 Julian Calaby <julian.calaby@gmail.com>:
> Should you possibly hide the 3 clock periods from the user?
>
> I.e. they set whatever they want for the wdelay, we set it to the
> closest number we can that's greater or equal to what they ask for.

That's a good idea and much better than having to remember to subtract
3 cycles from the desired wait time!

But it would mean that this magic number becomes part of the driver
code. I have found no official documentation that mentions those
additional cycles. While I have checked many different transmission
speeds using both CDR1 and CDR2 divider configurations, there is still
the possibility that the behaviour changes with weird SPI module
configurations... And I've only tested it on A20 hardware. So it would
be great if somebody else with access to A10 hardware and an
oscilloscope could check if we have a consistent 3 cycle overhead.

Cheers,

   Marcus
