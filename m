From: rapatel@apm.com (Ravi Patel)
Date: Sat, 21 Dec 2013 16:43:06 -0800
Subject: [PATCH 2/4] misc: xgene: Add base driver for APM X-Gene SoC Queue
 Manager/Traffic Manager
In-Reply-To: <20131220042426.GA21726@kroah.com>
References: <1387507503-7565-1-git-send-email-rapatel@apm.com>
 <1387507503-7565-3-git-send-email-rapatel@apm.com>
 <20131220032133.GB32310@kroah.com>
 <CAN1v_PuBZHN85xTodfSZ-+H4Wdj0T8kSFUJB56KVj9xFH3--JQ@mail.gmail.com>
 <20131220042426.GA21726@kroah.com>
Message-ID: <CAN1v_Pv-RRTW7cr5xNgAMySQrZi9zMxNjJfnKPi8fa3GUhGpNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Dec 19, 2013 at 07:41:13PM -0800, Ravi Patel wrote:
>> There is no need to talk to this driver from userspace.
>> It is a device which is used by other IO devices to communicate with each
>> other, including CPU.
>> For example, if CPU (software) wants to send a message to Ethernet HW (i.e.
>> send packet),
>> it used this driver to enqueue a message to Ethernet.
>> In other direction, if Ethernet HW receives a packet, it uses QM/TM device to
>> send message to
>> CPU (software) to process packet.
>
> So it's a "bus" type of thing, right?
>
> My question of "why isn't this reflected in the driver model" still
> stands.

There is no subsystem underneath QMTM, nor QMTM does any enumeration.
QMTM is a centralized resource manager which manages queues circularly
for Ethernet, PktDMA (XOR Engine) and Security Engine subsystems.
Traffic Management feature of QMTM does flow control, QoS for the subsystems.
Because of this reasons, its not obvious that QMTM can fit as a bus.
However we are doing further evalution on this.

Thanks,
Ravi
