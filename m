From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 29 Jul 2012 21:50:02 +0100
Subject: [PATCH 13/18] ARM: ux500: Add ux500 PCM to DB8500 Device Tree
In-Reply-To: <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
Message-ID: <20120729205001.GK4384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:45:57PM +0100, Lee Jones wrote:
> Nothing special here. We're only providing a compatible string
> to ensure the driver is probed using a Device Tree boot.

> +		pcm: ux500-pcm {
> +			compatible = "stericsson,ux500-pcm";
> +		};
> +

One of two things is wrong here.  Either you've not provided any
information about the hardware so the driver won't be able to work out
what to talk to or you've not provided any data so you're registering a
purely virtual Linux-internal device via the device tree.

Once more, the idea here is to describe the hardware not to dump Linux's
internal data structures into the device tree.
