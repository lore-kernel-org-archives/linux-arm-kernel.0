From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 27 May 2013 10:11:07 +0300
Subject: [PATCH] dmatest: do not allow to interrupt ongoing tests
In-Reply-To: <Pine.LNX.4.64.1305242353210.7187@axis700.grange>
References: <1369308593-3723-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <Pine.LNX.4.64.1305242353210.7187@axis700.grange>
Message-ID: <1369638667.29283.197.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-05-24 at 23:55 +0200, Guennadi Liakhovetski wrote: 
> On Thu, 23 May 2013, Andy Shevchenko wrote:
> 
> > When user interrupts ongoing transfers the dmatest may end up with console
> > lockup, oops, or data mismatch. This patch prevents user to abort any ongoing
> > test.
> 
> Personally I would be against such a change. What about interrupting the 
> test with rmmod?
>  Is it still possible after this your patch or not? If not 
> - this doesn't seem like a good idea to me. Why don't we just fix those 
> bugs, that you're describing?

The behaviour of the module is returned to the same page by this patch
as it was before (w/o debugfs).

The user can interrupt tests by rmmod, but it will take time up to
timeout.

I appreciate if you can do a deeper analysis of what happened in
case Will reported.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
