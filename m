From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 17 May 2011 23:45:52 -0700
Subject: [PATCH 1/2] pwm: Add stubs for pwm operations
In-Reply-To: <1305695926-25855-2-git-send-email-mpallaka@codeaurora.org>
References: <1305695926-25855-1-git-send-email-mpallaka@codeaurora.org>
	<1305695926-25855-2-git-send-email-mpallaka@codeaurora.org>
Message-ID: <20110518064552.GA31801@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 10:48:45AM +0530, Mohan Pallaka wrote:
> Chip drivers that support both pwm and non-pwm modes
> would encounter compilation errors if the platform doesn't
> have support for pwm, even though the chip is programmed
> to work in non-pwm mode. Add stubs for pwm functions to
> avoid compilation errors in these scenarios.
> 
> Signed-off-by: Mohan Pallaka <mpallaka@codeaurora.org>
> ---
>  include/linux/pwm.h |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 7c77575..f0bc51f 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -3,6 +3,7 @@
>  
>  struct pwm_device;
>  
> +#if defined(CONFIG_PWM)

Shouldn't it be CONFIG_HAVE_PWM?

Thanks.

-- 
Dmitry
