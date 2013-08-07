From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 7 Aug 2013 16:35:46 +0200
Subject: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <5200E684.5080003@free-electrons.com>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
 <5200E684.5080003@free-electrons.com>
Message-ID: <20130807143546.GD2978@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> But we shouldn't use it alone: we should always use:
> compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> 
> From my point of view using  "marvell,mv78230-i2c" alone is an error.
> 
> Wolfram what is your opinion on it?

It is not strictly an error, but risky. If you use an older Kernel
version (or other OS) which only offers "mv64xxx" you will have no
match. Although the driver theoretically could have basic support for
all mv64xxx variants skipping all additional features of later IP
revisions.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/a53878e3/attachment.sig>
