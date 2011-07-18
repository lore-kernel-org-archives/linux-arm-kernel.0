From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 18 Jul 2011 11:15:27 -0600
Subject: [PATCH 1/2] Input: gpio-keys: do not reference platform_data
	after .probe exits
In-Reply-To: <201107181002.45170.dmitry.torokhov@gmail.com>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
	<1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
	<201107181002.45170.dmitry.torokhov@gmail.com>
Message-ID: <CACxGe6tFt4h-iVjM26BdD9oLj2Zd+z8i1naR0YU3AbLtGzmXgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 11:02 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
>> The patch makes a copy of platform data into driver data, so that any
>> reference to platform_data after .probe exits can be avoided.
>
> And why is this beneficial? I am of the opinion that platform data should
> stay on (and be accessed through a const pointer to ensure that the driver
> will not alter it).

Because when using the device tree, there is no platform_data.

g.
