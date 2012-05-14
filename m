From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 May 2012 17:39:15 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <4FB12B73.50302@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FB12B73.50302@linaro.org>
Message-ID: <20120514163914.GB25668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 04:57:39PM +0100, Lee Jones wrote:
> >>  	pdata = dev_get_platdata(ab8500->dev);
> >>-	if (!pdata) {
> >>-		dev_err(&pdev->dev, "null pdata\n");
> >>+	if (!pdata&&  !np) {
> >>+		dev_err(&pdev->dev, "null pdata and no device tree found\n");
> >>  		return -EINVAL;
> >>  	}

> >Neither should be mandatory.

> Unfortunately, this has to reside, as without it I'd have to
> re-write the driver. Something with is completely out of scope of
> what I'm trying to achieve right now. It's something I'd be happy to
> do in the future, but not in this patch-set.

Why do you need to rewrite the driver?  That doesn't sound terribly
plausible...   The normal approach to this stuff is to allocate a
platform data struct unconditionally, why is this impossible in your
case?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/1788ebec/attachment.sig>
