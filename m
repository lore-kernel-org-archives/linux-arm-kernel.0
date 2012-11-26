From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Nov 2012 02:03:46 -0800
Subject: [PATCH v3 2/4] ARM: kirkwood: DT board setup for Network Space v2
 and parents
In-Reply-To: <20121126100055.GX10259@lunn.ch>
References: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
 <1350468546-25901-3-git-send-email-simon.guinot@sequanux.org>
 <20121126090253.GI9580@quad.lixom.net>
 <20121126100055.GX10259@lunn.ch>
Message-ID: <CAOesGMjZVvv4yV2U=1880L5+pydz7OEQnr=GNiheLnJxWjZHTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 2:00 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Olof
>
> We are getting near to having boards fully described in DT. The last
> major piece we are missing is a DT binding for the Ethernet driver.
> Once that is in we can remove many of these per-board files and C code
> in board-dt.c. However, this is not going to happen before this merge
> window :-(

Yeah, no worries about timing for 3.8 -- it'll be a nice cleanup for 3.9 or so.

>> Same here. I actually think this is a table that is no longer needed -- the
>> board compat can/should be done on the generic compatible string instead of for
>> each most-specific board string.
>>
>> > +static void ns2_power_off(void)
>> > +{
>> > +   gpio_set_value(NS2_GPIO_POWER_OFF, 1);
>> > +}
>>
>> This kind of thing should be possible to generalize through a generic binding.
>
> Such a generic binding is part of the pull requests. We converted two
> existing boards to this new binding. However, the new boards don't
> make use of a lot of new features we added this cycle, including this
> generic binding and pinctrl. We might have time to convert them before
> the merge window, otherwise it will be one of the first things we do
> for the next cycle.

Yeah, I sent this based on the first branch (boards), and noticed that
some things had already been taken care of in the second one (dt), and
noticed that when I looked at contents when I pulled that in. Talk
about quick turnaround :)

There's no time left to convert for this merge window, so please just
target 3.9 instead by now -- it'll be a nice cleanup for that release.


-Olof
