From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 17 Sep 2012 13:18:30 +0300
Subject: [PATCH v3] USB: mxs-phy: add basic otg support
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C8293E@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1347872703-15167-1-git-send-email-richard.zhao@freescale.com>
 <F281D0F91ED19E4D8E63A7504E8A649803C8293E@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <87mx0par61.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen Peter-B29397 <B29397@freescale.com> writes:

> The purpose for this patch is to have set_peripheral implementation,
> but in current chipidea code, we don't need to know gadget at all,
> as when id switch occurs, the core code know its role (device or host)
> very well, and will call related stop/start function.
>
> We have already many code bind struct otg with struct phy, we'd better
> split them at later code.
>  
> A better approach to fix this problem is to either not call set_peripheral
> if both device and host use chipidea driver, or implement otg struct
> at chipidea driver.

Yes, I think the otg driver should be part of the chipidea driver, the
only concern is the msm, although it can probably be converted once we
have an otg driver. I'll have a look at it soon unless someone beats me
to it.

The bigger plan was to implement a generic otg framework and base the
chipidea's otg driver on that, instead of dragging in one more state
machine and whatnot.

Regards,
--
Alex
