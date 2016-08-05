From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 5 Aug 2016 15:25:47 +0800
Subject: [PATCH 1/3] dt/bindings: arm-pl330: add description of
 arm,pl330-periph-burst
In-Reply-To: <20160805033410.GJ9681@localhost>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
 <1470365602-32586-2-git-send-email-shawn.lin@rock-chips.com>
 <20160805033410.GJ9681@localhost>
Message-ID: <ea3572fa-4bff-87db-d5ad-f406809f8296@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

? 2016/8/5 11:34, Vinod Koul ??:
> On Fri, Aug 05, 2016 at 10:53:20AM +0800, Shawn Lin wrote:
>> This patch adds the "arm,pl330-periph-burst" for arm-pl330 to
>> support busrt mode.
>
> why should this be DT property. Only reason I can think of if some hw
> versions support this and some won't.

yes, if we want to support burst mode, both of the master(pl330) and
client(several peripherals) should implement it, otherwise it will
be broken when enabling.

So I mentioned it on my cover letter as the reason to introduce this
optional property. If people add this property and find it's ok for
their platform, they could land new dt-patch to add it. But we could
*not* presume that we could get all users involved in testing this
patchet. I don't wanna to break any other platforms, so it's needed.


Thanks.

>
> If all are supporting, please enable it everywhere for obvious reasons.
>


-- 
Best Regards
Shawn Lin
