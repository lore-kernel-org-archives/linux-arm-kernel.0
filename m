From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 11 Oct 2012 17:52:26 -0700
Subject: [PATCH 2/2] ARM: unwind: enable dumping stacks for SMP &&
 ARM_UNWIND
In-Reply-To: <1346021216-21979-3-git-send-email-ccross@android.com>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
 <1346021216-21979-3-git-send-email-ccross@android.com>
Message-ID: <507769CA.6090903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 8/26/2012 3:46 PM, Colin Cross wrote:
> Unwinding with CONFIG_ARM_UNWIND is much more complicated than
> unwinding with CONFIG_FRAME_POINTER, but there are only a few points
> that require validation in order to avoid faults or infinite loops.
> Avoiding faults is easy by adding checks to verify that all accesses
> relative to the frame's stack pointer remain inside the stack.
>
> When CONFIG_FRAME_POINTER is not set it is possible for two frames to
> have the same SP, so there is no way to avoid repeated calls to
> unwind_frame continuing forever.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---

This is a feature we've wanted for a long time. I ran some test with 
repeated catting of stacks with processes dying and the results looked good.

You can add a Tested-by: Laura Abbott <lauraa@codeaurora.org>

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
