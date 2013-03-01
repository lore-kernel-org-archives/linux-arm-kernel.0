From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 1 Mar 2013 20:22:13 +0100
Subject: [PATCH v4 1/2] i2c-core: dt: Pick i2c bus number from i2c alias
 if present
In-Reply-To: <1362157052-16738-2-git-send-email-dianders@chromium.org>
References: <1360630085-26874-1-git-send-email-dianders@chromium.org>
 <1362157052-16738-1-git-send-email-dianders@chromium.org>
 <1362157052-16738-2-git-send-email-dianders@chromium.org>
Message-ID: <20130301192212.GA379@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 08:57:31AM -0800, Doug Anderson wrote:
> This allows you to get the equivalent functionality of
> i2c_add_numbered_adapter() with all data in the device tree and no
> special case code in your driver.  This is a common device tree
> technique.
> 
> For quick reference, the FDT syntax for using an alias to provide an
> ID looks like:
>   aliases {
>     i2c0 = &i2c_0;
>     i2c1 = &i2c_1;
>   };
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Thanks, applied. I'll try to get it into 3.9.

> +	/* Handled by wrappers */
> +	if (WARN_ON(adap->nr == -1))
> +		return -EINVAL;

I removed this check, though. We know our callers, all static.

Thanks,

   Wolfram
