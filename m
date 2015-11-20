From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Fri, 20 Nov 2015 14:56:34 +0100
Subject: [linux-sunxi] [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
In-Reply-To: <CAGRGNgV0kOkye-Zu4WGQKgGim7N2HB9rAFJ3HNQS89Rr6_WexQ@mail.gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
 <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
 <CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ@mail.gmail.com>
 <CAGRGNgV0kOkye-Zu4WGQKgGim7N2HB9rAFJ3HNQS89Rr6_WexQ@mail.gmail.com>
Message-ID: <CAGNoLaOOz2ACtS5iRUxjOknisMHm2Ow3OVsLkqpWuNU4J-9v-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

2015-11-20 11:12 GMT+01:00 Julian Calaby <julian.calaby@gmail.com>:
> Having magic numbers is kind-of a drivers' job.

Yes, of course. What I meant was that I didn't feel comfortable to
include this magic number in driver code because I'm not 100% sure if
it is correct across all SPI configurations and SoCs that this driver
supports (A10 / A20).

> (and the wdelay should
> arguably be a core-spi thing, not a sunxi thing, but that's a separate
> discussion)

I've been thinking about that, but it seemed to big a change to
attempt with my limited kernel hacking experience.

Mark, do you think we should rather talk about adding support for
options like this delay to spi-core? Or would it be OK to add it to
the sun4i driver and possibly refactor later?

Cheers,

  Marcus
