From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Dec 2014 10:29:17 -0800
Subject: [PATCH 2/3] mmc: dw_mmc: Generic MMC tuning with the clock phase
 framework
In-Reply-To: <CAD=FV=WhB84enspDCHwkc2TqEFeAr_qiY4m_xYvMYCArUAtPXw@mail.gmail.com>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
 <1418943663-10012-3-git-send-email-amstan@chromium.org>
 <CAD=FV=WhB84enspDCHwkc2TqEFeAr_qiY4m_xYvMYCArUAtPXw@mail.gmail.com>
Message-ID: <54946E7D.1010500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2014 04:20 PM, Doug Anderson wrote:
> Alex,
>
> On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
>> +       blk_test = kmalloc(blksz, GFP_KERNEL);
>> +       if (!blk_test)
>> +               return -ENOMEM;
>> +
>> +       ranges = kmalloc(((NUM_PHASES / 2 + 1) * sizeof(ranges)), GFP_KERNEL);
> sizeof(*ranges)
>
>
> Other than that, this looks good to me and you can add my reviewed-by
> when the above is fixed.
>
>

Might want to use kmalloc_array() too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
