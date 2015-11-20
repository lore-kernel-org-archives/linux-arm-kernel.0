From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Fri, 20 Nov 2015 17:45:48 +0100
Subject: [linux-sunxi] [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
In-Reply-To: <20151120161246.GB21921@rob-hp-laptop>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
 <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
 <CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ@mail.gmail.com>
 <CAGRGNgV0kOkye-Zu4WGQKgGim7N2HB9rAFJ3HNQS89Rr6_WexQ@mail.gmail.com>
 <CAGNoLaOOz2ACtS5iRUxjOknisMHm2Ow3OVsLkqpWuNU4J-9v-A@mail.gmail.com>
 <20151120161246.GB21921@rob-hp-laptop>
Message-ID: <CAGNoLaPLXOmObXgW0YsN8giM1WCRDn7MieTBcKOE5sjXbjg0GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-20 17:12 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Fri, Nov 20, 2015 at 02:56:34PM +0100, Marcus Weseloh wrote:
>> > (and the wdelay should
>> > arguably be a core-spi thing, not a sunxi thing, but that's a separate
>> > discussion)
>>
>> I've been thinking about that, but it seemed to big a change to
>> attempt with my limited kernel hacking experience.
>
> It is not any bigger. You just need to document it in the core binding.
> It would still be read by the drivers using it.

Julien, Rob: thanks for your comments! Ok, I will make the following changes:

- remove "sun4i,spi-wdelay" from the sun4i binding and add the
property to the spi-bus.txt binding instead
- remove the comment about the additional 3 cycles from the documentation
- modfy the spi-sun4i driver to take care of the minimum 3 cycle period

Does that sound right?

And maybe I could also use a more descriptive name for the property,
maybe "spi-word-wait-cycles"?

Cheers,

   Marcus
