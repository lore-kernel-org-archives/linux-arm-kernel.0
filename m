From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 18 Apr 2012 14:53:40 +0200
Subject: [patch 1/1] kirkwood: Add iconnect support
In-Reply-To: <20120418104002.GA15924@lunn.ch> (Andrew Lunn's message of "Wed,
 18 Apr 2012 12:40:02 +0200")
References: <20120418104002.GA15924@lunn.ch>
Message-ID: <871unlyze3.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn <andrew@lunn.ch> writes:

Hi,

>> > + 
>> > +#define ICONNECT_BLINK_HALF_PERIOD   100
>> > +
>> > +static int iconnect_blink_set(unsigned gpio, int state,
>>
>>__init ?
>
> Hi Jason
>
> It is correct without __init. This function will get called when you
> play with /sys/class/leds/*/trigger.
>
> However, this is the second public instance of this function, it is
> also in mach-orion5x/dns323-setup.c.

yeah, I know. I initially planned to send a patchset adding iconnect
support and putting this function into something like gpio.c but I
forgot about it when converting my first iconnect patch into DT. Any
objection about sending a patch doing that once I manage to merge the
iconnect support (and of course, in this case, feel free to remind me
of it if I forget to do it ) ?


Arnaud
