From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Wed, 21 Mar 2018 14:53:16 -0700
Subject: [Intel-wired-lan] [PATCH REPOST v4 5/7] ixgbevf: keep writel()
 closer to wmb()
In-Reply-To: <c2ce63d1213b5145f77bf70f57c3360d@codeaurora.org>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
 <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
 <1521668888.12746.32.camel@intel.com>
 <c2ce63d1213b5145f77bf70f57c3360d@codeaurora.org>
Message-ID: <CAKgT0UcvtszFWLUWS_4KYaBn7QnKNtgiwgPzqV24Bb-jOncrfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 2:51 PM,  <okaya@codeaurora.org> wrote:
> On 2018-03-21 17:48, Jeff Kirsher wrote:
>>
>> On Wed, 2018-03-21 at 14:56 -0400, Sinan Kaya wrote:
>>>
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
>>
>> This patch fails to compile because there is a call to
>> ixgbevf_write_tail() which you missed cleaning up.
>
>
> Hah, I did a compile test but maybe I missed something. I will get v6 of
> this patch only and leave the rest of the series as it is.

Actually you might want to just pull Jeff's tree and rebase before you
submit your patches. I suspect the difference is the ixgbevf XDP code
that is present in Jeff's tree and not in Dave's. The alternative is
to wait for Jeff to push the ixgbevf code and then once Dave has
pulled it you could rebase your patches.

Thanks.

- Alex
