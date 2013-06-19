From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 19 Jun 2013 12:24:17 +0200
Subject: [PATCH v2 1/2] i2c-mv64xxx: Fix timing issue on Armada XP
 (errata FE-8471889)
In-Reply-To: <1371570024-11613-2-git-send-email-gregory.clement@free-electrons.com>
References: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
 <1371570024-11613-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130619102416.GH2950@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 05:40:23PM +0200, Gregory CLEMENT wrote:
> From: Zbigniew Bodek <zbb@semihalf.com>
> 
> All the Armada XP (mv78230, mv78260 and mv78460) have a silicon issue
> in the I2C controller which violate the i2c repeated start
> timing. The I2C standard requires a minimum of 4.7us for the repeated
> start condition whereas the I2C controller of the Armada XP this time
> is 2.9us.
> 
> So this patch adds a 5us delay for the start case only if the
> mv64xxx_i2c_errata_delay flag is set.

You are correct that this does not need a seperate property since this
is a flaw of this specific controller. So, it needs a new compatible
entry ('mv78230-i2c' for example) and this entry should then have the
workaround enabled.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/e92d3c7b/attachment.sig>
