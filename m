From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Aug 2013 18:17:31 +0200
Subject: [PATCH v6 2/4] i2c-mv64xxx: Fix timing issue on Armada XP
 (errata FE-8471889)
In-Reply-To: <1377181146-17341-2-git-send-email-gregory.clement@free-electrons.com>
References: <1377181146-17341-1-git-send-email-gregory.clement@free-electrons.com>
 <1377181146-17341-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130822161730.GB31704@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 04:19:06PM +0200, Gregory CLEMENT wrote:
> All the Armada XP (mv78230, mv78260 and mv78460) have a silicon issue
> in the I2C controller which violate the i2c repeated start
> timing. The I2C standard requires a minimum of 4.7us for the repeated
> start condition whereas the I2C controller of the Armada XP this time
> is 2.9us.
> 
> So this patch adds a 5us delay for the start case only if the
> the compatible i2c-mv78230 is set.
> 
> Based on the initals patches from Zbigniew Bodek
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/4c3d8f64/attachment.sig>
