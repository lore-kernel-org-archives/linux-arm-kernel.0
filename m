From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 12 Sep 2014 15:13:34 -0700
Subject: [PATCH RESEND v9 5/5] rtc: Add driver for Maxim 77802 PMIC
 Real-Time-Clock
In-Reply-To: <1410509864-10019-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1410509864-10019-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410509864-10019-6-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140912151334.cd53fca611a7de487f23241b@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Sep 2014 10:17:43 +0200 Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:

> The MAX7802 PMIC has a Real-Time-Clock (RTC) with two alarms.
> This patch adds support for the RTC and is based on a driver
> added by Simon Glass to the Chrome OS kernel 3.8 tree.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Would it be appropriate to gather Simon's signoff?

> +static inline int max77802_rtc_calculate_wday(u8 shifted)
> +{
> +	int counter = -1;
> +
> +	while (shifted) {
> +		shifted >>= 1;
> +		counter++;
> +	}

Can't use log2() or similar?

> +	return counter;
> +}
