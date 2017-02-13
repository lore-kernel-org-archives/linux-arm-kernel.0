From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 13 Feb 2017 14:55:08 -0600
Subject: [PATCH] efi/libstub/arm*: Set default address and size cells
 values for an empty dtb
In-Reply-To: <20170209082702.GC18445@linaro.org>
References: <1486490390-25251-1-git-send-email-jhugo@codeaurora.org>
 <CAKv+Gu963uZB4MaMDuwTGd5-AqEN53Er8tExVLMZNVx3krJrZw@mail.gmail.com>
 <1f47fcdd-c5d8-4082-70a3-ca9b1746d7ca@codeaurora.org>
 <20170207190113.GG26173@leverpostej>
 <c49cc64e-4ca1-8d82-5faf-74c0355c35ef@codeaurora.org>
 <20170207191320.GI26173@leverpostej>
 <252539a6-72f6-1afa-6ed5-3cf6a1aa24c2@codeaurora.org>
 <20170207195558.GK26173@leverpostej>
 <20170208074301.GB18445@linaro.org>
 <CAKv+Gu8OXn20JvtFkE_bS=cbWV3XZ5b7a+XaG7tvea+4BqrHfw@mail.gmail.com>
 <20170209082702.GC18445@linaro.org>
Message-ID: <CAOZdJXW7gN7_62KA93sz-9TtpDp-p52-j=yFt_X7N7F-N5ZE1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2017 at 2:27 AM, AKASHI, Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> is there a requirement that the root node must have #address-cells/
> #size-cells?
> I found such a statement, at least, in booting-without-of.txt
> (only applied to ppc? See III-5-a).

If you want to be able to represent 64-bit 'reg' addresses anywhere in
the device tree, then you will need #address-cells = <2> and
#size-cells = <2> at any appropriate location, which is usually the
root node for a 64-bit processor.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
