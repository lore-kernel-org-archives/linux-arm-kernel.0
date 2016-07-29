From: michael.weiser@gmx.de (Michael Weiser)
Date: Fri, 29 Jul 2016 20:55:38 +0200
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <20160729163907.GD6215@lukather>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-4-michael.weiser@gmx.de>
 <20160722090101.GB7687@lukather>
 <20160722135658.GA18977@weiser.dinsnail.net>
 <20160725122522.GL7419@lukather>
 <20160726192609.GA27782@weiser.dinsnail.net>
 <CAGb2v67O5vrqN4m3rZVBGA+ee1bg2iTxiggNJF+t5Lszd=mW=A@mail.gmail.com>
 <20160729075923.GE415@weiser.dinsnail.net>
 <20160729163907.GD6215@lukather>
Message-ID: <20160729185538.GA7042@weiser.dinsnail.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, Jul 29, 2016 at 06:39:07PM +0200, Maxime Ripard wrote:

> > it doesn't seem to accept incoming packets. I suspect that programming
> > of its own MAC address (which the driver chooses randomly) suffers from
> > an endianness issue. I'm somewhat stumped as to what is causing it since
> Maybe a good way to confirm that would be to generate outgoing
> traffic, dump that and see what the mac address is? If it's not
> programmed properly, you should see it in the packets.

That's what I've done: When trying to ping another machine, with tcpdump
I see ARP requests coming from the cubieboard with the right MAC and I
see the target machine sending ARP responses to the right MAC. But I do
not see them coming in with tcpdump on the cubieboard.

The same process works fine with a little-endian kernel (same .config and
dtb) and userland, so I'm sure it's an endianess issue somewhere.

I'll do some more comparison of little- and big-endian kernel behaviour
and dig a bit deeper into the code.
-- 
Thanks,
Michael
