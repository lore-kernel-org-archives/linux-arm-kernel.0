From: davidb@codeaurora.org (David Brown)
Date: Thu, 25 Aug 2011 08:12:10 -0700
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <CACRpkdaZfG4hiGf8vug3EGMRMc0c92xbj=L_HAQcS27DAXYc4Q@mail.gmail.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3BC0@HQMAIL01.nvidia.com>
	<CACRpkdaZfG4hiGf8vug3EGMRMc0c92xbj=L_HAQcS27DAXYc4Q@mail.gmail.com>
Message-ID: <20110825151210.GC31331@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 12:12:59PM +0200, Linus Walleij wrote:

> mach-msm:
> ----------------
> 
> Hard to tell how this works and what's available, support
> seems to be incomplete. Currently it seems to be wired
> to do either a dedicated function (like some UART pin)
> or GPIO, like each pin can be used for two specific
> things, and not phone-exchange type.

There are some pins on MSMs that can be connected to different hw
blocks, we just haven't gotten the support into the kernel yet.

There are some things where two devices share pins, and you have to
choose one or the other.

I believe there are also configurations where something such as the SD
controller can either be configured in 8-bit data mode, or in 4-bit
data mode, and those 4 pins connected to something else.

Much of the current pin configuration in our product kernel seems to
be about current and pull up/down configuration.

I've added Rohit Vaswani, and Greg Bean to this thread who should have
a bit better understanding of this.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
