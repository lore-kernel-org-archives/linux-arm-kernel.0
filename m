From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 12 Jun 2014 14:55:55 +0900
Subject: [PATCH v2 01/10] DMA, CMA: clean-up log message
In-Reply-To: <20140612051853.GD12415@bbox>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612051853.GD12415@bbox>
Message-ID: <20140612055555.GB30128@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 02:18:53PM +0900, Minchan Kim wrote:
> Hi Joonsoo,
> 
> On Thu, Jun 12, 2014 at 12:21:38PM +0900, Joonsoo Kim wrote:
> > We don't need explicit 'CMA:' prefix, since we already define prefix
> > 'cma:' in pr_fmt. So remove it.
> > 
> > And, some logs print function name and others doesn't. This looks
> > bad to me, so I unify log format to print function name consistently.
> > 
> > Lastly, I add one more debug log on cma_activate_area().
> 
> When I take a look, it just indicates cma_activate_area was called or not,
> without what range for the area was reserved successfully so I couldn't see
> the intention for new message. Description should explain it so that everybody
> can agree on your claim.
> 

Hello,

I paste the answer in other thread.

This pr_debug() comes from ppc kvm's kvm_cma_init_reserved_areas().
I want to maintain all log messages as much as possible to reduce
confusion with this generalization.

If I need to respin this patchset, I will explain more about it.

Thanks.
