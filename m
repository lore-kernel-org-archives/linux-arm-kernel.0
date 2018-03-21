From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Wed, 21 Mar 2018 17:51:23 -0400
Subject: [PATCH REPOST v4 5/7] ixgbevf: keep writel() closer to wmb()
In-Reply-To: <1521668888.12746.32.camel@intel.com>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
 <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
 <1521668888.12746.32.camel@intel.com>
Message-ID: <c2ce63d1213b5145f77bf70f57c3360d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-21 17:48, Jeff Kirsher wrote:
> On Wed, 2018-03-21 at 14:56 -0400, Sinan Kaya wrote:
>> Remove ixgbevf_write_tail() in favor of moving writel() close to
>> wmb().
>> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
>>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> This patch fails to compile because there is a call to
> ixgbevf_write_tail() which you missed cleaning up.

Hah, I did a compile test but maybe I missed something. I will get v6 of 
this patch only and leave the rest of the series as it is.
