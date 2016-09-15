From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Sep 2016 16:41:40 +0100
Subject: next-20160915 build: 2 failures 16 warnings (next-20160915)
In-Reply-To: <E1bkV4u-0004AY-TY@optimist>
References: <E1bkV4u-0004AY-TY@optimist>
Message-ID: <20160915154140.GM27974@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 12:43:41PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build both arm and arm64 allmodconfigs due to:

> 	arm64-allmodconfig
> ERROR: "musb_root_disconnect" [drivers/usb/musb/sunxi.ko] undefined!

> 	arm-allmodconfig
> ERROR: "musb_root_disconnect" [drivers/usb/musb/sunxi.ko] undefined!

due to 7cba17ec9adc8cf (musb: sunxi: Add support for platform_set_mode)
which adds a call to that non-exported function to a module.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160915/0d4087c8/attachment.sig>
