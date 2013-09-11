From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 10:55:52 +0100
Subject: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
In-Reply-To: <522FC0DC.9030708@intel.com>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
 <20130910213522.GG29403@sirena.org.uk>
 <2029393.u6DaKBPszu@vostro.rjw.lan> <522FC0DC.9030708@intel.com>
Message-ID: <20130911095552.GI29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 09:01:16AM +0800, Aaron Lu wrote:

> Looks like, it all boils down to how many I2C devices should be allowed
> for runtime PM by default and how many I2C devices should be forbidden.
> , and then we allow/forbid runtime PM for the majority case in I2C core
> while individual driver can still forbid/allow it in their own code.

> So if the majority case is runtime PM should be allowed by default, I'm
> also OK to not forbid runtime PM for I2C client device in I2C core. My
> original intention to forbid runtime PM by default is to make sure no
> adverse effect would occur to some I2C devices that used to work well
> before runtime PM.

The really big problem here is that there are I2C devices currently
using runtime PM quite happily and forbidding it by default will break
them.

In general though requiring userspace to manually activate power saving
features isn't going to make people happy.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/7075d10b/attachment.sig>
