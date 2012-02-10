From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 09 Feb 2012 20:21:45 -0800
Subject: [PATCH] pinctrl: changes hog mechanism to be self-referential
In-Reply-To: <1328834868-25030-1-git-send-email-linus.walleij@linaro.org>
References: <1328834868-25030-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4F349B59.6070104@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 04:47 PM, Linus Walleij wrote:
> Instead of a specific boolean field to indicate if a map entry shall
> be hogged, treat self-reference as an indication of desired hogging.
> This drops one field off the map struct and has a nice Douglas R.
> Hofstadter-feel to it.
> 
> Suggested-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt

> -PIN_MAP_PRIMARY_SYS_HOG("POWERMAP", "power_func")
> +PIN_MAP_PRIMARY_SYS_HOG("POWERMAP", "pinctrl-foo". "power_func")

That "." should be ",". Other than that,

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
