From: rric@kernel.org (Robert Richter)
Date: Tue, 20 Sep 2016 15:21:20 +0200
Subject: [PATCH] arm64, numa: Add cpu_to_node() implementation.
In-Reply-To: <57E11E52.8060303@linaro.org>
References: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
 <20160920104348.GP25086@rric.localdomain>
 <57E11E52.8060303@linaro.org>
Message-ID: <20160920132120.GQ25086@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.09.16 19:32:34, Hanjun Guo wrote:
> On 09/20/2016 06:43 PM, Robert Richter wrote:

> >Unfortunately either your nor my code does fix the BUG_ON() I see with
> >the numa kernel:
> >
> >  kernel BUG at mm/page_alloc.c:1848!
> >
> >See below for the core dump. It looks like this happens due to moving
> >a mem block where first and last page are mapped to different numa
> >nodes, thus, triggering the BUG_ON().
> 
> Didn't triggered it on our NUMA hardware, could you provide your
> config then we can have a try?

Config attached. Other configs with an initrd fail too.

-Robert
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-4.8.0-rc5.vanilla5.xz
Type: application/x-xz
Size: 35316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160920/8f9a3512/attachment-0001.xz>
