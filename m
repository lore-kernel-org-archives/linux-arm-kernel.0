From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 17 Jan 2014 16:09:34 -0700
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <20140117202015.GE25911@pengutronix.de>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org> <20140117202015.GE25911@pengutronix.de>
Message-ID: <52D9B82E.50301@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 01/17/2014 01:20 PM, Uwe Kleine-K?nig wrote:
> On Fri, Jan 17, 2014 at 12:40:02PM -0700, Stephen Warren wrote:
>> On 01/17/2014 11:47 AM, Russell King - ARM Linux wrote:
>
 > <snip>
>
> Other than that I see five possibilities:
>
 > ...
>   b) check if for the requested gpio pad the SION bit is set and read the
>      pad value if it is, return 0 otherwise. (But note, after thinking
>      again I don't believe this to be possible, because there is usually >1
>      pad that can output a given gpio. Moreover AFAIK the information to
>      which pads a given gpio can be routed is missing in the kernel. That
>      could be fixed, that would result in a big table though. (And the
>      first problem is still unfixed.))

It would be a hassle to collect the data, but it seems that a table
of 2-byte offsets would be < 500 bytes for the 7 banks of GPIOs
on each platform (MX51,53,6DQ,6DLS).

Using this, it would be possible to set SION if/when a GPIO is
configured as an output, which would be much less intrusive than
setting the bit for all GPIO pads.

The current dts files show less than 10 pads being set up as GPIOs of 
any sort for current board files. I suspect that this is because many
are incomplete and leave some pad setup to the boot loader though.

Regards,


Eric
