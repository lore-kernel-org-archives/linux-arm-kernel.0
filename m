From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 18 May 2011 17:44:39 -0500
Subject: [PATCH 5/7] msm: gpiomux: Move public API to public header
In-Reply-To: <1305755453-31112-6-git-send-email-davidb@codeaurora.org>
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
	<1305755453-31112-6-git-send-email-davidb@codeaurora.org>
Message-ID: <0D753D10438DA54287A00B027084269764D2F7405A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 18, 2011 2:51 PM, David Brown wrote:
>
> The gpiomux.h header contains some SOC ifdefs.  However, the API that
> is actually used by the GPIO driver only uses two functions that are
> general.  Move these general definitions into a public header file.
>
> Signed-off-by: David Brown <davidb@codeaurora.org>
> ---
>  arch/arm/mach-msm/gpio.c    |    2 +-
>  arch/arm/mach-msm/gpiomux.h |   17 +----------------
>  include/linux/msm_gpiomux.h |   38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 17 deletions(-)
>  create mode 100644 include/linux/msm_gpiomux.h

The msm_gpiomux.h header appears to be very "msm" specific, especially
with the #ifdef CONFIG_MSM_GPIOMUX in it.  Wouldn't it be cleaner to
just move it to arch/arm/mach-msm/include/mach/msm_gpiomux.h?

I don't see a reason why this header needs/should be available for
the general public in /include/linux.

Regards,
Hartley
