From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 15:22:25 +0100
Subject: [PATCH 17/21] ASoC: Ux500: Enable ux500 PCM driver for Device Tree
In-Reply-To: <50114B89.7070100@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
 <20120726113838.GA3099@opensource.wolfsonmicro.com>
 <50114B89.7070100@linaro.org>
Message-ID: <20120726142225.GJ3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 02:52:09PM +0100, Lee Jones wrote:
> On 26/07/12 12:38, Mark Brown wrote:

> >>-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
> >>-	platform_device_register(&ux500_pcm);

> >This has the same issue as your last patch...  the way you're doing
> >things will break audio on all boards using this driver.

> It will, why?

You've just removed registration of the device and not added anything
else to replace that.  Even if all boards convert to DT their DTs will
need to be updated which you're not doing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/c696d23d/attachment-0001.sig>
