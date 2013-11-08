From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Nov 2013 12:04:34 -0500
Subject: [PATCH] ARM: Save/Restore 64-bit TTBR registers on LPAE
 suspend/resume
In-Reply-To: <1383873633-2499-1-git-send-email-sboyd@codeaurora.org>
References: <1383873633-2499-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <527D19A2.5050604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 November 2013 08:20 PM, Stephen Boyd wrote:
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> LPAE enabled kernels use the 64-bit version of TTBR0 and TTBR1
> registers. If we're running an LPAE kernel, fill the upper half
> of TTBR0 with 0 because we're setting it to the idmap here (the
> idmap is guaranteed to be < 4Gb) and fully restore TTBR1 instead
> of just restoring the lower 32 bits. Failure to do so can cause
> failures on resume from suspend when these registers are only
> half restored.
> 
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
Looks like the trick of TTBR1 as discussed on irc worked for you.
Patch looks good to me. 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
