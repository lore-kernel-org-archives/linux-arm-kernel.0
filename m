From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 7 Mar 2018 12:26:57 +0900
Subject: [PATCH v7 13/14] iommu/rockchip: Add runtime PM support
In-Reply-To: <5A9F598E.4020704@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-4-jeffy.chen@rock-chips.com>
 <CAAFQd5DPewKda7ThqMGKRvnArZ0X8ChD10E06nLZaNa-SBNdwA@mail.gmail.com>
 <5A9F598E.4020704@rock-chips.com>
Message-ID: <CAAFQd5CM+7=RrJ_3OBmpHWAOA4VnxL24j=w-wMobjm_cVd5K3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 12:16 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
> On 03/06/2018 06:07 PM, Tomasz Figa wrote:
>>
>> Hi Jeffy,
>>
>> It looks like I missed some details of how runtime PM enable works
>> before, so we might be able to simplify things. Sorry for not getting
>> things right earlier
>
>
> hmm, right, the enable state should be the same during those functions. will
> do it in the next version.

Thanks. I actually realized that we don't even need the
pm_runtime_enabled() checks either.

Actually, we can clean this up in an incremental patch, so no need to
resend if no other changes needed, since current code is still
technically correct.

Best regards,
Tomasz
