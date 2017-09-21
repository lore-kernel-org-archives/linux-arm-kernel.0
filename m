From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 21 Sep 2017 09:48:03 +0300
Subject: [PATCH v1] usb: host: Implement workaround for Erratum A-007463
In-Reply-To: <Pine.LNX.4.44L0.1709201004040.1563-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1709201004040.1563-100000@iolanthe.rowland.org>
Message-ID: <87fubg4kf0.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Alan Stern <stern@rowland.harvard.edu> writes:

> The Subject: line should specify which type of USB host controller the
> patch is for.  The kernel contains lots of different USB host
> controller drivers.  How are we supposed to know that Erratum A-007463
> applies to dwc3 xHCI controllers?
>
> The Subject: line should say something like:
>
> [PATCH v1] USB: host: dwc3: Implement workaround for Erratum A-007643

If we're talking about a dwc3 implementation, we need a quirk flag on
dwc3 core to be passed down to the xhci-plat device, like every other
quirk on this controller.

I also need a reference to SNPS stars ticket that talks about this problem.

-- 
balbi
