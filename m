From: rric@kernel.org (Robert Richter)
Date: Thu, 6 Oct 2016 11:15:22 +0200
Subject: [PATCH] arm64, numa: Add cpu_to_node() implementation.
In-Reply-To: <57EA1100.2080900@linaro.org>
References: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
 <20160920104348.GP25086@rric.localdomain>
 <57E11E52.8060303@linaro.org>
 <20160920132120.GQ25086@rric.localdomain>
 <57EA1100.2080900@linaro.org>
Message-ID: <20161006091522.GJ1535@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.09.16 14:26:08, Hanjun Guo wrote:
> On 09/20/2016 09:21 PM, Robert Richter wrote:
> >On 20.09.16 19:32:34, Hanjun Guo wrote:
> >>On 09/20/2016 06:43 PM, Robert Richter wrote:
> >
> >>>Unfortunately either your nor my code does fix the BUG_ON() I see with
> >>>the numa kernel:
> >>>
> >>>  kernel BUG at mm/page_alloc.c:1848!
> >>>
> >>>See below for the core dump. It looks like this happens due to moving
> >>>a mem block where first and last page are mapped to different numa
> >>>nodes, thus, triggering the BUG_ON().
> >>
> >>Didn't triggered it on our NUMA hardware, could you provide your
> >>config then we can have a try?
> >
> >Config attached. Other configs with an initrd fail too.
> 
> hmm, we can't reproduce it on our hardware, do we need
> to run some specific stress test on it?

No, it depends on the efi memory zones marked reserved. See my other
thread on this where I have attached mem ranges from the log. I have a
fix available already.

Thanks,

-Robert
