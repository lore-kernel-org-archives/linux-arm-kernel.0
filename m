From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 27 Apr 2012 18:47:10 +0530
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <20120427131010.GN24211@n2100.arm.linux.org.uk>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <1335514900.31825.132.camel@vkoul-udesk3>
 <20120427084109.GO28063@b20223-02.ap.freescale.net>
 <1335522130.31825.135.camel@vkoul-udesk3>
 <20120427112655.GS28063@b20223-02.ap.freescale.net>
 <20120427113335.GM24211@n2100.arm.linux.org.uk> <4F9A9899.2060306@nvidia.com>
 <20120427131010.GN24211@n2100.arm.linux.org.uk>
Message-ID: <4F9A9C56.6090301@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2012 06:40 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 27, 2012 at 06:31:13PM +0530, Laxman Dewangan wrote:
>> On Friday 27 April 2012 05:03 PM, Russell King - ARM Linux wrote:
>>> On Fri, Apr 27, 2012 at 07:26:56PM +0800, Richard Zhao wrote:
>>>> Sure, I mean, can you doc in include/linux/dmaengine.h that
>>>> dmaengine_prep_xxx may sleep?
>>> Incorrect.  They may _not_ sleep.
>> But I have seen that we are using the kzalloc in the dmaengine_prep_xxx
>> and kzalloc is sleeping call.
> Not with GFP_ATOMIC it isn't.

Yes, with GFP_ATOMIC , it will not be a sleeping calls.
I will fix my dma driver accordingly.
