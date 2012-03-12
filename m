From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 16:12:18 +0000
Subject: [PATCH 5/5] mmc: sdhci-s3c: setup pins using pinctrl interface
In-Reply-To: <CAJuYYwQ=vhcrbH3gsMBuLG1D_p=mx_RFbN86+ETPT4bLYrRgEA@mail.gmail.com>
References: <1331469965-28846-1-git-send-email-thomas.abraham@linaro.org>
 <1331469965-28846-6-git-send-email-thomas.abraham@linaro.org>
 <20120312142143.GC14020@sirena.org.uk>
 <CAJuYYwQ=vhcrbH3gsMBuLG1D_p=mx_RFbN86+ETPT4bLYrRgEA@mail.gmail.com>
Message-ID: <20120312161218.GK3110@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 08:01:34PM +0530, Thomas Abraham wrote:

> Yes, I agree with your comment. I did refer to manuals of s3c24xx to
> Exynos to ensure that the samsung pinctrl driver is generic and
> reusable on all samsung soc's. I hope I have not missed out something
> important that would require additional tweaks in the samsung pinctrl
> driver. The missing bits now are gpio interrupt and wakeup interrupt
> support in the samsung pinctrl driver. Once that is complete, I
> believe it should be easy to add support for other SoC and convert the
> drivers to use pinctrl (other option being to let pinctrl driver hog
> all the mappings at boot and remove the cfg_gpio platform callbacks
> from the driver).

Yes, I don't see any fundamental problems here - it's more that either
we'll need to get all the SoCs converted over (which is a lot of work)
or we'll need to have drivers be able to cope with running either way.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/57245f07/attachment.sig>
