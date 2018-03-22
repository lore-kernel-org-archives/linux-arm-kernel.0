From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 22 Mar 2018 11:28:29 -0500
Subject: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
Message-ID: <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/22/2018 9:52 AM, Sinan Kaya wrote:
> On 3/22/2018 9:40 AM, Steve Wise wrote:
>> I think all these iw_cxgb4 changes should be reverted until we really have a
>> plan for multi-platform that works.  
> I know you are looking to have support for PowerPC. 
>
> Isn't this a PowerPC problem? Why penalize other architectures?
>
> Do you see anything wrong with the code itself?

I worry it breaks PPC.

> I started this thread with the PowerPC develoeprs on your request.
> "RFC on writel and writel_relaxed"
>
> They are looking into adding the relaxed API support. Support can come
> in later. Why block this change now?
>
> benh at kernel.crashing.org:
> "I've been wanting to implement the relaxed accessors for a while but
> was battling with this to try to also better support WC, and due to
> other commitments, this somewhat fell down the cracks."
>
> I have seen four different responses on this thread. Since this is an
> architecture change it will take a while to get the semantics right.
> It won't happen in the new few days.

I appreciate you doing this.
