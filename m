From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Apr 2012 14:10:10 +0100
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <4F9A9899.2060306@nvidia.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <1335514900.31825.132.camel@vkoul-udesk3>
 <20120427084109.GO28063@b20223-02.ap.freescale.net>
 <1335522130.31825.135.camel@vkoul-udesk3>
 <20120427112655.GS28063@b20223-02.ap.freescale.net>
 <20120427113335.GM24211@n2100.arm.linux.org.uk> <4F9A9899.2060306@nvidia.com>
Message-ID: <20120427131010.GN24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 06:31:13PM +0530, Laxman Dewangan wrote:
> On Friday 27 April 2012 05:03 PM, Russell King - ARM Linux wrote:
>> On Fri, Apr 27, 2012 at 07:26:56PM +0800, Richard Zhao wrote:
>>> Sure, I mean, can you doc in include/linux/dmaengine.h that
>>> dmaengine_prep_xxx may sleep?
>> Incorrect.  They may _not_ sleep.
>
> But I have seen that we are using the kzalloc in the dmaengine_prep_xxx  
> and kzalloc is sleeping call.

Not with GFP_ATOMIC it isn't.
