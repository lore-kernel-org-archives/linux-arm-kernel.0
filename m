From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 01 Sep 2010 16:48:06 -0700
Subject: [PATCH 1/2 v2] msm: Install the Google-Android gpio driver.
In-Reply-To: <1283384380-24997-1-git-send-email-gbean@codeaurora.org>
References: <1283384380-24997-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1283384886.21049.28.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-01 at 16:39 -0700, Gregory Bean wrote:
> +void msm_gpio_enter_sleep(int from_idle)
> +{
> +       int i;
> +       struct tramp_gpio_smem *smem_gpio;
> +
> +       smem_gpio = smem_alloc(SMEM_GPIO_INT, sizeof(*smem_gpio));
> +
> +       if (smem_gpio) {
> +               for (i = 0; i < ARRAY_SIZE(smem_gpio->enabled); i++) {
> +                       smem_gpio->enabled[i] = 0;
> +                       smem_gpio->detection[i] = 0;
> +                       smem_gpio->polarity[i] = 0;
> +               }
> +       }
> + 

Can you not drop these for some reason ?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
