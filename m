From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Wed, 21 Mar 2018 18:14:52 -0400
Subject: [PATCH REPOST v4 5/7] ixgbevf: keep writel() closer to wmb()
In-Reply-To: <20180321.175427.1419929873765406157.davem@davemloft.net>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
 <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
 <1521668888.12746.32.camel@intel.com>
 <20180321.175427.1419929873765406157.davem@davemloft.net>
Message-ID: <bbaf3dadb8fb6469f49edae6ce6b7d48@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-21 17:54, David Miller wrote:
> From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Date: Wed, 21 Mar 2018 14:48:08 -0700
> 
>> On Wed, 2018-03-21 at 14:56 -0400, Sinan Kaya wrote:
>>> Remove ixgbevf_write_tail() in favor of moving writel() close to
>>> wmb().
>>> 
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>> ---
>>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
>>>  2 files changed, 2 insertions(+), 7 deletions(-)
>> 
>> This patch fails to compile because there is a call to
>> ixgbevf_write_tail() which you missed cleaning up.
> 
> For a change with delicate side effects, it doesn't create much
> confidence if the code does not even compile.
> 
> Sinan, please put more care into the changes you are making.

I think the issue is the tree that code is getting tested has 
undelivered code as Alex mentioned.

I was using linux-next 4.16 rc4 for testing.

I will rebase to Jeff's tree.

> 
> Thank you.
