From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jan 2016 13:44:52 +0000
Subject: [PATCH] regulator: mt6397: convert to arch_initcall
In-Reply-To: <1450944643.30352.9.camel@mtksdaap41>
References: <1450865768-10317-1-git-send-email-henryc.chen@mediatek.com>
 <20151223120019.GU16023@sirena.org.uk>
 <1450944643.30352.9.camel@mtksdaap41>
Message-ID: <20160105134452.GE16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 04:10:43PM +0800, Yingjoe Chen wrote:

> These changes are related to pinctrl init order patch. The related
> discussion is here:
> http://lists.infradead.org/pipermail/linux-mediatek/2015-December/003298.html

So this is just to cut down on probe deferrals?  Sorry but as you'll see
from the discussion in that thread I'm really not enthusiastic about
taking such patches.  Trying to use initcall ordering is a hack we're
moving towards removing, isn't very robust and makes it harder to
convince people that it's worth doing anything to really improve things.

> I think Henry use arch_initcall because that's what pinctrl patch was
> using. In this case, we should use subsys_initcall for all these.

But why?  This sort of random unexplained level picking is part of the
problem...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160105/a94a7790/attachment.sig>
