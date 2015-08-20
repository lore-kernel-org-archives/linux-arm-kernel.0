From: agross@codeaurora.org (Andy Gross)
Date: Thu, 20 Aug 2015 12:20:10 -0500
Subject: [PATCH] ARM: Set proper TEXT_OFFSET for IPQ806x
In-Reply-To: <20150820130005.GS7557@n2100.arm.linux.org.uk>
References: <20150820121541.GA14664@codeaurora.org>
 <20150820130005.GS7557@n2100.arm.linux.org.uk>
Message-ID: <20150820172010.GB10796@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:00:06PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 20, 2015 at 05:45:41PM +0530, Varadarajan Narayanan wrote:
> > RAM starts at 0x40000000 for IPQ. The lower 21MB of RAM is used
> > for Shared Memory and the kernel can start from 0x41500000.
> 
> Why do people keep creating crap like this?  Each time something like
> this is created, it means that you _need_ to have a special kernel for
> your platform and you can't be part of the single zImage.
> 
> Please, rather than creating crap like this, find a better way.

In the case of the IPQ, we don't use the zImage because the decompress requires
a larger jump than we can do on that platform.  Having this change at least gets
us back 2MB of memory.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
