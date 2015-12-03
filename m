From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 07:47:59 -0800
Subject: [PATCH v3 0/3] soc: ti: Introduce wkup_m3_ipc driver
In-Reply-To: <565F54C1.8090407@ti.com>
References: <1442967294-23837-1-git-send-email-d-gerlach@ti.com>
 <20151020161843.GE3078@atomide.com> <565F54C1.8090407@ti.com>
Message-ID: <20151203154759.GK23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [151202 12:30]:
> On 10/20/2015 11:18 AM, Tony Lindgren wrote:
> >* Dave Gerlach <d-gerlach@ti.com> [150922 17:20]:
> >>This series is version 3 of the code to introduce a wkup_m3_ipc driver
> >>to handle communication between the MPU and Cortex M3 present on TI AM335x
> >>and AM437x SoCs. v2 of this series can be found at [1]. Only patch 3
> >>has been changed based on a request from Tony and a few cleanups:
> >>
> >>- Rather than exporting all of the functionality of the driver, added
> >>   wkup_m3_ipc_get and wkup_m3_ipc_put to allow users to just get a handle
> >>   containing an ops structure for use.
> >>
> >>- Changed all ops (previously exported functions) to take pointer to
> >>   struct wkup_m3_ipc as an argument now that user code will get this
> >>   from wkup_m3_ipc_get.
> >>
> >>- General cleanup to probe function
> >>
> >>- Added MODULE_DEVICE_TABLE so driver can probe automatically.
> >>
> >>The series containing the DT nodes can be found here [2]. The actual dt
> >>nodes for wkup_m3_ipc (last two patches) have been merged but discussion
> >>is still open for the ti,mbox-send-noirq flag patches and depends on the
> >>comments provided for the omap-mailbox change presented in patch 1 of
> >>this series.
> >>
> >>A full branch containing all necessary PM code for both am335x and am437x
> >>has been pushed here [3] to provide a big picture view of the plan for
> >>this series.
> >>
> >>This driver relies on the firmware at [4] in the next-upstream branch
> >>being present in /lib/firmware in the rootfs or built in to the kernel.
> >
> >Anybody got comments on this one? Should I pick up this series or
> >what's the plan?
> 
> Now that Patch 1 has been merged [1] can patch 2 and 3 be picked up? These
> apply cleanly on v4.4-rc3.

OK applying 1 & 2 into omap-for-v4.5/drivers.

Regards,

Tony

> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8e3c5952144f045a0c81bf674d3f5e1d9aafceb7
