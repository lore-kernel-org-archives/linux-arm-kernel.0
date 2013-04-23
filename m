From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Apr 2013 16:15:12 +0100
Subject: [PATCH 1/3] spi: s3c64xx: added support for polling mode
In-Reply-To: <1366614565-3743-2-git-send-email-ks.giri@samsung.com>
References: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
 <1366614565-3743-2-git-send-email-ks.giri@samsung.com>
Message-ID: <20130423151511.GR5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:39:23PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
> 
> The 64xx spi driver supports partial polling mode.
> Only the last chunk of the transfer length is transferred
> or recieved in polling mode.

This appears to have a very noticable negative impact on SPI performance
on my S3C6410 based system.  Not delved into it to test why but are you
sure it's not mistakenly selecting polling?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/8081cceb/attachment.sig>
