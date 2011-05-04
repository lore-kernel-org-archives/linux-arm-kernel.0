From: socketcan@hartkopp.net (Oliver Hartkopp)
Date: Wed, 04 May 2011 22:55:25 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <4DC17A31.8070409@grandegger.com>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>	<201104271525.28512.arnd@arndb.de>	<15AD189F851849F69A011B6F4D1DDB6C@subhasishg>	<201105041511.54095.arnd@arndb.de>	<4DC163D7.9010309@grandegger.com>
	<20110504155750.GC322@e-circ.dyndns.org>
	<4DC17A31.8070409@grandegger.com>
Message-ID: <4DC1BD3D.800@hartkopp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.05.2011 18:09, Wolfgang Grandegger wrote:

> On 05/04/2011 05:57 PM, Kurt Van Dijck wrote:

>> When doing so, I'd vote for an unlimited(by software) list of hardware filters (id/mask).
>> The hardware must abort when no more filters are available.
> 
> Sounds good and not even to complicated. For the SJA1000 we would just
> allow to set the global mask.

Yes. "unlimited(by software)" was a bit misleading at first reading, as we
should not filter IDs by software in the irq handler. But to create a API that
supports as much HW filters as the hardware provides is a good idea.

>> I think that when using hardware filters, knowing the actual device
>> with it's amount of hardware filters is the least of your problems.
>> Userspace applications that suddenly stop working properly due to
>> hw filters (i.e. some traffic not coming in anymore) will be a major
>> source of bugreports.
> 
> Well, hardware filtering will be off by default and must explicitly be
> set by the user, like for the bitrate setting.

To be correct: By the admin.

The setting of CAN HW filters has a system-wide effect to all users on the
local host. The same effect as we have for the setting of the bitrate. This is
the major difference to the user-configurable per-socket CAN-ID filters that
are provided e.g. by the CAN_RAW socket.

As the current netlink configuration interface for CAN interfaces is not
accessible for standard users also this would be the right place to extend the
netlink interface.

Regards,
Oliver
