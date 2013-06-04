From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Jun 2013 06:50:13 -0400
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <51ADA9F3.9000703@gmail.com>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
 <20130603175629.GH5008@1wt.eu>
 <20130603181437.GO3803@titan.lakedaemon.net>
 <20130603183057.GA9868@1wt.eu>
 <20130603184148.GQ3803@titan.lakedaemon.net>
 <alpine.LFD.2.03.1306031502450.1200@syhkavp.arg>
 <20130603191730.GR3803@titan.lakedaemon.net>
 <20130604101335.6be6ed3b@skate> <51ADA9F3.9000703@gmail.com>
Message-ID: <20130604105013.GY3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 10:48:51AM +0200, Sebastian Hesselbarth wrote:
> On 06/04/13 10:13, Thomas Petazzoni wrote:
> >On Mon, 3 Jun 2013 15:17:31 -0400, Jason Cooper wrote:
> >>>Isn't upstream U-Boot supporting Marvell devices properly these days?
> >>>If so maybe considering a U-Boot upgrade would be the best way forward?
> >>
> >>Yes, both u-boot and barebox are supporting Marvell devices,
> >
> >Sorry Jason, but you're overstating the status of this support:

True.

> >
> >  * Barebox has only *minimal* support for Marvell SoCs, i.e only the
> >    serial console and timers are supported. There is no support for
> >    network, NAND, SPI or anything that even allows to load a kernel and
> >    boot it.
> 
> That remembers me that I wanted to make it boot from DT so we don't
> start adding drivers and add DT later on.
> 
> >  * U-Boot has zero support for Armada 370 and Armada XP, and Sebastian
> >    has tried for several months to push support for Marvell Dove,
> >    without success (lack of review/interest from the U-Boot
> >    maintainers, if I remember correctly).
> 
> True. It took about 2 month for a useful review and then the discussion
> was only about naming it orion-something or mv-something. Recently,
> someone picked up that patches and reposted them.. but don't expect them
> to get in quickly.

Sascha Silbe seems to have picked up the ball, and I could've sworn I
saw Tom Rini picked them up.  It shocked me because I thought he was
bypassing Prafulla, but I can't find the email, now.  My mind must be
playing tricks on me.

> >So as of today, the Marvell-specific U-Boot is the /only/ working
> >solution for Armada 370 and Armada XP based platforms, and it will
> >remain this way at least for several months, until we've pushed enough
> >work into Barebox. And even at that time, as you say, users may not
> >necessarily be willing to upgrade their bootloader.
> 
> Well, there is still the possibility to have board-specific dts files.
> If you are stuck for whatever reason with an old boot loader, append a
> dtb with MAC addresses set for your board. IMHO, adding workarounds for
> every single boot loader just because we don't want anybody to either
> update or manually patch the dts is ridiculous.

Agreed.

thx,

Jason.
