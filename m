From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 31 Jul 2017 17:04:33 +0200
Subject: [PATCH] i2c: use dev_get_drvdata() to get private data in
 suspend/resume hooks
In-Reply-To: <1501172184-17102-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501172184-17102-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170731150433.hokceynz2j6eiu6j@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 01:16:24AM +0900, Masahiro Yamada wrote:
> Several drivers call to_platform_device() to get platform_device
> and pass it to platform_get_drvdata().  In platform_get_drvdata(),
> the platform_device is converted back to struct device again.
> 
> Use dev_get_drvdata() to avoid platform_device/device dance.

'dance' :D

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, and thanks for doing it subsystem wide!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/f69b109c/attachment-0001.sig>
