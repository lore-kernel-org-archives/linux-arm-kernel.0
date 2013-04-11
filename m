From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Apr 2013 14:48:03 -0700
Subject: [PATCH 1/4] Documentation: Add memory mapped ARM architected
 timer binding
In-Reply-To: <20130411112407.GD8259@e106331-lin.cambridge.arm.com>
References: <1365474623-29181-1-git-send-email-sboyd@codeaurora.org>
 <1365474623-29181-2-git-send-email-sboyd@codeaurora.org>
 <20130409090843.GS23725@e106331-lin.cambridge.arm.com>
 <516444FE.2080200@codeaurora.org>
 <20130410101336.GB8799@e106331-lin.cambridge.arm.com>
 <51662584.6070906@codeaurora.org>
 <20130411112407.GD8259@e106331-lin.cambridge.arm.com>
Message-ID: <51672F93.7080109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/13 04:24, Mark Rutland wrote:
> Could we say the reg for the second view is optional?
>

Yes, that's already covered in the binding.

> Might we have a hardware / firmware configuration where the kernel can only access
> the secondary view?
>

I don't see how this is possible. The CNTACRn register controls secure
vs. non-secure access for particular registers in a frame regardless of
which view is used. The CNTPL0ACRn is not a security restricted register
and it can only restrict access to certain registers in the second view.
No combination of settings in these registers can restrict access to
only the second view in a frame with two views.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
