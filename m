From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Oct 2015 00:52:09 -0700
Subject: [PATCH v2 3/4] ARM: dts: DRA7: Add timer12 node
In-Reply-To: <87y4fgesbz.fsf@saruman.tx.rr.com>
References: <1444087704-1429-1-git-send-email-s-anna@ti.com>
 <1444087704-1429-4-git-send-email-s-anna@ti.com>
 <87y4fgesbz.fsf@saruman.tx.rr.com>
Message-ID: <20151006075209.GH23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [151005 17:51]:
> 
> according to Tony we should avoid using status at all for in-SoC
> devices.
> 
> Tony, can you confirm I understood you correctly ?

Yes. With status = "disabled" kernel completely ignores the
device and struct device is not created at all even with the
device being there. In general we're better off trying to
probe the device and idle it.

The only time we really want to mark something with
status = "disabled" is if some coprocessor firmware is
using that device and the kernel should not touch it at
all.

Regards,

Tony
