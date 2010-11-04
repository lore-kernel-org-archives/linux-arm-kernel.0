From: zonque@gmail.com (Daniel Mack)
Date: Thu,  4 Nov 2010 14:43:59 -0400
Subject: PXA3xx 2D graphics accelerator
Message-ID: <1288896241-8318-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Here's a rebased driver for the PXA3xx 2D graphics accelerator unit
which acts as backend for the DirectFB userspace library. All the magic
is in userspace, the driver is kept as simple as possible.

It's been awhile since I last proposed taking this code mainline, and
in the meantime, the DirectFB people further improved the userspace
driver part and fixed some bugs which I suspected to be problems
related to this kernel driver. It's all good now, and the thing is
ready for production use.

The only concern is that the API this driver implements is proprietary.
But given that there is currently no better, more generic way, I think
we can re-address this later. It would be fine to change the API at a
later point as long as we keep the old interface around in userspace
for backward compatibility.

If anyone happens to have a system based on these SoCs with a display
attached, please give it a try :)

Daniel

[PATCH 1/2] video: add driver for PXA3xx 2D graphics accelerator
[PATCH 2/2] ARM: pxa/raumfeld: enable PXA3XX_GCU driver
