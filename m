From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 11 Sep 2018 11:02:13 +0100
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
Message-ID: <20180911100213.GA29599@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 07:17:45PM +0000, Jolly Shah wrote:
> Hi All,
> 
> Adding more clarification on top of what Michal said:
> Here ioctl is not a system ioctl and just a eemi API like other interface
> APIs. It cannot be called from userspace.

I get that these are not system ioctl and you keep assuming that the issue
raised here is related to that. *NO*, the main issue is the way this so
called EEMI ioctl interface is exposing the users low level accessors
without much abstraction. IMO, it defeats the idea of having EEMI interface
altogether. There's abstraction but the level is not right. Anyways, this
gets worse with read/write debugfs interface you want to add.

> Only Linux drivers can use this
> API for defined ioctl operations. This API is meant for any platform
> specific operations which needs to be managed by firmware. Firmware will
> always validate the request for action being performed.

> Debugfs interface is just for debugging during development. We can remove
> debugfs support for ioctl API if you suggest.

Yes please. I did suggest to remove them long back. You did only for the
clock module but retained it in the core EEMI ioctl. But if you remove
the debugfs, do you have any users of these ioctl in the series ? I
couldn't find one, but if that's the case, drop this patch. I see only
valid users for clock APIs in this series.

--
Regards,
Sudeep
