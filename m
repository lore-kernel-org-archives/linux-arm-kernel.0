From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:38:38 +0100
Subject: [PATCH 17/21] ASoC: Ux500: Enable ux500 PCM driver for Device Tree
In-Reply-To: <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
Message-ID: <20120726113838.GA3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:28:50AM +0100, Lee Jones wrote:

> Here we pass platform registration from platform code over to Device
> Tree, when DT is enabled.

> -	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
> -	platform_device_register(&ux500_pcm);

This has the same issue as your last patch...  the way you're doing
things will break audio on all boards using this driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/51c986f3/attachment-0001.sig>
