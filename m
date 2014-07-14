From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 14 Jul 2014 00:01:50 -0300
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <20140711160238.GD21766@n2100.arm.linux.org.uk>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
 <20140711160238.GD21766@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DqixwxXK-=8_9Xwntd3_F9f3p8qJRU2R1+C5KVL=phRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 1:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 11, 2014 at 08:34:19AM -0700, Tim Harvey wrote:
>> I've noticed that for IMX6 the gpio-mxc gpio driver always returns 0
>> for gpio's configured as outputs regardless of if they are outputing
>> high or low.
>
> There's a different way which this can be solved - set the SION but on
> your GPIOs.  You will then be able to read back the state of the
> output pin.

Yes, setting the SION bit is the correct way to solve this.
