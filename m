From: davidb@codeaurora.org (David Brown)
Date: Thu, 9 Aug 2012 11:11:12 -0700
Subject: [PATCH 2/2] msm: io: Change the default static iomappings to be
 shared
In-Reply-To: <1343696061-11445-1-git-send-email-rvaswani@codeaurora.org>
References: <1343696061-11445-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <20120809181112.GA24633@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 05:54:21PM -0700, Rohit Vaswani wrote:
> With 3.4 kernel the static iomappings can be shared with the ioremap
> mappings. If ioremap is called with an address for which a static
> mapping already exists, then that mapping should be used instead
> of creating a new one.
> However, the MT_DEVICE_NONSHARED flag prevents this. Hence, get rid
> of this flag. Some targets (7X00) that require the static iomappings
> to be NONSHARED use the MSM_DEVICE_TYPE and MSM_CHIP_DEVICE_TYPE macros.
> 
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> ---
>  arch/arm/mach-msm/io.c |   25 +++++++++++++++++--------
>  1 files changed, 17 insertions(+), 8 deletions(-)

I don't seem to be able to find a tree that this change applies to.
Can you apply this patch to a recent kernel tree (v3.5 is good), and
resend.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
