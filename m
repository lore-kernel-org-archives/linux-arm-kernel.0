From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 18 Jul 2011 10:02:44 -0700
Subject: [PATCH 1/2] Input: gpio-keys: do not reference platform_data
	after .probe exits
In-Reply-To: <1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
	<1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201107181002.45170.dmitry.torokhov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
> The patch makes a copy of platform data into driver data, so that any
> reference to platform_data after .probe exits can be avoided.

And why is this beneficial? I am of the opinion that platform data should
stay on (and be accessed through a const pointer to ensure that the driver
will not alter it).

Thanks.

-- 
Dmitry
