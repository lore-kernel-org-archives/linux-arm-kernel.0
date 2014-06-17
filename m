From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 17 Jun 2014 10:33:50 +0900
Subject: [PATCH v3 -next 1/9] DMA, CMA: fix possible memory leak
In-Reply-To: <20140616062719.GA18790@bbox>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402897251-23639-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20140616062719.GA18790@bbox>
Message-ID: <20140617013349.GB6825@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 03:27:19PM +0900, Minchan Kim wrote:
> Hi, Joonsoo
> 
> On Mon, Jun 16, 2014 at 02:40:43PM +0900, Joonsoo Kim wrote:
> > We should free memory for bitmap when we find zone mis-match,
> > otherwise this memory will leak.
> > 
> > Additionally, I copy code comment from PPC KVM's CMA code to inform
> > why we need to check zone mis-match.
> > 
> > * Note
> > Minchan suggested to add a tag for the stable, but, I don't do it,
> > because I found this possibility during code-review and, IMO,
> > this patch isn't suitable for stable tree.
> 
> Nice idea to put the comment in here. Thanks Joonsoo.
> 
> It seems you obey "It must fix a real bug that bothers people"
> on Documentation/stable_kernel_rules.txt but it's a really obvious
> bug and hard to get a report from people because limited user and
> hard to detect small such small memory leak.
> 
> In my experince, Andrew perfered stable marking for such a obvious
> problem but simple fix like this but not sure so let's pass the decision
> to him and will learn a lesson from him and will follow the decision
> from now on.

Yes, I intended to pass the decision to others. :)

> 
> Thanks.
> 
> Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
