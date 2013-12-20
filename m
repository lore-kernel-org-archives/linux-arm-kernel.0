From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 19 Dec 2013 20:24:26 -0800
Subject: [PATCH 2/4] misc: xgene: Add base driver for APM X-Gene SoC
 Queue Manager/Traffic Manager
In-Reply-To: <CAN1v_PuBZHN85xTodfSZ-+H4Wdj0T8kSFUJB56KVj9xFH3--JQ@mail.gmail.com>
References: <1387507503-7565-1-git-send-email-rapatel@apm.com>
 <1387507503-7565-3-git-send-email-rapatel@apm.com>
 <20131220032133.GB32310@kroah.com>
 <CAN1v_PuBZHN85xTodfSZ-+H4Wdj0T8kSFUJB56KVj9xFH3--JQ@mail.gmail.com>
Message-ID: <20131220042426.GA21726@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


A: Top-posting.
Q: What is the most annoying thing in e-mail?

http://daringfireball.net/2007/07/on_top

On Thu, Dec 19, 2013 at 07:41:13PM -0800, Ravi Patel wrote:
> There is no need to talk to this driver from userspace.
> It is a device which is used by other IO devices to communicate with each
> other, including CPU.
> For example, if CPU (software) wants to send a message to Ethernet HW (i.e.
> send packet),
> it used this driver to enqueue a message to Ethernet.
> In other direction, if Ethernet HW receives a packet, it uses QM/TM device to
> send message to
> CPU (software) to process packet.

So it's a "bus" type of thing, right?

My question of "why isn't this reflected in the driver model" still
stands.

thanks,

greg k-h
