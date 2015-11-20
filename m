From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 10:12:46 -0600
Subject: [linux-sunxi] [PATCH] spi: dts: sun4i: Add support for
 inter-word wait cycles using the SPI Wait Clock Register
In-Reply-To: <CAGNoLaOOz2ACtS5iRUxjOknisMHm2Ow3OVsLkqpWuNU4J-9v-A@mail.gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
 <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
 <CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ@mail.gmail.com>
 <CAGRGNgV0kOkye-Zu4WGQKgGim7N2HB9rAFJ3HNQS89Rr6_WexQ@mail.gmail.com>
 <CAGNoLaOOz2ACtS5iRUxjOknisMHm2Ow3OVsLkqpWuNU4J-9v-A@mail.gmail.com>
Message-ID: <20151120161246.GB21921@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 02:56:34PM +0100, Marcus Weseloh wrote:
> Hi Julien,
> 
> 2015-11-20 11:12 GMT+01:00 Julian Calaby <julian.calaby@gmail.com>:
> > Having magic numbers is kind-of a drivers' job.

I guess all my comments were already raised...

> 
> Yes, of course. What I meant was that I didn't feel comfortable to
> include this magic number in driver code because I'm not 100% sure if
> it is correct across all SPI configurations and SoCs that this driver
> supports (A10 / A20).

You could not subtract off 3 that way you meet the minimum time no 
matter what. If other platforms are not setting this property, then I 
would expect the behavior is unchanged. If they do want to set it, it is 
their job to validate that it is correct. If it differs, the compatible 
string can help with that.

> > (and the wdelay should
> > arguably be a core-spi thing, not a sunxi thing, but that's a separate
> > discussion)
> 
> I've been thinking about that, but it seemed to big a change to
> attempt with my limited kernel hacking experience.

It is not any bigger. You just need to document it in the core binding. 
It would still be read by the drivers using it.

> Mark, do you think we should rather talk about adding support for
> options like this delay to spi-core? Or would it be OK to add it to
> the sun4i driver and possibly refactor later?
> 
> Cheers,
> 
>   Marcus
