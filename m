From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Wed, 4 May 2011 17:57:50 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <4DC163D7.9010309@grandegger.com>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<201104271525.28512.arnd@arndb.de>
	<15AD189F851849F69A011B6F4D1DDB6C@subhasishg>
	<201105041511.54095.arnd@arndb.de>
	<4DC163D7.9010309@grandegger.com>
Message-ID: <20110504155750.GC322@e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> > How hard would it be to implement that feature in Socket CAN?
> 
> CAN controllers usually provide some kind of hardware CAN id filtering,
> but in a very hardware dependent way. A generic interface may be able to
> handle the PRUSS restrictions as well. CAN devices are usually
> configured through the netlink interface. e.g.
> 
>   $ ip link set can0 up type can bitrate 125000
> 
> and such a common interface would be netlink based as well.
ack.
> 
> > Is that something that Subhasish or someone else could to as a prerequisite
> > to merging the driver?
> 
> Any ideas on how to handle hardware filtering in a generic way are
> welcome. I will try to come up with a proposal sooner than later.

When doing so, I'd vote for an unlimited(by software) list of hardware filters (id/mask).
The hardware must abort when no more filters are available.
I think that when using hardware filters, knowing the actual device
with it's amount of hardware filters is the least of your problems.
Userspace applications that suddenly stop working properly due to
hw filters (i.e. some traffic not coming in anymore) will be a major
source of bugreports.

Kurt
